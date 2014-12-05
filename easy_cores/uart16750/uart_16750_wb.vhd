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
-- E A S Y C O R E    U A R T    1 6 7 5 0
--
-- wishbone-wrapper for uart_16750.vhd
--
-- @author Simon Gansen
-------------------------------------------------------------------------------
library ieee ;
use ieee.std_logic_1164.all ;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
ENTITY uart_16750_wb is
-------------------------------------------------------------------------------
	port(
	   -- wishbone interface
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- uart interface
      TXD_o   : out std_logic;         -- Transmitter output
      RXD_i	  : in std_logic;          -- Receiver input
      CTSn_i  : in std_logic := '1';   -- Clear to send input
      RTSn_o  : out std_logic;         -- Request to send output
      DSRn_i  : in std_logic := '1';   -- Data set ready input
      RIn_i   : in std_logic := '1';   -- Ring indicator input
      DCDn_i  : in std_logic := '1';   -- Data carrier detect input
      DTRn_o  : out std_logic;         -- Data terminal ready output
      AUX1_o  : out std_logic;         -- MCR auxiliary output 1
      AUX2_o  : out std_logic          -- MCR auxiliary output 2
   );
end uart_16750_wb;

-------------------------------------------------------------------------------
ARCHITECTURE structural of uart_16750_wb is
-------------------------------------------------------------------------------

   signal c_rst_s       : std_logic;
   signal c_wr_s        : std_logic;
   signal c_rd_s        : std_logic;
   signal c_adr_s       : std_logic_vector(2 downto 0);
   signal c_din_s       : std_logic_vector(7 downto 0);
   signal c_dout_s      : std_logic_vector(7 downto 0);

   signal c_aux1n_s     : std_logic;
   signal c_aux2n_s     : std_logic;

   signal c_baudoutn_s  : std_logic;
   signal c_rclk_s      : std_logic;

-------------------------------------------------------------------------------
begin -- architecture structural
-------------------------------------------------------------------------------

   -- address in
   c_adr_s <= wbs_in.adr(2 downto 0);

   -- data in/out
   c_din_s <= wbs_in.dat;
   wbs_out.dat <= c_dout_s;

   -- wishbone acknowledge output
   wbs_out.ack <= wbs_in.stb;

   -- read/write lines are only asserted when cyc is high
   c_wr_s <= wbs_in.stb and wbs_in.cyc and wbs_in.we;
   c_rd_s <= wbs_in.stb and wbs_in.cyc and not wbs_in.we;

   -- reset input (async <= sync)
   c_rst_s <= wbs_in.rst;

   -- feedback clock (16x baudrate)
   c_rclk_s <= c_baudoutn_s;

   -- re-invert auxiliary outputs
   AUX1_o <= not c_aux1n_s;
   AUX2_o <= not c_aux2n_s;

-------------------------------------------------------------------------------
UART_CORE : entity work.uart_16750
-------------------------------------------------------------------------------
   port map (
      -- internal bus interface to be adapted to wishbone
      CLK => wbs_in.clk,         -- Clock
      RST => c_rst_s,            -- Async Reset
      WR => c_wr_s,              -- Write to UART
      RD => c_rd_s,              -- Read from UART
      A => c_adr_s,              -- Register select
      DIN => c_din_s,            -- Data bus input
      DOUT => c_dout_s,          -- Data bus output
      INT => wbs_out.irq,        -- Interrupt output

      -- UART interface
      RTSN => RTSn_o,            -- RTS output
      DTRN => DTRn_o,            -- DTR output
      CTSN => CTSn_i,            -- CTS input
      DSRN => DSRn_i,            -- DSR input
      DCDN => DCDn_i,            -- DCD input
      RIN => RIn_i,              -- RI input
      SIN => RXD_i,              -- Receiver input
      SOUT => TXD_o,             -- Transmitter output
      OUT1N => c_aux1n_s,        -- MCR auxiliary output 1
      OUT2N => c_aux2n_s,        -- MCR auxiliary output 2

      -- to be tied together
      BAUDOUTN => c_baudoutn_s,  -- Baudrate generator output (16x baudrate)
      RCLK => c_rclk_s           -- Receiver clock (16x baudrate)
   );

end structural;
