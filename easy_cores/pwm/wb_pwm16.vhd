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
-- W I S H B O N E    C O M P L I A N T    P W M 16
-- (wb_pwm16.vhd)
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

use work.pwm16_comp.all;
--use work.wbs_defs.all;

-------------------------------------------------------------------------------
entity wb_pwm16 is
-------------------------------------------------------------------------------
   generic (
      USER_CLK : Boolean := false
   );
   port (
      -- wishbone
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- user pins
      clk_in   : in  std_logic := '-';    -- optinal alternative clock input
      pwm_out  : out std_logic
   );
end wb_pwm16;

-------------------------------------------------------------------------------
architecture structural of wb_pwm16 is
-------------------------------------------------------------------------------
   signal pwm_in_s   : pwm16_in_type;
   signal reg1_s     : std_logic_vector(WB_DW-1 downto 0);
   signal reg2_s     : std_logic_vector(WB_DW-1 downto 0);
   signal pwm_clk_s  : std_logic;
begin

-- select pwm clock using USER_CLK generic
pwm_clk_s <= clk_in when USER_CLK else wbs_in.clk;

   ----------------------------------------------------------------------------
   WISHBONE_SLAVE : entity work.wbs_dual_out
   ----------------------------------------------------------------------------
      port map (
         wbs_in         => wbs_in,
         wbs_out        => wbs_out,
         reg1_out       => reg1_s,
         reg2_out       => reg2_s
      );

   ----------------------------------------------------------------------------
   PWM_16 : entity work.pwm16
   ----------------------------------------------------------------------------
      port map (
         clk   => pwm_clk_s,
         rst   => wbs_in.rst,
         d     => pwm_in_s,
         pwm   => pwm_out
      );
   -- connect boths wbs registers to pwm entity, reg2 contains the high-byte
   pwm_in_s.duty_cycle  <= reg2_s & reg1_s;

end structural;
