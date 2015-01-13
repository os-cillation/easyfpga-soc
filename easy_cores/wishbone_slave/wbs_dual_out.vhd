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
--   W I S H B O N E   S L A V E  (wbs_dual_out.vhd)
--   with two output registers
--
--   @author Simon Gansen
-------------------------------------------------------------------------------

--===========================================================================--
-- Type and component definition package
--===========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.interfaces.all;

package wbs_defs is

   type wbs_reg_type is record
      reg1  : std_logic_vector(WB_DW-1 downto 0);
      reg2  : std_logic_vector(WB_DW-1 downto 0);
   end record;

   component wbs_dual_out
      port (
         -- wishbone interface
         wbs_in   : in  wbs_in_type;
         wbs_out  : out wbs_out_type;
         -- register outputs
         reg1_out : out std_logic_vector(WB_DW-1 downto 0);
         reg2_out : out std_logic_vector(WB_DW-1 downto 0)
      );
   end component;

end package;

--===========================================================================--
-- Entity
--===========================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;
use work.wbs_defs.all;

-------------------------------------------------------------------------------
entity wbs_dual_out is
-------------------------------------------------------------------------------
   port (
         -- wishbone interface
         wbs_in   : in  wbs_in_type;
         wbs_out  : out wbs_out_type;
         -- register outputs
         reg1_out : out std_logic_vector(WB_DW-1 downto 0);
         reg2_out : out std_logic_vector(WB_DW-1 downto 0)
   );
end wbs_dual_out;

-------------------------------------------------------------------------------
architecture behavioral of wbs_dual_out is
-------------------------------------------------------------------------------
   ----------------------------------------------
   -- register addresses
   ----------------------------------------------
   constant REG1_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"00";
   constant REG2_ADR : std_logic_vector(WB_REG_AW-1 downto 0) := x"01";

   ----------------------------------------------
   -- signals
   ----------------------------------------------
   signal reg_out_s, reg_in_s : wbs_reg_type;
   signal reg1_adr_match_s, reg2_adr_match_s : std_logic;
   signal reg1_ce_s, reg2_ce_s : std_logic;
begin

-------------------------------------------------------------------------------
-- Concurrent
-------------------------------------------------------------------------------

-- register address decoder/comparator
reg1_adr_match_s <= '1' when wbs_in.adr = REG1_ADR else '0';
reg2_adr_match_s <= '1' when wbs_in.adr = REG2_ADR else '0';

-- register CE
reg1_ce_s <= wbs_in.stb AND wbs_in.we AND reg1_adr_match_s;
reg2_ce_s <= wbs_in.stb AND wbs_in.we AND reg2_adr_match_s;

-- acknowledge output
wbs_out.ack <= wbs_in.stb;

-- register inputs always get data from wbs_in
reg_in_s.reg1 <= wbs_in.dat;
reg_in_s.reg2 <= wbs_in.dat;

-- register output -> wbs_out via demultiplexer
with wbs_in.adr select
   wbs_out.dat <= reg_out_s.reg1    when REG1_ADR,
                  reg_out_s.reg2    when REG2_ADR,
                  (others => '-')   when others;

-- register outputs -> non-wishbone outputs
reg1_out <= reg_out_s.reg1;
reg2_out <= reg_out_s.reg2;

-------------------------------------------------------------------------------
   REGISTERS : process(wbs_in.clk)
-------------------------------------------------------------------------------
   begin
      -- everything sync to clk
      if (rising_edge(wbs_in.clk)) then

         -- reset all registers
         if (wbs_in.rst = '1') then
            reg_out_s.reg1 <= (others => '0');
            reg_out_s.reg2 <= (others => '0');

         -- store reg1
         elsif (reg1_ce_s = '1') then
            reg_out_s.reg1 <= reg_in_s.reg1;

         -- store reg2
         elsif (reg2_ce_s = '1') then
            reg_out_s.reg2 <= reg_in_s.reg2;
         
         -- hold
         else
            reg_out_s <= reg_out_s;
         end if;
      end if;
   end process REGISTERS;

end behavioral;
