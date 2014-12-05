-- This file is part of easyFPGA.
-- Copyright 2013,2014 os-cillation GmbH
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
-- <UUT NAME>    T E S T B E N C H    (<uut_name>_tb.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
ENTITY <uut_name>_tb is
-------------------------------------------------------------------------------
begin
end <uut_name>_tb;

-------------------------------------------------------------------------------
ARCHITECTURE simulation of <uut_name>_tb is
-------------------------------------------------------------------------------
   -- constants
   constant CLK_PERIOD : time := 10 ns;

   -- signals
   signal clk     : std_logic;
   signal rst     : std_logic;

begin
-------------------------------------------------
   STIMULI_PROC :
-------------------------------------------------
process begin
   -- hold reset for 100 ns and 10 clock cycles
   rst <= '1';
   wait for 100 ns;
   wait for CLK_PERIOD*10;

   -- place stimuli here:


   wait; -- forever
end process STIMULI_PROC;

-------------------------------------------------
-- UUT instantiation
-------------------------------------------------
UUT : soc_bridge
   port map (
      clk_i => clk,
      rst_i => rst
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
