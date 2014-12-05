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
-- S I M P L E    W I S H B O N E   S L A V E (wbs_single_reg.vhd)
--
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------
entity wbs_single_reg is
   generic (
      core_address : unsigned(WB_CORE_AW-1 downto 0) := (others => '0')
   );
   port (
      wbs_in    : in  wbs_in_type;
      wbs_out   : out wbs_out_type;

      -- permanently outputs the data stored in the register
      register_out : out std_logic_vector(WB_DW-1 downto 0)
   );
end wbs_single_reg;

architecture two_proc of wbs_single_reg is

   type reg_type is record
      data : std_logic_vector(WB_DW-1 downto 0);
   end record;

   signal reg_out, reg_in : reg_type;
   signal ff_clk_enable_s : std_logic;
   signal addr_match_s    : std_logic;
begin

-------------------------------------------------------------------------------
   COMBINATIONAL : process(wbs_in, reg_out, addr_match_s)
-------------------------------------------------------------------------------
      variable tmp : reg_type;
   begin
      tmp := reg_out;                                 -- default assignments

      -- data input and synchronous reset
      if (wbs_in.rst = '1') then
         tmp.data := (others => '0');
      else
         tmp.data := wbs_in.dat;
      end if;

      -- address comparator
      if (unsigned(wbs_in.adr) = core_address) then
         addr_match_s <= '1';
      else
         addr_match_s <= '0';
      end if;

      -- wishbone data output: on compare match only
      if (addr_match_s = '1') then
         wbs_out.dat <= reg_out.data;
      else
         wbs_out.dat <= (others => '0');
      end if;

      -- register clock enable signal
      ff_clk_enable_s <= wbs_in.stb AND wbs_in.we AND addr_match_s;

      -- acknowledge output
      wbs_out.ack <= wbs_in.stb;

      -- data output: always register content
      register_out <= reg_out.data;

      reg_in <= tmp;                                  -- drive register inputs

   end process COMBINATIONAL;

-------------------------------------------------------------------------------
   REGISTERS : process(wbs_in.clk, ff_clk_enable_s)        -- sequential process
-------------------------------------------------------------------------------
   begin
      if (rising_edge(wbs_in.clk) AND ff_clk_enable_s = '1') then
         reg_out <= reg_in;
      end if;
   end process REGISTERS;

end two_proc;
