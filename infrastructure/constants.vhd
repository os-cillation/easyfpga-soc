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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is
   ---------------------------------
   -- protcol opcodes and lengthes
   ---------------------------------
   constant ACK_OPC           : std_logic_vector(7 downto 0) := x"00";
   constant ACK_LEN           : integer := 3;

   constant NACK_OPC          : std_logic_vector(7 downto 0) := x"11";
   constant NACK_LEN          : integer := 4;

   constant MCU_SEL_OPC       : std_logic_vector(7 downto 0) := x"55";
   constant MCU_SEL_LEN       : integer := 3;

   -- detect (who is communicating)
   constant DETECT_OPC        : std_logic_vector(7 downto 0) := x"EE";
   constant DETECT_LEN        : integer := 1;

   constant DETECT_REPLY_OPC  : std_logic_vector(7 downto 0) := x"FF";
   constant DETECT_REPLY_LEN  : integer := 3;

   constant DETECT_REPLY_FPGA : std_logic_vector(7 downto 0) := x"EF";

   -- write operations
   constant REGISTER_WR_OPC   : std_logic_vector(7 downto 0) := x"66";
   constant REGISTER_WR_LEN   : integer := 6;

   constant REGISTER_MWR_OPC  : std_logic_vector(7 downto 0) := x"65";
   constant REGISTER_MWR_LEN  : integer := 6; -- minimal length (no data)

   constant REGISTER_AWR_OPC  : std_logic_vector(7 downto 0) := x"69";
   constant REGISTER_AWR_LEN  : integer := 6; -- minimal length (no data)

   -- read operations and replies
   constant REGISTER_RD_OPC   : std_logic_vector(7 downto 0) := x"77";
   constant REGISTER_RD_LEN   : integer := 5;

   constant REGISTER_RDRE_OPC : std_logic_vector(7 downto 0) := x"88";
   constant REGISTER_RDRE_LEN : integer := 4;

   constant REGISTER_MRD_OPC  : std_logic_vector(7 downto 0) := x"73";
   constant REGISTER_MRD_LEN  : integer := 6;

   constant REGISTER_MRDRE_OPC : std_logic_vector(7 downto 0) := x"93";
   constant REGISTER_MRDRE_LEN : integer := 3; -- minimal length (no data)

   constant REGISTER_ARD_OPC  : std_logic_vector(7 downto 0) := x"79";
   constant REGISTER_ARD_LEN  : integer := 6;

   constant REGISTER_ARDRE_OPC : std_logic_vector(7 downto 0) := x"90";
   constant REGISTER_ARDRE_LEN : integer := 3; -- minimal length (no data)

   -- interrupts
   constant SOC_INT_OPC       : std_logic_vector(7 downto 0) := x"99";
   constant SOC_INT_LEN       : integer := 3;

   constant SOC_INT_EN_OPC    : std_logic_vector(7 downto 0) := x"AA";
   constant SOC_INT_EN_LEN    : integer := 3;

   ---------------------------------
   -- global protocol parameters
   ---------------------------------
   constant REGISTER_DAT_MAX  : integer := 255; -- maximum mwr/awr data length
   constant PROTO_WC_RX_MAX   : integer := 16; -- number of bytes that fit into rx buffer
   constant PROTO_WC_TX_MAX   : integer := 16; -- number of bytes that fit into tx buffer
   constant PROTO_WC_MAX      : integer := REGISTER_MWR_LEN + REGISTER_DAT_MAX; -- longest frame possible
   constant FIFO_WIDTH        : integer := 8;
   constant OPCODE_UNKNOWN_TIMEOUT : integer := 20;

   ---------------------------------
   -- error codes
   ---------------------------------
   constant ERROR_UNKNOWN     : std_logic_vector(7 downto 0) := x"00";
   constant ERROR_OPC_UNKNOWN : std_logic_vector(7 downto 0) := x"11";
   constant ERROR_PARITY      : std_logic_vector(7 downto 0) := x"22";
   constant ERROR_WB_TIMEOUT  : std_logic_vector(7 downto 0) := x"33";

   ---------------------------------
   -- wishbone
   ---------------------------------
   constant WB_DW : integer := 8;               -- data width
   constant WB_AW : integer := 16;              -- address width
   constant WB_CORE_AW  : integer := 8;         -- core base-address bits
                                                -- (encoded by intercon)
   constant WB_REG_AW   : integer := 8;         -- register address bits
                                                -- (encoded by core)

   constant WB_TIMEOUT_CYCLES : integer := 16;  -- clock cycles until
                                                -- timeout detection
end constants;
