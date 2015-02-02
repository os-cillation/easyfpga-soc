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

----------------------------------------------------------------------------------
--   E N A B L E    C O N T R O L L E R
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enable_controller is
   port (
      -- mcu interface
      fpga_active_i  : in  std_logic;
      mcu_active_o   : out std_logic;
      -- soc interface
      mcu_select_i   : in  std_logic;
      fifo_enable_o  : out std_logic;
      clk_i          : in  std_logic;
      rst_i          : in  std_logic
   );
end enable_controller;

architecture fsm of enable_controller is
   type state_type is (mcu_active, fpga_active, switch_to_mcu);
   signal current_state, next_state : state_type;
begin

   -------------------------------------------------
   --   Combinational next state and output logic
   -------------------------------------------------
   STATEMACHINE : process (current_state, fpga_active_i, mcu_select_i) is
   begin
      case current_state is

         when mcu_active =>
            fifo_enable_o <= '0';
            mcu_active_o  <= '1';
            if rising_edge(fpga_active_i) then
               next_state <= fpga_active;
            else
               next_state <= mcu_active;
            end if;

         when fpga_active =>
            fifo_enable_o <= '1';
            mcu_active_o  <= '0';
            if mcu_select_i = '1' then
               next_state <= switch_to_mcu;
            else
               next_state <= fpga_active;
            end if;

         when switch_to_mcu =>
            fifo_enable_o <= '1';
            mcu_active_o  <= '1';
            if fpga_active_i = '1' then
               next_state <= switch_to_mcu;
            else
               next_state <= mcu_active;
            end if;

      end case;
   end process STATEMACHINE;

   -------------------------------------------------------------------
   --   State register with sync reset. Resets to mcu_active state
   -------------------------------------------------------------------
   STATE_REGISTER : process (clk_i, rst_i) is
   begin
      if (rising_edge(clk_i)) then
         if (rst_i = '1') then
            current_state <= mcu_active;
         else
            current_state <= next_state;
         end if;
      end if;
   end process STATE_REGISTER;

end fsm;
