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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;

package interfaces is

-------------------------------------------------------------------------------
-- Wishbone slave
-------------------------------------------------------------------------------

   ----------------------------------------------
   type wbs_in_type is record
   ----------------------------------------------
      clk : std_logic;
      -- standard wishbone signals
      rst : std_logic;
      dat : std_logic_vector(WB_DW-1 downto 0);
      adr : std_logic_vector(WB_REG_AW-1 downto 0);
      stb : std_logic;
      cyc : std_logic;
      we  : std_logic;
   end record;

   ----------------------------------------------
   type wbs_out_type is record
   ----------------------------------------------
      -- standard wishbone signals
      dat : std_logic_vector(WB_DW-1 downto 0);
      ack : std_logic;
      -- interrupt request
      irq : std_logic;
   end record;

-------------------------------------------------------------------------------
-- Wishbone Master (part of frame controller)
-------------------------------------------------------------------------------

   ----------------------------------------------
   type wbm_in_type is record
   ----------------------------------------------
      clk   : std_logic;
      dat   : std_logic_vector(WB_DW-1 downto 0);
      ack   : std_logic;

      -- interrupt related:
      girq    : std_logic;
      int_adr : std_logic_vector(WB_CORE_AW-1 downto 0);

   end record;

   ----------------------------------------------
   type wbm_out_type is record
   ----------------------------------------------
      dat   : std_logic_vector(WB_DW-1 downto 0);
      adr   : std_logic_vector(WB_AW-1 downto 0);
      stb   : std_logic;
      we    : std_logic;
      cyc   : std_logic;
   end record;

-------------------------------------------------------------------------------
-- Frame controller
-------------------------------------------------------------------------------

   ----------------------------------------------
   type frame_ctrl_in_type is record
   ----------------------------------------------
      recbuf_complete   : std_logic;
      recbuf_frame      : std_logic_vector((PROTO_WC_RX_MAX*FIFO_WIDTH)-1 downto 0);
      trabuf_busy       : std_logic;
   end record;

   ----------------------------------------------
   type frame_ctrl_out_type is record
   ----------------------------------------------
      recbuf_clear      : std_logic;
      trabuf_frame      : std_logic_vector((PROTO_WC_TX_MAX*FIFO_WIDTH)-1 downto 0);
      trabuf_valid      : std_logic;
      mcu_select        : std_logic;
      transmitter_mode  : std_logic;
      trabuf_length     : integer range 0 to PROTO_WC_TX_MAX;
   end record;

   ----------------------------------------------
   component frame_ctrl
   ----------------------------------------------
      port (
         clk   : in  std_logic;
         rst   : in  std_logic;
         d     : in  frame_ctrl_in_type;
         q     : out frame_ctrl_out_type;
         wbi   : in  wbm_in_type;
         wbo   : out wbm_out_type
      );
   end component;

end package;
