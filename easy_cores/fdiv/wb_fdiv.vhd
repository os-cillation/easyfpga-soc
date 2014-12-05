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
-- W I S H B O N E    V A R I A B L E    F R E Q U E N C Y    D I V I D E R
-- (wb_fdiv.vhd)
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
entity wb_fdiv is
-------------------------------------------------------------------------------
   generic (
      USER_CLK : Boolean := false
   );
   port (
      -- wishbone
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- user pins
      clk_in   : in  std_logic := '-'; -- optional alternative clock input
      clk_out  : out std_logic
   );
end wb_fdiv;

-------------------------------------------------------------------------------
architecture mixed of wb_fdiv is
-------------------------------------------------------------------------------
   signal divide_s : std_logic_vector(WB_DW-1 downto 0);
   signal raw_clk_s : std_logic;
   signal div_clk_s : std_logic;

begin

   -- select raw clock using USER_CLK generic
   raw_clk_s <= clk_in when USER_CLK else wbs_in.clk;

   ----------------------------------------------------------------------------
   WISHBONE_SLAVE : entity work.wbs_single_reg
   ----------------------------------------------------------------------------
      port map (
         wbs_in         => wbs_in,
         wbs_out        => wbs_out,
         register_out   => divide_s
      );

   ----------------------------------------------------------------------------
   FDIV : process(divide_s, raw_clk_s)
   ----------------------------------------------------------------------------
      variable cnt : integer range 0 to 255 := 0;
      variable cmp : integer range 0 to 255;
   begin
      cmp := to_integer(unsigned(divide_s));

      -- clk_out is deactivated when divider is 0
      if (cmp = 0) then
         div_clk_s <= '0';

      -- decrement cmp since counting from 0
      cmp := cmp - 1;

      -- toggle clk_out when cnt reaches cmp
      elsif (rising_edge(raw_clk_s)) then
         if (cnt < cmp) then
            cnt := cnt + 1;
         else
            div_clk_s <= not div_clk_s;
            cnt := 0;
         end if;

      end if;
   end process FDIV;

   ----------------------------------------------------------------------------
   CLK_OUT_BUFFER : BUFG
   ----------------------------------------------------------------------------
   port map (
      O => clk_out,
      I => div_clk_s
   );

end mixed;
