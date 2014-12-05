-------------------------------------------------------------------------------
-- R E C E I V E    F R A M E B U F F E R   (receive_frame_buffer.vhd)
--
-- Statemachine using two-process-pattern
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.constants.all;

-------------------------------------------------------------------------------
ENTITY receive_frame_buffer is
-------------------------------------------------------------------------------

   generic (
      WIDTH : natural := FIFO_WIDTH                -- width of a data word
   );

   port (
      clk_i             : in std_logic;   -- clock input
      clear_i           : in std_logic;   -- synchronous clear input
      store_i           : in std_logic;   -- asserted when valid word is applied
      frame_complete_o  : out std_logic;  -- frame complete detected
      word_i            : in std_logic_vector(WIDTH - 1 downto 0); -- word input
      frame_o           : out std_logic_vector((WIDTH * PROTO_WC_RX_MAX) - 1 downto 0); -- frame output
      busy_o            : out std_logic   -- asserted when forwarding to frame controller
   );

end receive_frame_buffer;

-------------------------------------------------------------------------------
ARCHITECTURE two_proc of receive_frame_buffer is
-------------------------------------------------------------------------------

   -- frame buffer type
   type buffer_type is array (0 to PROTO_WC_RX_MAX - 1) of std_logic_vector(WIDTH -1 downto 0);

   -- state type
   type state_type is (
      init,
      -- states for reception of frames that fit into the buffer
      receive,
      increment,
      clear,
      -- for partial reception (mwr/awr)
      receive_part,
      increment_part,
      clear_part
   );

   -- register type (includes frame buffer and state)
   type reg_type is record
      state       : state_type;
      frame       : buffer_type;
      buffer_ptr  : integer range 0 to PROTO_WC_RX_MAX;  -- position of the next word
                                                         -- if PROTO_WC_RX_MAX, buffer is full

      receive_cnt : integer range 0 to PROTO_WC_MAX;     -- counts the number of received bytes

      length      : integer range 0 to PROTO_WC_MAX;     -- number of bytes to receive in total
   end record;

   signal reg_out, reg_in  : reg_type;
   signal frame_complete_s : std_logic;

-------------------------------------------------------------------------------
begin -- architecture
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- STRUCTURAL
-------------------------------------------------------------------------------

-- complete and busy output
frame_complete_o <= frame_complete_s;
busy_o <= frame_complete_s or clear_i;

-------------------------------------------------------------------------------
   COMBINATIONAL : process(reg_out, clear_i, store_i, word_i)
