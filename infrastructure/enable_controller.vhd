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
   --   State register with async reset. Resets to mcu_active state
   -------------------------------------------------------------------
   STATE_REGISTER : process (clk_i, rst_i) is
   begin
      if rst_i = '1' then
         current_state <= mcu_active;
      elsif rising_edge(clk_i) then
         current_state <= next_state;
      end if;
   end process STATE_REGISTER;

end fsm;
