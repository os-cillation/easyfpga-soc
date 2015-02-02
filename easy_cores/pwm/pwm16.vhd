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
-- 16-bit PWM using two-process design pattern
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- Type and component definition package
-------------------------------------------------------------------------------
package pwm16_comp is

   type pwm16_in_type is record
      duty_cycle    : std_logic_vector(15 downto 0);
   end record;

   component pwm16
      port (
         clk   : in  std_logic;
         rst   : in  std_logic;
         d     : in  pwm16_in_type;
         pwm   : out std_logic
      );
   end component;

end package;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pwm16_comp.all;

-------------------------------------------------------------------------------
ENTITY pwm16 is
-------------------------------------------------------------------------------
   port (
      clk   : in std_logic;
      rst   : in std_logic;
      d     : in pwm16_in_type;
      pwm   : out std_logic
   );
end pwm16;

-------------------------------------------------------------------------------
ARCHITECTURE two_proc of pwm16 is
-------------------------------------------------------------------------------

   type reg_type is record
      pwm_cnt        : unsigned(15 downto 0);   -- pwm counter
   end record;

   signal reg_out, reg_in : reg_type;

begin

-------------------------------------------------------------------------------
   COMBINATIONAL : process(d, reg_out)
-------------------------------------------------------------------------------
      variable tmp_var : reg_type;
   begin
      tmp_var := reg_out;                             -- default assignments

      ---algorithm-------------------------------------------------------------

      -- PWM: reset on overflow, increment otherwise
      if (tmp_var.pwm_cnt = 2**16-1) then
         tmp_var.pwm_cnt := (others => '0');
      else
         tmp_var.pwm_cnt := reg_out.pwm_cnt + 1;
      end if;

      -- compare and drive output
      if (tmp_var.pwm_cnt >= unsigned(d.duty_cycle)) then
         pwm <= '0';
      else
         pwm <= '1';
      end if;

      -------------------------------------------------------------------------

      reg_in <= tmp_var;                              -- drive register inputs

   end process COMBINATIONAL;

-------------------------------------------------------------------------------
   REGISTERS : process(clk,rst)
-------------------------------------------------------------------------------
   begin
      if rising_edge(clk) then
         if (rst = '1') then
            reg_out.pwm_cnt      <= (others => '0');
         else
            reg_out <= reg_in;
         end if;
      end if;
   end process REGISTERS;

end two_proc;
