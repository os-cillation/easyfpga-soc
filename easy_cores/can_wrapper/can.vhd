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
-- C A N   E A S Y   C O R E
-- (can.vhd)
--
-- Structural
--
-- Adapts the verilog can module to vhdl and the wbs/wbm types
--
-- @author Simon Gansen
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.interfaces.all;
use work.constants.all;

-------------------------------------------------------------------------------
ENTITY can is
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface (with clock input)
      wbs_in   : in  wbs_in_type;
      wbs_out  : out wbs_out_type;

      -- CAN bus interface
      can_tx_out        : out std_logic;
      can_rx_in         : in  std_logic
   );
end can;


-------------------------------------------------------------------------------
ARCHITECTURE mixed of can is
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
COMPONENT can_top is
-- this component is the link to the verilog module.
-- here, the signal names from can_top.v are used
-------------------------------------------------------------------------------
   port (
      -- WISHBONE interface
      wb_clk_i : in  std_logic;                    -- wishbone clock
      wb_rst_i : in  std_logic;                    -- reset (asynchronous active high)
      wb_cyc_i : in  std_logic;                    -- cycle
      wb_stb_i : in  std_logic;                    -- strobe
      wb_adr_i : in  std_logic_vector(7 downto 0); -- address
      wb_we_i  : in  std_logic;                    -- write enable
      wb_dat_i : in  std_logic_vector(7 downto 0); -- data input
      wb_dat_o : out std_logic_vector(7 downto 0); -- data output
      wb_ack_o : out std_logic;                    -- bus termination

      -- Signals that will also be connected to wishbone
      irq_on   : out std_logic;                    -- interrupt output
      clk_i    : in  std_logic;                    -- "normal" clock input

      -- CAN bus interface
      bus_off_on  : out std_logic;                 -- direction output. '0' when receiving
      rx_i        : in  std_logic;                 -- receive input
      tx_o        : out std_logic                  -- transmit output
   );
END COMPONENT;

   signal reset_s           : std_logic;
   signal initial_reset_s   : std_logic;           -- '1' at the beginning, '0'
                                                   -- after 15 clock cycles
   signal irq_n_s           : std_logic;           -- inverted irq signal

-------------------------------------------------------------------------------
begin -- architecture mixed
-------------------------------------------------------------------------------

-- both wishbone and initial reset signals will work
reset_s <= wbs_in.rst OR initial_reset_s;

-- make irq signal active-high
wbs_out.irq <= not irq_n_s;

-------------------------------------------------------------------------------
CAN_CORE : can_top
-------------------------------------------------------------------------------
   port map (
      -- "normal" clock is also wishbone clock
      clk_i       => wbs_in.clk,
      
      -- WISHBONE interface
      wb_clk_i    => wbs_in.clk,
      wb_rst_i    => reset_s,
      wb_cyc_i    => wbs_in.cyc,
      wb_stb_i    => wbs_in.stb,
      wb_adr_i    => wbs_in.adr,
      wb_we_i     => wbs_in.we,
      wb_dat_i    => wbs_in.dat,
      wb_dat_o    => wbs_out.dat,
      wb_ack_o    => wbs_out.ack,
      irq_on      => irq_n_s,

      -- CAN bus interface
      rx_i        => can_rx_in,
      tx_o        => can_tx_out
   );

-------------------------------------------------------------------------------
INITIAL_RESET : process (wbs_in.clk)
-------------------------------------------------------------------------------
   variable cnt : integer range 0 to 15 := 0;
begin
   if (rising_edge(wbs_in.clk)) then
      if (cnt < 15) then
         cnt := cnt + 1;
         initial_reset_s <= '1';
      else
         initial_reset_s <= '0';
      end if;
   end if;
end process INITIAL_RESET;

end mixed;
