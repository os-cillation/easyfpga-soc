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

----------------------------------------------------------------------------------
-- F I F O   A D A P T E R
-- Asynchronous entity to tristate external pins if disabled
-- and invert control signals to be high active
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity fifo_adapter is
   port (
      -- external fifo pins
      data_pins : inout std_logic_vector(7 downto 0);
      rxf_pin   : in std_logic;
      txd_pin   : in std_logic;
      wr_pin    : out std_logic;
      rd_pin    : out std_logic;

      -- internal fifo signals
      enable_i          : in std_logic; -- async enable
      direction_i       : in std_logic; -- data direction (0:receive, 1:send)
      data_transmit_i   : in std_logic_vector(7 downto 0);
      data_receive_o    : out std_logic_vector(7 downto 0);
      rxf_o             : out std_logic;
      txd_o             : out std_logic;
      wr_i              : in std_logic;
      rd_i              : in std_logic
   );
end fifo_adapter;

architecture async of fifo_adapter is
begin
   -- receive data (dir=0)
   data_receive_o  <= data_pins when (enable_i='1' and direction_i='0')
                      else (others => '0');
   -- send data (dir=1)
   data_pins <= data_transmit_i when (enable_i='1' and direction_i='1')
                else (others => 'Z');

   -- control pins: connect when enabled
   rxf_o    <= not rxf_pin when enable_i = '1' else '0';
   txd_o    <= not txd_pin when enable_i = '1' else '0';
   wr_pin   <= wr_i        when enable_i = '1' else 'Z';
   rd_pin   <= not rd_i    when enable_i = '1' else 'Z';
end async;
