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
-- S P I   E A S Y   C O R E
-- (spi.vhd)
--
-- Structural
--
-- Adapts the verilog spi module to vhdl and the wbs/wbm types
--
-- The reset input is inverted to be active-high
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
ENTITY spi is
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface (with clock input)
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- SPI master interface
      sck_out  : out std_logic;
      mosi_out : out std_logic;
      miso_in  : in  std_logic
   );
end spi;


-------------------------------------------------------------------------------
ARCHITECTURE structural of spi is
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
COMPONENT simple_spi_top is
-- this component is the link to the verilog module.
-- here, the signal names from simple_spi_top.v are used
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface
      clk_i    : in  std_logic;                    -- clock
      rst_i    : in  std_logic;                    -- reset (asynchronous active low)
      cyc_i    : in  std_logic;                    -- cycle
      stb_i    : in  std_logic;                    -- strobe
      adr_i    : in  std_logic_vector(1 downto 0); -- address
      we_i     : in  std_logic;                    -- write enable
      dat_i    : in  std_logic_vector(7 downto 0); -- data input
      dat_o    : out std_logic_vector(7 downto 0); -- data output
      ack_o    : out std_logic;                    -- bus termination
      inta_o   : out std_logic;                    -- interrupt output

      -- SPI port
      sck_o    : out std_logic;                    -- serial clock output
      mosi_o   : out std_logic;                    -- MasterOut SlaveIN
      miso_i   : in  std_logic                     -- MasterIn SlaveOut
   );
END COMPONENT;

signal rst_active_low : std_logic;

--------------------------------------------------------------------------------
begin -- architecture structural
-------------------------------------------------------------------------------

-- invert reset signal
rst_active_low <= not wbs_in.rst;

-------------------------------------------------------------------------------
SPI_CORE : simple_spi_top
-------------------------------------------------------------------------------
   port map (
      clk_i    => wbs_in.clk,

      -- WISHBONE interface
      rst_i    => rst_active_low,
      cyc_i    => wbs_in.cyc,
      stb_i    => wbs_in.stb,
      adr_i    => wbs_in.adr(1 downto 0),
      we_i     => wbs_in.we,
      dat_i    => wbs_in.dat,
      dat_o    => wbs_out.dat,
      ack_o    => wbs_out.ack,
      inta_o   => wbs_out.irq,

      -- SPI port
      sck_o    => sck_out,
      mosi_o   => mosi_out,
      miso_i   => miso_in
   );

end structural;
