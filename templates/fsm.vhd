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

library IEEE;
use IEEE.std_logic_1164.all;

use work.constants.all;

--------------------------------------------------------------------------------
ENTITY <entity_name> is
--------------------------------------------------------------------------------
   port (
      clk_i       : in  std_logic;
      rst_i       : in  std_logic;
   );
end <entity_name>;

--------------------------------------------------------------------------------
ARCHITECTURE fsm of <entity_name> is
--------------------------------------------------------------------------------

   ----------------------------------------------
   -- States and state signals
   ----------------------------------------------
   type state_type is (
      idle,
      2nd_state,
      ...
   );
   signal current_state, nextstate : state_type;

begin
   ----------------------------------------------
      MOORE_OUTPUT_LOGIC :
   ----------------------------------------------
   process (current_state)
   begin
   case current_state is

      when idle =>

   end case;
   end process MOORE_OUTPUT_LOGIC;

   ----------------------------------------------
      NEXT_STATE_LOGIC :
   ----------------------------------------------
   process (current_state)
   begin
   case current_state is

      when idle =>

   end case;
   end process NEXT_STATE_LOGIC;

   ----------------------------------------------
      STATE_REGISTER :
   ----------------------------------------------
   process (clk_i, rst_i)
   begin
      if (rst_i = '1') then
         current_state <= idle;
      elsif rising_edge(clk_i) then
         current_state <= next_state;
      end if;
   end process STATE_REGISTER;

end fsm;
