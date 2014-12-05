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
-- 8 - B I T    G P I O    E A S Y    C O R E
-- (gpio8.vhd)
--
-- Structural
--
-- Adapts the verilog gpio module to vhdl and the wbs/wbm types
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
ENTITY gpio8 is
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface (with clock input)
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- GPIO pins 
      gpio0    : inout std_logic;
      gpio1    : inout std_logic;
      gpio2    : inout std_logic;
      gpio3    : inout std_logic;
      gpio4    : inout std_logic;
      gpio5    : inout std_logic;
      gpio6    : inout std_logic;
      gpio7    : inout std_logic
   );
end gpio8;


-------------------------------------------------------------------------------
ARCHITECTURE structural of gpio8 is
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
COMPONENT gpio_top is
-- this component is the link to the verilog module.
-- here, the signal names from simple_spi_top.v are used
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface
      wb_clk_i  : in  std_logic;                    -- clock
      wb_rst_i  : in  std_logic;                    -- reset (asynchronous active low)
      wb_cyc_i  : in  std_logic;                    -- cycle
      wb_stb_i  : in  std_logic;                    -- strobe
      wb_adr_i  : in  std_logic_vector(7 downto 0); -- address
      wb_we_i   : in  std_logic;                    -- write enable
      wb_dat_i  : in  std_logic_vector(31 downto 0);-- data input
      wb_dat_o  : out std_logic_vector(31 downto 0);-- data output
      wb_ack_o  : out std_logic;                    -- bus termination
      wb_inta_o : out std_logic;                    -- interrupt output
      wb_sel_i  : in  std_logic_vector(3 downto 0); -- byte select (constant "0001")

      -- GPIO interface
      ext_pad_o :    out std_logic_vector(7 downto 0); -- GPIO outputs
      ext_pad_i :    in  std_logic_vector(7 downto 0); -- GPIO inputs
      ext_padoe_o :  out std_logic_vector(7 downto 0)  -- output driver enables
   );
END COMPONENT;


signal ext_pad_i_s   : std_logic_vector(7 downto 0);
signal ext_pad_o_s   : std_logic_vector(7 downto 0);
signal ext_padoe_o_s : std_logic_vector(7 downto 0);

signal dat_i_tmp_s   : std_logic_vector(31 downto 0);
signal dat_o_tmp_s   : std_logic_vector(31 downto 0);

signal wb_sel_s      : std_logic_vector(3 downto 0);

--------------------------------------------------------------------------------
begin -- architecture structural
-------------------------------------------------------------------------------

-- data width adaption
dat_i_tmp_s <= x"000000" & wbs_in.dat;
wbs_out.dat <= dat_o_tmp_s(7 downto 0);

-- constant byte selection lines
wb_sel_s <= "0001";

-- tristate-able drivers
ext_pad_i_s(0) <= gpio0;
gpio0          <= 'Z' when ext_padoe_o_s(0) = '0' else ext_pad_o_s(0);
ext_pad_i_s(1) <= gpio1;
gpio1          <= 'Z' when ext_padoe_o_s(1) = '0' else ext_pad_o_s(1);
ext_pad_i_s(2) <= gpio2;
gpio2          <= 'Z' when ext_padoe_o_s(2) = '0' else ext_pad_o_s(2);
ext_pad_i_s(3) <= gpio3;
gpio3          <= 'Z' when ext_padoe_o_s(3) = '0' else ext_pad_o_s(3);
ext_pad_i_s(4) <= gpio4;
gpio4          <= 'Z' when ext_padoe_o_s(4) = '0' else ext_pad_o_s(4);
ext_pad_i_s(5) <= gpio5;
gpio5          <= 'Z' when ext_padoe_o_s(5) = '0' else ext_pad_o_s(5);
ext_pad_i_s(6) <= gpio6;
gpio6          <= 'Z' when ext_padoe_o_s(6) = '0' else ext_pad_o_s(6);
ext_pad_i_s(7) <= gpio7;
gpio7          <= 'Z' when ext_padoe_o_s(7) = '0' else ext_pad_o_s(7);

-------------------------------------------------------------------------------
GPIO_CORE : gpio_top
-------------------------------------------------------------------------------
   port map (
      -- WISHBONE interface
      wb_clk_i    => wbs_in.clk,
      wb_rst_i    => wbs_in.rst,
      wb_cyc_i    => wbs_in.cyc,
      wb_stb_i    => wbs_in.stb,
      wb_adr_i    => wbs_in.adr(7 downto 0),
      wb_we_i     => wbs_in.we,
      wb_dat_i    => dat_i_tmp_s,
      wb_dat_o    => dat_o_tmp_s,
      wb_ack_o    => wbs_out.ack,
      wb_inta_o   => wbs_out.irq,
      wb_sel_i    => wb_sel_s,

      -- GPIO interface
      ext_pad_o   => ext_pad_o_s,
      ext_pad_i   => ext_pad_i_s,
      ext_padoe_o => ext_padoe_o_s
   );

end structural;
