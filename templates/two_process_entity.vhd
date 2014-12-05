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
-- <NAME>    (<NAME>.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- Type and component definition package
-------------------------------------------------------------------------------
package <NAME>_comp is

   type <NAME>_in_type is record
   end record;

   type <NAME>_out_type is record
   end record;

   component <NAME>
      port (
         clk   : in  std_logic;
         rst   : in  std_logic;
         d     : in  <NAME>_in_type;
         q     : out <NAME>_out_type
      );
   end component;

end package;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.<NAME>_comp.all;
-------------------------------------------------------------------------------
-- Entity
-------------------------------------------------------------------------------
entity <NAME> is
   port (
      clk   : in std_logic;
      rst   : in std_logic;
      d     : in <NAME>_in_type;
      q     : out <NAME>_out_type
   );
end <NAME>;

architecture two_proc of <NAME> is

   type reg_type is record
   end record;

   signal reg_out, reg_in : reg_type;

begin

-------------------------------------------------------------------------------
   COMBINATIONAL : process(d, reg_out)                -- combinational process
-------------------------------------------------------------------------------
      variable tmp : reg_type;
   begin
      tmp := reg_out;                                 -- default assignments

      ---algorithm-------------------------------------------------------------
      -------------------------------------------------------------------------

      reg_in <= tmp;                                  -- drive register inputs

   end process COMBINATIONAL;

-------------------------------------------------------------------------------
   REGISTERS : process(clk,rst)                       -- sequential process
-------------------------------------------------------------------------------
   begin
      if (rst = '1') then
         -- TODO: reg_out.* <= '0'
      elsif rising_edge(clk) then
         reg_out <= reg_in;
      end if;
   end process REGISTERS;

end two_proc;
