-- This file is part of easyFPGA.
-- Copyright 2013-2015 os-cillation GmbH
--
-- easyFPGA is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- easyFPGA is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with easyFPGA.  If not, see <http://www.gnu.org/licenses/>.

-------------------------------------------------------------------------------
-- F R A M E    C O N T R O L L E R    (frame_ctrl.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;
-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------
entity frame_ctrl is
   port (
      clk   : in std_logic;
      rst   : in std_logic;
      d     : in frame_ctrl_in_type;
      q     : out frame_ctrl_out_type;
      wbi   : in  wbm_in_type;
      wbo   : out wbm_out_type
   );
end frame_ctrl;

architecture two_proc of frame_ctrl is

   type state_type is (
      idle,          -- initial/reset state
      opcode_check,  -- check opcode, store frame id and check parity

      -- parity check fails or opcode unknown
      nack0,         -- initiate transmission of NACK
      nack1,         -- wait until transmission done

      -- acknowledge
      ack0,          -- initiate transmission of an ACK frame
      ack1,          -- wait until transmission done

      -- MCU_SEL
      mcu_select0,   -- send reply
      mcu_select1,   -- wait until transmitted
      mcu_select2,   -- assert mcu select flag (enable_ctrl)

      -- DETECT
      detect0,       -- send reply
      detect1,       -- wait until transmitted

      -- REGISTER_WR
      wr_init,    -- send register write command and wait until acknowledged
      wr_finish,  -- finally clear receive buffer

      -- For both MWR and AWR
      multi_init,    -- store total length, store full register address

      -- REGISTER_MWR (writing multiple values in a row into one register)
      mwr_process,   -- 1st wishbone cycle step, central state
      mwr_write1,    -- 2nd wishbone cycle step, write data
      mwr_write2,    -- 3rd wishbone cycle step, de-assert control signals and return to reg_mwr_init
      mwr_flush,     -- flush rx buffer
      mwr_wait,      -- wait until receive buffer has further data

      -- REGISTER_AWR (auto-address increment, writing multiple values in multiple adjacent registers)
      awr_process,   -- 1st wishbone cycle step, central state
      awr_write1,    -- 2nd wishbone cycle step, write data
      awr_write2,    -- 3rd wishbone cycle step, de-assert control signals and return to reg_mwr_init
      awr_flush,     -- flush rx buffer
      awr_wait,      -- wait until receive buffer has further data

      -- REGISTER_RD
      rd_init,
      rd_buffer,
      rdre_init,
      rdre_finish,

      -- REGISTER_MRD (multi-read: read a single register multiple times)
      mrd_init1,     -- send opcode and id, store address and length
      mrd_init2,     -- wait until tx buffer is done with opcode and id, clear rx buffer
      mrd_process,   -- 1st wishbone cycle step, central state
      mrd_read1,     -- 2nd wishbone read cycle step, read data
      mrd_read2,     -- 3rd wishbone read cycle step, reset control signals and increment counters
      mrdre_forward, -- send data that were buffered in mrd_process
      mrdre_wait,    -- wait until tx buffer is done
      mrd_finish1,   -- init sending parity
      mrd_finish2,   -- wait until parity sent

      -- REGISTER_ARD (auto-address-increment, reading multiple adjacent registers)
      ard_init1,     -- send opcode and id, store start address and length
      ard_init2,     -- wait until tx buffer is done with opcode and id, clear rx buffer
      ard_process,   -- 1st wishbone cycle step, central state
      ard_read1,     -- 2nd wishbone read cycle step. Read data
      ard_read2,     -- 3rd wishbone read cycle step. Reset control signals and increment counters
      ardre_forward, -- send data that were buffered in ard_process
      ardre_wait,    -- wait until tx buffer is done
      ard_finish1,   -- init sending parity
      ard_finish2,   -- wait until parity sent

      -- interrupts
      int_init,
      int_finish,
      int_en
   );

   type reg_type is record
      state          : state_type;
      rdre_buffer    : std_logic_vector(WB_DW-1 downto 0);
      ardre_buffer   : std_logic_vector((FIFO_WIDTH*PROTO_WC_TX_MAX)-1 downto 0);   -- used to buffer auto-address-increment
                                                                                    -- read data before forwarding to tx buffer
      interrupt_en   : std_logic;
      timeout_cnt    : integer range 0 to WB_TIMEOUT_CYCLES-1;
      frame_id       : std_logic_vector(FIFO_WIDTH-1 downto 0);
      error_code     : std_logic_vector(FIFO_WIDTH-1 downto 0);

      start_address  : std_logic_vector(WB_AW-1 downto 0);                          -- start address (mwr, awr and ard)
      length         : integer range 0 to REGISTER_DAT_MAX + REGISTER_MWR_LEN;      -- total length of mwr/awr frames
                                                                                    -- data-only length of ard frames
      process_cnt    : integer range 0 to REGISTER_DAT_MAX;                         -- number of bytes already written (mwr/awr) or
                                                                                    -- number of reads (ard)
      receive_cnt    : integer range 1 to ((REGISTER_DAT_MAX + REGISTER_MWR_LEN) / 16) + 1; -- how many times the rx-buffer has asserted complete
      next_byte_pos  : integer range 0 to PROTO_WC_RX_MAX;                          -- position of the next byte to write

      parity         : std_logic_vector(FIFO_WIDTH-1 downto 0);                     -- stores a parity that is calculated in more than one state
   end record;

   signal reg_out, reg_in : reg_type;

begin
--===========================================================================--
   COMBINATIONAL : process(d, reg_out, wbi)
--===========================================================================--
      variable tmp : reg_type;
   begin
      tmp := reg_out;                                 -- default assignments

      case tmp.state is

      --IDLE-------------------------------------------------------------------
      when idle =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- reset register values
         tmp.timeout_cnt := 0;
         tmp.frame_id := x"00";
         tmp.next_byte_pos := 0;
         tmp.length := 0;
         tmp.process_cnt := 0;
         tmp.parity := (others => '0');
         tmp.receive_cnt := 1;
         tmp.ardre_buffer := (others => '-');

         -- set error code to unknown
         tmp.error_code := ERROR_UNKNOWN;

         -- next state
         if (wbi.girq = '1' AND tmp.interrupt_en = '1') then -- irq
            tmp.state := int_init;
         elsif (d.recbuf_complete = '1') then -- frame received
            tmp.state := opcode_check;
         else
            tmp.state := idle;
         end if;

      --INT_INIT---------------------------------------------------------------
      when int_init =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- compose frame
         q.trabuf_frame(q.trabuf_frame'length-1 downto 24) <= (others => '-');
         q.trabuf_frame(23 downto 0) <=
                  wbi.int_adr & -- parity (= core address)
                  wbi.int_adr & -- core address (8 bit)
                  SOC_INT_OPC;

         -- next state
         if (d.trabuf_busy = '1') then
            tmp.state := int_finish;
         else
            tmp.state := int_init;
         end if;

      --INT_FINISH-------------------------------------------------------------
      when int_finish =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- disable interrupts (to avoid sending infinite interrupts)
         tmp.interrupt_en := '0';

         -- next state
         if d.trabuf_busy = '1' then
            tmp.state := int_finish;
         else
            tmp.state := idle;
         end if;

      --OPCODE_CHECK-----------------------------------------------------------
      when opcode_check =>
         -- outputs (the same as in idle)
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- store frame id
         tmp.frame_id := d.recbuf_frame(15 downto 8);

         -- mcu_select
         if (d.recbuf_frame(7 downto 0) = MCU_SEL_OPC) then

            -- parity check
            if (( MCU_SEL_OPC xor
                  d.recbuf_frame(15 downto 8)) =
                  d.recbuf_frame(23 downto 16)) then
               tmp.state := mcu_select0;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- detect
         elsif (d.recbuf_frame(7 downto 0) = DETECT_OPC) then
            tmp.state := detect0;


         -- soc_int_en
         elsif (d.recbuf_frame(7 downto 0) = SOC_INT_EN_OPC) then
            --assert false report "received SOC_INT_EN" severity note;

            -- parity check
            if (( SOC_INT_EN_OPC xor
                  d.recbuf_frame(15 downto 8)) =
                  d.recbuf_frame(23 downto 16)) then
               tmp.state := int_en;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- register_wr
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_WR_OPC) then
            --assert false report "received REGISTER_WR" severity note;

            -- parity check
            if (( REGISTER_WR_OPC xor
                  d.recbuf_frame(15 downto 8) xor
                  d.recbuf_frame(23 downto 16) xor
                  d.recbuf_frame(31 downto 24) xor
                  d.recbuf_frame(39 downto 32)) =
                  d.recbuf_frame(47 downto 40)) then
               tmp.state := wr_init;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- register_mwr
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_MWR_OPC) then
            --assert false report "received REGISTER_MWR" severity note;
            tmp.state := multi_init;

         -- register_awr
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_AWR_OPC) then
            --assert false report "received REGISTER_AWR" severity note;
            tmp.state := multi_init;

         -- register_rd
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_RD_OPC) then
            --assert false report "received REGISTER_RD" severity note;

            -- parity check
            if (( REGISTER_RD_OPC xor
                  d.recbuf_frame(15 downto 8) xor
                  d.recbuf_frame(23 downto 16) xor
                  d.recbuf_frame(31 downto 24)) =
                  d.recbuf_frame(39 downto 32)) then
               tmp.state := rd_init;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- register_mrd
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_MRD_OPC) then
            --assert false report "received REGISTER_MRD" severity note;

            -- parity check
            if (( REGISTER_MRD_OPC xor
                  d.recbuf_frame(15 downto 8) xor
                  d.recbuf_frame(23 downto 16) xor
                  d.recbuf_frame(31 downto 24) xor
                  d.recbuf_frame(39 downto 32)) =
                  d.recbuf_frame(47 downto 40)) then
               tmp.state := mrd_init1;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- register_ard
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_ARD_OPC) then
            --assert false report "received REGISTER_ARD" severity note;

            -- parity check
            if (( REGISTER_ARD_OPC xor
                  d.recbuf_frame(15 downto 8) xor
                  d.recbuf_frame(23 downto 16) xor
                  d.recbuf_frame(31 downto 24) xor
                  d.recbuf_frame(39 downto 32)) =
                  d.recbuf_frame(47 downto 40)) then
               tmp.state := ard_init1;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- unknown opcode: send nack after a timeout
         else

            -- stay in this state until timeout (use process_cnt for counting)
            if (tmp.process_cnt < OPCODE_UNKNOWN_TIMEOUT) then
               tmp.state := opcode_check;
               tmp.process_cnt := tmp.process_cnt + 1;
            else
               assert false report "received unknown opcode, will now reply nack" severity warning;
               -- send nack (assume correct ID reception)
               tmp.error_code := ERROR_OPC_UNKNOWN;
               tmp.state := nack0;
               tmp.frame_id := d.recbuf_frame(15 downto 8);
            end if;
         end if;

      --WR_INIT----------------------------------------------------------------
      when wr_init =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= d.recbuf_frame(39 downto 32);

         --          |---    core address    ---|   |---  register address  ---|
         wbo.adr  <= d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);
         wbo.stb  <= '1';
         wbo.we   <= '1';
         wbo.cyc  <= '1';

         -- increment timeout counter
         tmp.timeout_cnt := tmp.timeout_cnt + 1;

         -- next state
         if (wbi.ack = '1') then
            tmp.state := wr_finish;
         elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
            tmp.state := wr_init;
         else -- timout
            tmp.error_code := ERROR_WB_TIMEOUT;
            tmp.state := nack0;
         end if;

      --WR_FINISH--------------------------------------------------------------
      when wr_finish =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         tmp.state := ack0;

      --MULTI_INIT-------------------------------------------------------------
      when multi_init =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- store address
         tmp.start_address := d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);

         -- store length
         if (d.recbuf_frame(7 downto 0) = REGISTER_MWR_OPC) then
            tmp.length := to_integer(unsigned(d.recbuf_frame(39 downto 32))) + REGISTER_MWR_LEN;
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_AWR_OPC) then
            tmp.length := to_integer(unsigned(d.recbuf_frame(39 downto 32))) + REGISTER_AWR_LEN;
         end if;

         -- reset process counter (which is used as write-counter)
         tmp.process_cnt := 0;

         -- set initial byte position
         tmp.next_byte_pos := 5;

         -- one rx-buffer is already received, "reset" to one has been done in idle state
         -- tmp.receive_cnt := 1;

         -- calculate parity over opcode, id, both address bytes and length
         tmp.parity := d.recbuf_frame(7 downto 0) xor
                       d.recbuf_frame(15 downto 8) xor
                       d.recbuf_frame(23 downto 16) xor
                       d.recbuf_frame(31 downto 24) xor
                       d.recbuf_frame(39 downto 32);

         -- next state, proceed after 6 bytes received
         if (d.recbuf_frame(7 downto 0) = REGISTER_MWR_OPC) then
            tmp.state := mwr_process;
         elsif (d.recbuf_frame(7 downto 0) = REGISTER_AWR_OPC) then
            tmp.state := awr_process;
         end if;

      --MWR_PROCESS------------------------------------------------------------
      when mwr_process =>
         --outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- everything has been written, don't write the parity byte
         if (tmp.length = REGISTER_MWR_LEN + tmp.process_cnt) then
            wbo.dat  <= (others => '-');
            wbo.adr  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- next state will be flush, don't write
         elsif (tmp.next_byte_pos = PROTO_WC_RX_MAX) then
            wbo.dat  <= (others => '-');
            wbo.adr  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- init wishbone cycle
         else
            wbo.dat  <= d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);
            wbo.adr  <= tmp.start_address;
            wbo.stb  <= '1';
            wbo.we   <= '1';
            wbo.cyc  <= '1';

            -- increment timeout counter
            tmp.timeout_cnt := tmp.timeout_cnt + 1;


         end if;

         -- next state
         -- if complete, enter wr_finish
         if ((tmp.length = REGISTER_MWR_LEN + tmp.process_cnt) and  -- length = overhead + write count       --> all writes done
             (tmp.receive_cnt * 16 >= tmp.length)) then             -- potentially received bytes >= length  --> all bytes (parity incl.) received

            -- parity check
            if (tmp.parity = d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8)) then
               tmp.state := wr_finish;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- enter flush when buffer processed but bytes left (byte position overruns buffer width)
         elsif (tmp.next_byte_pos = PROTO_WC_RX_MAX) then
            tmp.state := mwr_flush;

         -- enter next_byte after core acknowledges, until then stay in this state unless timeout
         elsif (wbi.ack = '1') then

            -- xor data byte to parity
            tmp.parity := tmp.parity xor d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);

            tmp.state := mwr_write1;
         elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
            tmp.state := mwr_process;
         else -- timeout
            tmp.error_code := ERROR_WB_TIMEOUT;
            tmp.state := nack0;
         end if;

      --MWR_WRITE1-------------------------------------------------------------
      when mwr_write1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- 2nd wishbone cycle
         wbo.dat  <= d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);
         wbo.adr  <= tmp.start_address;
         wbo.stb  <= '1';
         wbo.we   <= '1';
         wbo.cyc  <= '1';

         -- next state
         tmp.state := mwr_write2;

      --MWR_WRITE2-------------------------------------------------------------
      when mwr_write2 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- 3rd wishbone cycle
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- increment write counter and byte position
         tmp.process_cnt := tmp.process_cnt + 1;
         tmp.next_byte_pos := tmp.next_byte_pos + 1;

         -- reset timeout counter
         tmp.timeout_cnt := 0;

         -- next state
         tmp.state := mwr_process;

      --MWR_FLUSH--------------------------------------------------------------
      when mwr_flush =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- start at the beginning after flush
         tmp.next_byte_pos := 0;

         -- next state
         tmp.state := mwr_wait;

      --MWR_WAIT---------------------------------------------------------------
      when mwr_wait =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.recbuf_complete = '1') then
            tmp.state := mwr_process;
            -- after this state one more buffer is completely received
            tmp.receive_cnt := tmp.receive_cnt + 1;
         else
            tmp.state := mwr_wait;
         end if;

      --AWR_PROCESS------------------------------------------------------------
      when awr_process =>
         --outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- everything has been written, don't write the parity byte
         if (tmp.length = REGISTER_MWR_LEN + tmp.process_cnt) then
            wbo.dat  <= (others => '-');
            wbo.adr  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- next state will be flush, don't write
         elsif (tmp.next_byte_pos = PROTO_WC_RX_MAX) then
            wbo.dat  <= (others => '-');
            wbo.adr  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- 1st wishbone cycle
         else
            wbo.dat  <= d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);
            wbo.stb  <= '1';
            wbo.we   <= '1';
            wbo.cyc  <= '1';
            -- core address-part gets incremented by process_cnt (write counter)
            wbo.adr  <= tmp.start_address(WB_AW - 1 downto WB_AW - WB_REG_AW) &
                        std_logic_vector(to_unsigned(
                           to_integer(unsigned(tmp.start_address(WB_REG_AW - 1 downto 0))) + tmp.process_cnt
                        , WB_CORE_AW));

            -- increment timeout counter
            tmp.timeout_cnt := tmp.timeout_cnt + 1;

         end if;

         -- next state
         -- if complete, enter wr_finish
         if ((tmp.length = REGISTER_MWR_LEN + tmp.process_cnt) and  -- length = overhead + write count AND --> all writes done
             (tmp.receive_cnt * 16 >= tmp.length)) then             -- potentially received bytes >= length --> all bytes (parity incl.) received

            -- parity check
            if (tmp.parity = d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8)) then
               tmp.state := wr_finish;
            else
               tmp.error_code := ERROR_PARITY;
               tmp.state := nack0;
            end if;

         -- enter flush when buffer processed but bytes left (byte position overruns buffer width)
         elsif (tmp.next_byte_pos = PROTO_WC_RX_MAX) then
            tmp.state := awr_flush;

         -- enter next_byte after core acknowledges, until then stay in this state unless timeout
         elsif (wbi.ack = '1') then

            -- xor data byte to parity
            tmp.parity := tmp.parity xor d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);

            tmp.state := awr_write1;
         elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
            tmp.state := awr_process;
         else -- timeout
            tmp.error_code := ERROR_WB_TIMEOUT;
            tmp.state := nack0;
         end if;

      --AWR_WRITE1-------------------------------------------------------------
      when awr_write1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- 2nd wishbone cycle
         wbo.dat  <= d.recbuf_frame((tmp.next_byte_pos * 8) + 7 downto tmp.next_byte_pos * 8);
         wbo.stb  <= '1';
         wbo.we   <= '1';
         wbo.cyc  <= '1';
         -- core address-part gets incremented by process_cnt (write counter)
         wbo.adr  <= tmp.start_address(WB_AW - 1 downto WB_AW - WB_REG_AW) &
                     std_logic_vector(to_unsigned(
                        to_integer(unsigned(tmp.start_address(WB_REG_AW - 1 downto 0))) + tmp.process_cnt
                     , WB_CORE_AW));

         -- next state
         tmp.state := awr_write2;

      --AWR_WRITE2-------------------------------------------------------------
      when awr_write2 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         -- 3rd wishbone cycle
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- increment write counter and byte position
         tmp.process_cnt := tmp.process_cnt + 1;
         tmp.next_byte_pos := tmp.next_byte_pos + 1;

         -- reset timeout counter
         tmp.timeout_cnt := 0;

         -- next state
         tmp.state := awr_process;

      --AWR_FLUSH--------------------------------------------------------------
      when awr_flush =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- start at the beginning after flush
         tmp.next_byte_pos := 0;

         -- next state
         tmp.state := awr_wait;

      --AWR_WAIT---------------------------------------------------------------
      when awr_wait =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.recbuf_complete = '1') then
            tmp.state := awr_process;
            -- after this state one more buffer is completely received
            tmp.receive_cnt := tmp.receive_cnt + 1;
         else
            tmp.state := awr_wait;
         end if;

      --RD_INIT----------------------------------------------------------------
      when rd_init =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         --          |---    core address    ---|   |---  register address  ---|
         wbo.adr  <= d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);
         wbo.stb  <= '1';
         wbo.we   <= '0';
         wbo.cyc  <= '1';

         -- increment timeout counter
         tmp.timeout_cnt := tmp.timeout_cnt + 1;

         -- next state: wait until slave acknowledges
         if (wbi.ack = '1') then
            tmp.state := rd_buffer;
         elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
            tmp.state := rd_init;
         else -- timeout
            tmp.error_code := ERROR_WB_TIMEOUT;
            tmp.state := nack0;
         end if;

      --RD_BUFFER--------------------------------------------------------------
      when rd_buffer =>
         -- outputs: clear recbuf, store reply in buffer
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         --          |---    core address    ---|   |---  register address  ---|
         wbo.adr  <= d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);
         wbo.stb  <= '1';
         wbo.we   <= '0';
         wbo.cyc  <= '1';

         -- store reply in buffer
         tmp.rdre_buffer := wbi.dat;

         -- next state
         tmp.state := rdre_init;


      --RDRE_INIT--------------------------------------------------------------
      when rdre_init =>
         -- outputs: send REGISTER_RDRE to trabuf, close wb cycle
         -- compose frame
         q.trabuf_frame(7 downto 0)   <= REGISTER_RDRE_OPC;             -- opcode
         q.trabuf_frame(15 downto 8)  <= tmp.frame_id;                  -- frame id
         q.trabuf_frame(23 downto 16) <= tmp.rdre_buffer(7 downto 0);   -- data
         q.trabuf_frame(31 downto 24) <= REGISTER_RDRE_OPC XOR          -- parity
                                         tmp.frame_id XOR
                                         tmp.rdre_buffer(7 downto 0);
         q.trabuf_frame(q.trabuf_frame'length-1 downto 32) <= (others => '-');

         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: Wait until trabuf is busy
         if (d.trabuf_busy = '1') then
            tmp.state := rdre_finish;
         else
            tmp.state := rdre_init;
         end if;

      --RDRE_FINISH------------------------------------------------------------
      when rdre_finish =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: Wait until trabuf is done
         if (d.trabuf_busy = '1') then
            tmp.state := rdre_finish;
         else
            tmp.state := idle;
         end if;

      --MRD_INIT1--------------------------------------------------------------
      when mrd_init1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         -- already transmit opcode and id
         q.trabuf_valid       <= '1';
         q.trabuf_length      <=  2;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 16) <= (others => '-');

         q.trabuf_frame(15 downto 0) <=
                  d.recbuf_frame(15 downto 8) & -- id
                  REGISTER_MRDRE_OPC;

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- init parity
         tmp.parity := REGISTER_MRDRE_OPC xor d.recbuf_frame(15 downto 8); -- opc xor id

         -- store address
         tmp.start_address := d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);

         -- store length
         tmp.length := to_integer(unsigned(d.recbuf_frame(39 downto 32)));

         -- reset process (read) counter and next byte position
         tmp.process_cnt := 0;
         tmp.next_byte_pos := 0;

         -- next state: proceed when trabuf is busy
         if (d.trabuf_busy = '1') then
            tmp.state := mrd_init2;
         else
            tmp.state := mrd_init1;
         end if;

      --MRD_INIT2--------------------------------------------------------------
      when mrd_init2 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  2;
         q.trabuf_frame       <= (others => '-');

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: proceed when trabuf done
         if (d.trabuf_busy = '0') then
            tmp.state := mrd_process;
         else
            tmp.state := mrd_init2;
         end if;

      --MRD_PROCESS------------------------------------------------------------
      when mrd_process =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- if mrdre buffer is full
         if (tmp.next_byte_pos = PROTO_WC_TX_MAX) then
            wbo.adr <= (others => '-');
            wbo.dat  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- if there is data left to read
         elsif (tmp.process_cnt < tmp.length) then
            -- 1st wishbone read cycle
            wbo.adr  <= tmp.start_address;
            wbo.dat  <= (others => '-');
            wbo.stb  <= '1';
            wbo.we   <= '0';
            wbo.cyc  <= '1';

         -- buffer is not full, but there is no data to read
         else
            wbo.adr <= (others => '-');
            wbo.dat  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';
         end if;

         -- increment wishbone timeout counter
         tmp.timeout_cnt := tmp.timeout_cnt + 1;

         -- next state
         if (not (tmp.length = 0)) then

            -- forward if mrdre buffer is full ...
            if (tmp.next_byte_pos = PROTO_WC_TX_MAX) then
               -- wait here when tx buffer is busy
               if (d.trabuf_busy = '0') then
                  tmp.state := mrdre_forward;
               else
                  tmp.state := mrd_process;
               end if;

            -- ... or if processing has finish (all data read)
            elsif (tmp.process_cnt = tmp.length) then
               tmp.state := mrdre_forward;

            elsif (wbi.ack = '1') then

               tmp.state := mrd_read1;

            elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
               tmp.state := mrd_process;

            else -- timeout
               tmp.error_code := ERROR_WB_TIMEOUT;
               tmp.state := nack0;
            end if;

         -- if length = 0
         else
            tmp.state := mrd_finish1;
         end if;

      --MRD_READ1--------------------------------------------------------------
      when mrd_read1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- 2nd wishbone read cycle
         wbo.adr  <= tmp.start_address;
         wbo.dat  <= (others => '-');
         wbo.stb  <= '1';
         wbo.we   <= '0';
         wbo.cyc  <= '1';

         -- buffer register content
         tmp.ardre_buffer(((tmp.next_byte_pos*FIFO_WIDTH) + 7) downto (tmp.next_byte_pos*FIFO_WIDTH)) := wbi.dat;

         -- update parity
         tmp.parity := tmp.parity xor wbi.dat;

         -- next state
         tmp.state := mrd_read2;

      --MRD_READ2--------------------------------------------------------------
      when mrd_read2 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- 3rd wishbone read cycle
         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- increment process (read) counter and next byte position
         tmp.process_cnt := tmp.process_cnt + 1;
         tmp.next_byte_pos := tmp.next_byte_pos + 1;

         -- reset wishbone timeout counter
         tmp.timeout_cnt := 0;

         -- next state
         tmp.state := mrd_process;

      --MRDRE_WAIT-------------------------------------------------------------
      when mrdre_wait =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= tmp.next_byte_pos;
         q.trabuf_frame       <= tmp.ardre_buffer;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state, proceed when transmit buffer is done
         if (d.trabuf_busy = '0') then

            -- if there is data left to read
            if (tmp.process_cnt < tmp.length) then
               tmp.next_byte_pos := 0;
               tmp.state := mrd_process;
            else
               tmp.state := mrd_finish1;
            end if;

         else
            tmp.state := mrdre_wait;
         end if;

      --MRD_FINISH1------------------------------------------------------------
      when mrd_finish1 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <=  1;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 8) <= (others => '-');
         q.trabuf_frame(7 downto 0) <= tmp.parity;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.trabuf_busy = '1') then
            tmp.state := mrd_finish2;
         else
            tmp.state := mrd_finish1;
         end if;

      --MRD_FINISH2------------------------------------------------------------
      when mrd_finish2 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  1;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 8) <= (others => '-');
         q.trabuf_frame(7 downto 0) <= tmp.parity;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.trabuf_busy = '1') then
            tmp.state := mrd_finish2;
         else
            tmp.state := idle;
         end if;

      --MRDRE_FORWARD----------------------------------------------------------
      when mrdre_forward =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= tmp.next_byte_pos;
         q.trabuf_frame       <= tmp.ardre_buffer;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         tmp.state := mrdre_wait;

      --ARD_INIT1--------------------------------------------------------------
      when ard_init1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         -- already transmit opcode and id
         q.trabuf_valid       <= '1';
         q.trabuf_length      <=  2;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 16) <= (others => '-');

         q.trabuf_frame(15 downto 0) <=
                  d.recbuf_frame(15 downto 8) & -- id
                  REGISTER_ARDRE_OPC;

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- init parity
         tmp.parity := REGISTER_ARDRE_OPC xor d.recbuf_frame(15 downto 8);

         -- store start address
         tmp.start_address := d.recbuf_frame(23 downto 16) & d.recbuf_frame(31 downto 24);

         -- store length
         tmp.length := to_integer(unsigned(d.recbuf_frame(39 downto 32)));

         -- reset process (read) counter and next byte position
         tmp.process_cnt := 0;
         tmp.next_byte_pos := 0;

         -- next state: proceed when trabuf is busy
         if (d.trabuf_busy = '1') then
            tmp.state := ard_init2;
         else
            tmp.state := ard_init1;
         end if;

      --ARD_INIT2--------------------------------------------------------------
      when ard_init2 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  2;
         q.trabuf_frame       <= (others => '-');

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: proceed when trabuf done
         if (d.trabuf_busy = '0') then
            tmp.state := ard_process;
         else
            tmp.state := ard_init2;
         end if;

      --ARD_PROCESS------------------------------------------------------------
      when ard_process =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- if ardre buffer is full
         if (tmp.next_byte_pos = PROTO_WC_TX_MAX) then
            wbo.adr <= (others => '-');
            wbo.dat  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';

         -- if there is data left to read
         elsif (tmp.process_cnt < tmp.length) then
            -- 1st wishbone read cycle
            wbo.adr  <=
               tmp.start_address(WB_AW-1 downto WB_CORE_AW) &
               std_logic_vector(to_unsigned((to_integer(unsigned(tmp.start_address(WB_CORE_AW-1 downto 0))) + tmp.process_cnt), WB_CORE_AW));

            wbo.dat  <= (others => '-');
            wbo.stb  <= '1';
            wbo.we   <= '0';
            wbo.cyc  <= '1';

         -- buffer is not full, but there is no data to read
         else
            wbo.adr <= (others => '-');
            wbo.dat  <= (others => '-');
            wbo.stb  <= '0';
            wbo.we   <= '0';
            wbo.cyc  <= '0';
         end if;

         -- increment wishbone timeout counter
         tmp.timeout_cnt := tmp.timeout_cnt + 1;

         -- next state
         if (not (tmp.length = 0)) then

            -- forward if ardre buffer is full ...
            if (tmp.next_byte_pos = PROTO_WC_TX_MAX) then
               -- wait here when tx buffer is busy
               if (d.trabuf_busy = '0') then
                  tmp.state := ardre_forward;
               else
                  tmp.state := ard_process;
               end if;

            -- ... or if processing has finish (all data read)
            elsif (tmp.process_cnt = tmp.length) then
               tmp.state := ardre_forward;

            elsif (wbi.ack = '1') then
               tmp.state := ard_read1;

            elsif (tmp.timeout_cnt < WB_TIMEOUT_CYCLES - 1) then
               tmp.state := ard_process;

            else -- timeout
               tmp.error_code := ERROR_WB_TIMEOUT;
               tmp.state := nack0;
            end if;

         -- if length = 0
         else
            tmp.state := ard_finish1;
         end if;

      --ARD_READ1--------------------------------------------------------------
      when ard_read1 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- 2nd wishbone read cycle
         wbo.adr  <=
            tmp.start_address(WB_AW-1 downto WB_CORE_AW) &
            std_logic_vector(to_unsigned((to_integer(unsigned(tmp.start_address(WB_CORE_AW-1 downto 0))) + tmp.process_cnt), WB_CORE_AW));
         wbo.dat  <= (others => '-');
         wbo.stb  <= '1';
         wbo.we   <= '0';
         wbo.cyc  <= '1';

         -- buffer register content
         tmp.ardre_buffer(((tmp.next_byte_pos*FIFO_WIDTH) + 7) downto (tmp.next_byte_pos*FIFO_WIDTH)) := wbi.dat;

         -- update parity
         tmp.parity := tmp.parity xor wbi.dat;

         -- next state
         tmp.state := ard_read2;

      --ARD_READ2--------------------------------------------------------------
      when ard_read2 =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  0;
         q.trabuf_frame       <= (others => '-');

         -- 3rd wishbone read cycle
         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- increment process (read) counter and next byte position
         tmp.process_cnt := tmp.process_cnt + 1;
         tmp.next_byte_pos := tmp.next_byte_pos + 1;

         -- reset wishbone timeout counter
         tmp.timeout_cnt := 0;

         -- next state
         tmp.state := ard_process;

      --ARDRE_FORWARD----------------------------------------------------------
      when ardre_forward =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= tmp.next_byte_pos;
         q.trabuf_frame       <= tmp.ardre_buffer;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         tmp.state := ardre_wait;

      --ARDRE_WAIT-------------------------------------------------------------
      when ardre_wait =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= tmp.next_byte_pos;
         q.trabuf_frame       <= tmp.ardre_buffer;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state, proceed when transmit buffer is done
         if (d.trabuf_busy = '0') then

            -- if there is data left to read
            if (tmp.process_cnt < tmp.length) then
               tmp.next_byte_pos := 0;
               tmp.state := ard_process;
            else
               tmp.state := ard_finish1;
            end if;

         else
            tmp.state := ardre_wait;
         end if;

      --ARD_FINISH1------------------------------------------------------------
      when ard_finish1 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <=  1;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 8) <= (others => '-');
         q.trabuf_frame(7 downto 0) <= tmp.parity;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.trabuf_busy = '1') then
            tmp.state := ard_finish2;
         else
            tmp.state := ard_finish1;
         end if;

      --ARD_FINISH2------------------------------------------------------------
      when ard_finish2 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';
         q.trabuf_valid       <= '0';
         q.trabuf_length      <=  1;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 8) <= (others => '-');
         q.trabuf_frame(7 downto 0) <= tmp.parity;

         wbo.adr  <= (others => '-');
         wbo.dat  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         if (d.trabuf_busy = '1') then
            tmp.state := ard_finish2;
         else
            tmp.state := idle;
         end if;

      --NACK0------------------------------------------------------------------
      when nack0 =>
         -- outputs
         -- compose frame
         q.trabuf_frame(7 downto 0)   <= NACK_OPC;             -- opcode
         q.trabuf_frame(15 downto 8)  <= tmp.frame_id;         -- frame id
         q.trabuf_frame(23 downto 16) <= tmp.error_code;       -- error code
         q.trabuf_frame(31 downto 24) <= NACK_OPC XOR          -- parity
                                         tmp.frame_id XOR
                                         tmp.error_code;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 32) <= (others => '-');

         q.recbuf_clear       <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is busy
         if (d.trabuf_busy = '1') then
            tmp.state := nack1;
         else
            tmp.state := nack0;
         end if;

      --NACK1------------------------------------------------------------------
      when nack1 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is done
         if (d.trabuf_busy = '1') then
            tmp.state := nack1;
         else
            tmp.state := idle;
         end if;

      --ACK0-------------------------------------------------------------------
      when ack0 =>
         -- outputs
         -- compose frame
         q.trabuf_frame(7 downto 0) <= ACK_OPC;                      -- opcode
         q.trabuf_frame(15 downto 8)  <= tmp.frame_id;               -- frame id
         q.trabuf_frame(23 downto 16) <= ACK_OPC XOR tmp.frame_id;   -- parity
         q.trabuf_frame(q.trabuf_frame'length-1 downto 24) <= (others => '-');

         q.recbuf_clear       <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is busy
         if (d.trabuf_busy = '1') then
            tmp.state := ack1;
         else
            tmp.state := ack0;
         end if;

      --ACK1-------------------------------------------------------------------
      when ack1 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is done
         if (d.trabuf_busy = '1') then
            tmp.state := ack1;
         else
            tmp.state := idle;
         end if;

      --MCU_SELECT0 : Send reply-----------------------------------------------
      when mcu_select0 =>
         -- outputs
         -- compose frame
         q.trabuf_frame(7 downto 0) <= ACK_OPC;                      -- opcode
         q.trabuf_frame(15 downto 8)  <= tmp.frame_id;               -- frame id
         q.trabuf_frame(23 downto 16) <= ACK_OPC XOR tmp.frame_id;   -- parity
         q.trabuf_frame(q.trabuf_frame'length-1 downto 24) <= (others => '-');

         q.recbuf_clear       <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is busy
         if (d.trabuf_busy = '1') then
            tmp.state := mcu_select1;
         else
            tmp.state := mcu_select0;
         end if;

      --MCU_SELECT1 : Wait until transmitted-----------------------------------
      when mcu_select1 =>
         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is done
         if (d.trabuf_busy = '1') then
            tmp.state := mcu_select1;
         else
            tmp.state := mcu_select2;
         end if;

      --MCU_SELECT2 : Switch to MCU--------------------------------------------
      when mcu_select2 =>
         -- outputs (mcu_select and recbuf_clear asserted)
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '1';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state
         tmp.state := idle;

      --DETECT0 : Transmit reply-----------------------------------------------
      when detect0 =>

         -- reply frame
         q.trabuf_frame(7 downto 0)   <= DETECT_REPLY_OPC;    -- opcode
         q.trabuf_frame(15 downto 8)  <= DETECT_REPLY_FPGA; -- fpga identifier
         q.trabuf_frame(23 downto 16) <= DETECT_REPLY_OPC XOR DETECT_REPLY_FPGA;
         q.trabuf_frame(q.trabuf_frame'length-1 downto 24) <= (others => '-');

         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_valid       <= '1';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is busy
         if (d.trabuf_busy = '1') then
            tmp.state := detect1;
         else
            tmp.state := detect0;
         end if;

      --DETECT1 : Wait until transmitted---------------------------------------
      when detect1 =>

         -- outputs
         q.recbuf_clear       <= '1';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '1';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- next state: wait until transmission buffer is done
         if (d.trabuf_busy = '1') then
            tmp.state := detect1;
         else
            tmp.state := idle;
         end if;

      --SOC_INT_EN-------------------------------------------------------------
      when int_en =>
         -- outputs
         q.recbuf_clear       <= '0';
         q.trabuf_frame       <= (others => '-');
         q.trabuf_valid       <= '0';
         q.trabuf_length      <= 0;
         q.mcu_select         <= '0';
         q.transmitter_mode   <= '0';

         wbo.dat  <= (others => '-');
         wbo.adr  <= (others => '-');
         wbo.stb  <= '0';
         wbo.we   <= '0';
         wbo.cyc  <= '0';

         -- store frame id
         tmp.frame_id := d.recbuf_frame(15 downto 8);

         -- enable interrupts
         tmp.interrupt_en := '1';

         -- next state
         tmp.state := ack0;

      end case;
      -------------------------------------------------------------------------

      reg_in <= tmp;                                  -- drive register inputs

   end process COMBINATIONAL;

--===========================================================================--
   REGISTERS : process(clk,rst)
--===========================================================================--
   begin
      if rising_edge(clk) then
         if (rst = '1') then
            reg_out.state <= idle;
         else
            reg_out <= reg_in;
         end if;
      end if;
   end process REGISTERS;

end two_proc;