-------------------------------------------------------------------------------
      variable tmp : reg_type;
   begin

      -- default assignments
      tmp := reg_out;

      -- state machine
      case tmp.state is
         ----------------------------------------
         when init =>
         ----------------------------------------
            -- outputs
            frame_complete_s <= '0';
            frame_o <= (others => '-');

            -- init register
            tmp.buffer_ptr := 0;
            tmp.state := receive;
            tmp.receive_cnt := 0;
            tmp.length := 0;

         ----------------------------------------
         when receive =>
         ----------------------------------------
            -- output frame
            for word_index in 0 to (PROTO_WC_RX_MAX - 1) loop
               frame_o(((word_index * WIDTH) + (WIDTH - 1)) downto word_index * WIDTH) <= tmp.frame(word_index);
            end loop;

            -- if the opcode is received
            if (tmp.buffer_ptr >= 1) then

               -- assert frame_complete depending on opcode.
               case tmp.frame(0) is

                  when MCU_SEL_OPC =>
                     if (tmp.buffer_ptr = MCU_SEL_LEN) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  when SOC_INT_EN_OPC =>
                     if (tmp.buffer_ptr = SOC_INT_EN_LEN) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  when REGISTER_WR_OPC =>
                     if (tmp.buffer_ptr = REGISTER_WR_LEN ) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  when REGISTER_RD_OPC =>
                     if (tmp.buffer_ptr = REGISTER_RD_LEN ) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  when REGISTER_MRD_OPC =>
                     if (tmp.buffer_ptr = REGISTER_MRD_LEN ) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  when REGISTER_ARD_OPC =>
                     if (tmp.buffer_ptr = REGISTER_ARD_LEN ) then
                        frame_complete_s <= '1';
                     else
                        frame_complete_s <= '0';
                     end if;

                  -- OPC unknown
                  when others =>
                     frame_complete_s <= '1';
               end case;

            -- if pointer is zero
            else
               frame_complete_s <= '0';
               frame_o <= (others => '-');
            end if;

            -- next state
            if (clear_i = '1') then
               tmp.state := clear;

            -- enter increment_part when storing mwr/awr opcode
            elsif (tmp.buffer_ptr = 0 and store_i = '1' and (word_i = REGISTER_MWR_OPC or word_i = REGISTER_AWR_OPC)) then
               tmp.state := increment_part;
               tmp.frame(0) := word_i;

            -- enter increment when storing other opcode
            elsif (store_i = '1') then
               tmp.frame(tmp.buffer_ptr) := word_i;
               tmp.state := increment;
            end if;

         ----------------------------------------
         when increment =>
         ----------------------------------------
            -- outputs
            frame_complete_s <= '0';
            frame_o <= (others => '-');

            -- increment pointer and counter
            tmp.buffer_ptr  := tmp.buffer_ptr + 1;
            tmp.receive_cnt := tmp.receive_cnt + 1;

            -- next state
            tmp.state := receive;

         ----------------------------------------
         when clear =>
         ----------------------------------------
            -- outputs
            frame_complete_s <= '0';
            frame_o <= (others => '-');

            -- clear
            tmp.buffer_ptr := 0;
            tmp.receive_cnt := 0;

            -- next state
            if (clear_i = '0') then
               tmp.state := receive;
            else
               tmp.state := clear;
            end if;

         ----------------------------------------
         when receive_part =>
         ----------------------------------------
            -- output frame
            for word_index in 0 to (PROTO_WC_RX_MAX - 1) loop
               frame_o(((word_index * WIDTH) + (WIDTH - 1)) downto word_index * WIDTH) <= tmp.frame(word_index);
            end loop;

            -- complete when full
            if (tmp.buffer_ptr = PROTO_WC_RX_MAX) then
               frame_complete_s <= '1';

            -- complete when completely received
            elsif (tmp.receive_cnt = tmp.length) then
               frame_complete_s <= '1';

            -- incomplete
            else
               frame_complete_s <= '0';
            end if;

            -- store length (header and parity inclusive) when 5 bytes received
            if (tmp.receive_cnt = 5) then

               -- MWR length
               if (tmp.frame(0) = REGISTER_MWR_OPC) then
                  tmp.length := to_integer(unsigned(tmp.frame(4))) + REGISTER_MWR_LEN;

               -- AWR length
               elsif (tmp.frame(0) = REGISTER_AWR_OPC) then
                  tmp.length := to_integer(unsigned(tmp.frame(4))) + REGISTER_AWR_LEN;
               end if;

            end if;

            -- next state
            -- if fully received enter clear to return to receive state
            if (clear_i = '1' and tmp.receive_cnt = tmp.length) then
               tmp.state := clear;

            -- if clear enter clear_part to prepare for next partial buffering
            elsif (clear_i = '1') then
               tmp.state := clear_part;

            -- store and enter increment_part
            elsif (store_i = '1') then
               tmp.frame(tmp.buffer_ptr) := word_i;
               tmp.state := increment_part;
            end if;

         ----------------------------------------
         when increment_part =>
         ----------------------------------------
            -- outputs
            frame_complete_s <= '0';
            frame_o <= (others => '-');

            -- increment pointer and counter
            tmp.buffer_ptr  := tmp.buffer_ptr + 1;
            tmp.receive_cnt := tmp.receive_cnt + 1;

            -- next state
            tmp.state := receive_part;

         ----------------------------------------
         when clear_part =>
         ----------------------------------------
            -- outputs
            frame_complete_s <= '0';
            frame_o <= (others => '-');

            -- clear
            tmp.buffer_ptr := 0;

            -- next state
            if (clear_i = '0') then
               tmp.state := receive_part;
            else
               tmp.state := clear_part;
            end if;

      end case;

      -- drive register inputs
      reg_in <= tmp;

   end process COMBINATIONAL;


-------------------------------------------------------------------------------
   REGISTERS : process(clk_i)                             -- sequential process
-------------------------------------------------------------------------------
   begin
      if rising_edge(clk_i) then
         reg_out <= reg_in;
      end if;
   end process REGISTERS;

end two_proc;

