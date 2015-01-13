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

--------------------------------------------------------------------------------
-- H E L L O   W O R L D   S T A N D A L O N E   A P P L I C A T I O N
-- (hello_world.vhd)
--
-- Simple 1 Hz LED blinker
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--------------------------------------------------------------------------------
ENTITY hello_world is
--------------------------------------------------------------------------------
   port (
      -- 8 MHz clock input
      clk_i          : in  std_logic;

      -- LED output
      gpio_b0_00     : out std_logic
   );
end hello_world;

--------------------------------------------------------------------------------
ARCHITECTURE behavioral of hello_world is
--------------------------------------------------------------------------------
   constant counter_max : natural := 8000000;

-------------------------------------------------------------------------------
begin -- architecture behavioral
-------------------------------------------------------------------------------

   counter : process(clk_i)
      variable count : natural range 0 to counter_max := 0;
   begin

      if (rising_edge(clk_i)) then

         -- LED on
         if (count < counter_max/2) then
            gpio_b0_00 <= '1';
            count := count + 1;
         -- LED off
         elsif (count < counter_max) then
            gpio_b0_00 <= '0';
            count := count + 1;
         -- counter reset
         else
            count := 0;
         end if;
      end if;

   end process counter;

end behavioral;
