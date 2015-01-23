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

--===========================================================================--
-- F I F O    C O N T R O L L E R
--
-- purpose: abstraction of an ftdi ft245 style fifo interface
-- type:    mealy state machine
--===========================================================================--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

--===========================================================================--
entity fifo_controller is
--===========================================================================--
   generic(
      FIFO_WIDTH : natural := 8
   );
   port(
      -- fifo adapter interface
      data_transmit_o   : out std_logic_vector(FIFO_WIDTH -1 downto 0);
      txe_i             : in  std_logic;
      wr_o              : out std_logic;
      data_receive_i    : in  std_logic_vector(FIFO_WIDTH -1 downto 0);
      rxf_i             : in  std_logic;
      rd_o              : out std_logic;
      direction_o       : out std_logic; -- 0:receiver, 1:transmitter
      -- receive buffer interface
      word_recbuf_o     : out std_logic_vector(FIFO_WIDTH -1 downto 0);
      store_recbuf_o    : out std_logic;
      busy_recbuf_i     : in std_logic;
      -- transmit buffer interface
      word_trabuf_i     : in  std_logic_vector(FIFO_WIDTH -1 downto 0);
      send_trabuf_i     : in  std_logic;
      -- misc
      transmitter_mode_i: in  std_logic;
      clk_i             : in  std_logic;
      rst_i             : in  std_logic
   );
end fifo_controller;

--===========================================================================--
architecture two_proc of fifo_controller is
--===========================================================================--
   type state_type is (
      idle,
      rd_request,
      rd_wait0,
      rd_wait1,
      rd_wait2,
      rd_store,
      rd_end,
      wr0,
      wr1,
      wr2,
      wr3,
      wr4
   );

   type reg_type is record
      state : state_type;
      counter : integer range 0 to 15;
   end record;

   signal reg_out, reg_in : reg_type;
begin

--===========================================================================--
   COMBINATIONAL : process (reg_out, rxf_i, txe_i, word_trabuf_i, send_trabuf_i,
                            data_receive_i, transmitter_mode_i, busy_recbuf_i) is
--===========================================================================--
      variable tmp : reg_type;
   begin

      -- default assignment
      tmp := reg_out;

      case tmp.state is

         when idle =>
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '0';           -- receiver mode
            store_recbuf_o    <= '0';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= (others=>'-');

            -- reset counter
            tmp.counter := 0;

            -- next state logic
            if (rxf_i = '1' and busy_recbuf_i = '0') then
               tmp.state := rd_request;
               rd_o <= '1';
            elsif (send_trabuf_i = '1' and transmitter_mode_i = '1') then
               tmp.state := wr0;
            else
               tmp.state := idle;
            end if;

         -- read request: assert rd to read fifo receive buffer
         -- read wait: wait three cycles for data to become valid
         -- Total duration: 50 ns @ 80 MHz
         when rd_request | rd_wait0 | rd_wait1 | rd_wait2 =>
            -- outputs
            wr_o              <= '0';
            rd_o              <= '1';
            direction_o       <= '0';
            store_recbuf_o    <= '0';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= (others=>'-');

            -- next state logic:
            case tmp.state is
               when rd_request =>
                  tmp.state  := rd_wait0;
               when rd_wait0 =>
                  tmp.state  := rd_wait1;
               when rd_wait1 =>
                  tmp.state  := rd_wait2;
               when others => -- rd_wait2
                  tmp.state  := rd_store;
            end case;

         -- read store: assumes data is valid and stores
         when rd_store =>
            -- outputs
            wr_o              <= '0';
            rd_o              <= '1';
            direction_o       <= '0';
            store_recbuf_o    <= '1';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= data_receive_i;

            -- next state logic
            tmp.state        := rd_end;

         -- read end: wait until rxf is reset
         when rd_end =>
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '0';
            store_recbuf_o    <= '0';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= (others=>'-');

            -- next state logic
            if (rxf_i = '0') then
               tmp.state := idle;
            else
               tmp.state := rd_end;
            end if;

         when wr0 => -- wait for txe
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '0';
            store_recbuf_o    <= '0';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= (others=>'-');

            -- next state logic
            if (txe_i = '1') then
               tmp.state := wr1;
            else
               tmp.state := wr0;
            end if;

         when wr1 => -- set direction
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '1';
            store_recbuf_o    <= '0';
            data_transmit_o   <= (others=>'-');
            word_recbuf_o     <= (others=>'-');

            -- next state logic
            tmp.state  := wr2;

         when wr2 => -- drive out data
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '1';
            store_recbuf_o    <= '0';
            data_transmit_o   <= word_trabuf_i;
            word_recbuf_o     <= (others=>'-');

            -- next state logic
            tmp.state        := wr3;

         when wr3 => -- assert wr (minimum 50 ns)
            -- outputs
            wr_o              <= '1';
            rd_o              <= '0';
            direction_o       <= '1';
            store_recbuf_o    <= '0';
            data_transmit_o   <= word_trabuf_i;
            word_recbuf_o     <= (others=>'-');

            -- count
            tmp.counter := tmp.counter + 1;

            -- next state logic
            if (tmp.counter < 4) then -- 50 ns * 80 MHz = 4
               tmp.state  := wr3;
            else
               tmp.state  := wr4;
            end if;

         when wr4 => -- deassert wr
            -- outputs
            wr_o              <= '0';
            rd_o              <= '0';
            direction_o       <= '1';
            store_recbuf_o    <= '0';
            data_transmit_o   <= word_trabuf_i;
            word_recbuf_o     <= (others=>'-');

            -- next state logic
            tmp.state  := idle;

      end case;

      -- drive register inputs
      reg_in <= tmp;

   end process COMBINATIONAL;

--===========================================================================--
   REGISTERS : process (clk_i, rst_i) is
--===========================================================================--
   begin
      if (rst_i = '1') then
         reg_out.state <= idle;
      elsif rising_edge(clk_i) then
         reg_out <= reg_in;
      end if;
   end process REGISTERS;
end two_proc;
