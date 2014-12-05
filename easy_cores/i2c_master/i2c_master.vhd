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
-- I 2 C   M A S T E R   E A S Y   C O R E
-- (i2c_master.vhd)
--
-- Structural
--
-- Adapts the i2c_master_top module to easyFPGA
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
ENTITY i2c_master is
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface (with clock input)
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- I2C master interface
      i2c_sda_io : inout  std_logic;
      i2c_scl_io : inout  std_logic
   );
end i2c_master;


-------------------------------------------------------------------------------
ARCHITECTURE structural of i2c_master is
-------------------------------------------------------------------------------

signal scl_pad_i_s    : std_logic; -- i2c clock line input
signal scl_pad_o_s    : std_logic; -- i2c clock line output
signal scl_padoen_o_s : std_logic; -- i2c clock line output enable, active low
signal sda_pad_i_s    : std_logic; -- i2c data line input
signal sda_pad_o_s    : std_logic; -- i2c data line output
signal sda_padoen_o_s : std_logic; -- i2c data line output enable, active low

-------------------------------------------------------------------------------
begin -- architecture structural
-------------------------------------------------------------------------------

-- tristate drivers
sda_pad_i_s <= i2c_sda_io;
i2c_sda_io  <= 'Z' when sda_padoen_o_s = '1' else sda_pad_o_s;
scl_pad_i_s <= i2c_scl_io;
i2c_scl_io  <= 'Z' when scl_padoen_o_s = '1' else scl_pad_o_s;

-------------------------------------------------------------------------------
I2C_MASTER_CORE : entity work.i2c_master_top -- vhdl'93-style direct instance
-------------------------------------------------------------------------------
   port map (
      -- WISHBONE interface
      wb_clk_i    => wbs_in.clk,
      wb_rst_i    => wbs_in.rst,
      wb_cyc_i    => wbs_in.cyc,
      wb_stb_i    => wbs_in.stb,
      wb_adr_i    => wbs_in.adr(2 downto 0),
      wb_we_i     => wbs_in.we,
      wb_dat_i    => wbs_in.dat,
      wb_dat_o    => wbs_out.dat,
      wb_ack_o    => wbs_out.ack,
      wb_inta_o   => wbs_out.irq,

      -- Unidirectional I2C lines
      scl_pad_i    => scl_pad_i_s,
      scl_pad_o    => scl_pad_o_s,
      scl_padoen_o => scl_padoen_o_s,
      sda_pad_i    => sda_pad_i_s,
      sda_pad_o    => sda_pad_o_s,
      sda_padoen_o => sda_padoen_o_s
   );

end structural;
