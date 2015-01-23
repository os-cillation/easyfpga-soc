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
-- WB SLAVE SINGLE REGISTER TESTBENCH    (wb_slave_single_reg_tb.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wb_slave_single_reg_comp.all;

-------------------------------------------------------------------------------
ENTITY wb_slave_single_reg_tb is
-------------------------------------------------------------------------------
begin
end wb_slave_single_reg_tb;

-------------------------------------------------------------------------------
ARCHITECTURE simulation of wb_slave_single_reg_tb is
-------------------------------------------------------------------------------
   -- constants
   constant CLK_PERIOD : time := 10 ns;

   -- signals
   signal clk     : std_logic;
   signal rst     : std_logic;
   signal uut_in  : wb_slave_in_type;
   signal uut_out : wb_slave_out_type;

begin
-------------------------------------------------
   STIMULI_PROC :
-------------------------------------------------
process begin
   -- hold reset for 100 ns and 10 clock cycles
   rst          <= '1';
   uut_in.dat_i <= (others => '0');
   uut_in.adr_i <= (others => '0');
   uut_in.stb_i <= '0';
   uut_in.we_i  <= '0';

   wait for 100 ns;
   rst <= '0';
   wait for CLK_PERIOD*10;

   -- single write
   assert false report "Perform single write" severity note;
   uut_in.dat_i <= x"FFFFFFFF";
   uut_in.adr_i <= std_logic_vector(to_unsigned(15,32));
   uut_in.stb_i <= '1';
   uut_in.we_i  <= '1';
   wait for CLK_PERIOD;
   if (uut_out.ack_o = '0') then wait until uut_out.ack_o = '1'; end if;
   uut_in.stb_i <= '0';
   wait for CLK_PERIOD;

   -- single write (wrong address)
   assert false report "Perform single write with wrong address" severity note;
   uut_in.dat_i <= x"00000000";
   uut_in.adr_i <= std_logic_vector(to_unsigned(10,32));
   uut_in.stb_i <= '1';
   uut_in.we_i  <= '1';
   wait for CLK_PERIOD;
   if (uut_out.ack_o = '0') then wait until uut_out.ack_o = '1'; end if;
   uut_in.stb_i <= '0';
   wait for CLK_PERIOD;

   -- single read
   assert false report "Perform single read" severity note;
   uut_in.adr_i <= std_logic_vector(to_unsigned(15,32));
   uut_in.stb_i <= '1';
   uut_in.we_i  <= '0';
   wait for CLK_PERIOD;
   if (uut_out.ack_o = '0') then wait until uut_out.ack_o = '1'; end if;
   uut_in.stb_i <= '0';
   wait for CLK_PERIOD;

   wait; -- forever
end process STIMULI_PROC;

-------------------------------------------------
-- UUT instantiation
-------------------------------------------------
UUT : entity work.wb_slave_single_reg
   generic map (
      register_address => to_unsigned(15,32)
   )
   port map (
      clk_i => clk,
      rst_i => rst,
      wb_in => uut_in,
      wb_out=> uut_out
   );
-------------------------------------------------
   CLK_GENERATOR :
-------------------------------------------------
process begin
   clk <= '0';
   wait for CLK_PERIOD/2;
   clk <= '1';
   wait for CLK_PERIOD/2;
end process CLK_GENERATOR;

end simulation;
