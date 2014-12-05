-------------------------------------------------------------------------------
-- S O C    B R I D G E    T E S T B E N C H    (soc_bridge_tb.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.interfaces.all;

-------------------------------------------------------------------------------
ENTITY soc_bridge_tb is
-------------------------------------------------------------------------------
begin
end soc_bridge_tb;

-------------------------------------------------------------------------------
ARCHITECTURE simulation of soc_bridge_tb is
-------------------------------------------------------------------------------
   -- constants
   constant CLK_PERIOD  : time := 25 ns;
   constant DATA_OUT_MAX : integer := 300;

   constant WBS1_ADR : std_logic_vector(WB_CORE_AW-1 downto 0) := x"01";
   constant WBS2_ADR : std_logic_vector(WB_CORE_AW-1 downto 0) := x"02";
   constant WBS3_ADR : std_logic_vector(WB_CORE_AW-1 downto 0) := x"03";
   constant WBS8_ADR : std_logic_vector(WB_CORE_AW-1 downto 0) := x"08"; -- alias for WBS3

   -- signals
   signal fpga_active_i : std_logic;
   signal mcu_active_o  : std_logic;

   signal fifo_data_io  : std_logic_vector(7 downto 0);
   signal fifo_rxf_n_i  : std_logic;
   signal fifo_txe_n_i  : std_logic;
   signal fifo_rd_n_o   : std_logic;
   signal fifo_wr_o     : std_logic;

   signal clk_s         : std_logic;

   signal wbm_out_s     : wbm_out_type;
   signal wbm_in_s      : wbm_in_type;

   -- wishbone slaves
   signal wbs1_in_s      : wbs_in_type;
   signal wbs1_out_s     : wbs_out_type;
   signal wbs1_reg1_out_s: std_logic_vector(7 downto 0);
   signal wbs1_reg2_out_s: std_logic_vector(7 downto 0);
   signal wbs2_in_s      : wbs_in_type;
   signal wbs2_out_s     : wbs_out_type;
   signal wbs2_reg1_out_s: std_logic_vector(7 downto 0);
   signal wbs2_reg2_out_s: std_logic_vector(7 downto 0);
   signal wbs3_in_s      : wbs_in_type;
   signal wbs3_out_s     : wbs_out_type;

   -- intercon signals
   signal core_adr_s  : std_logic_vector(WB_CORE_AW-1 downto 0);
   signal reg_adr_s   : std_logic_vector(WB_REG_AW-1 downto 0);

   signal adr_match_1_s : std_logic;
   signal adr_match_2_s : std_logic;
   signal adr_match_3_s : std_logic;

   signal wishbone_rst_s : std_logic;

   -- data output array (stores all bytes sent back by the soc bridge)
   type data_out_t is array (0 to DATA_OUT_MAX) of std_logic_vector(7 downto 0);
   signal data_out_s : data_out_t;
   signal data_out_cnt_s : integer range 0 to DATA_OUT_MAX;

-------------------------------------------------
procedure send_to_fifo (
-------------------------------------------------
   constant data   : in  unsigned;
   signal data_io  : out std_logic_vector(7 downto 0);
   signal rxf_n_i  : out std_logic;
   signal rd_n_o   : in  std_logic
   ) is
begin

   -- assert rxf and wait until rd was asserted
   rxf_n_i <= '0';
   wait until rd_n_o = '0';
   wait for 50 ns; -- T3: 20..50 ns

   -- apply data
   data_io <= std_logic_vector(data);

   -- wait until dut closes transfer
   wait until rd_n_o = '1';
   wait for 25 ns; -- T5: 0..25 ns
   rxf_n_i <= '1';

   -- hiZ data lines
   data_io <= (others => 'Z');

   wait for 80 ns; -- T6: >80 ns

end procedure send_to_fifo;


begin -- architecture simulation

------------------------------------------------------
   DATA_OUT : process(clk_s, fifo_wr_o, fifo_data_io)
------------------------------------------------------
   variable data_out_cnt : integer range 0 to DATA_OUT_MAX := 0;
begin
   if (falling_edge(fifo_wr_o)) then
      data_out_s(data_out_cnt) <= fifo_data_io;
      data_out_cnt := data_out_cnt + 1;
      data_out_cnt_s <= data_out_cnt;
   end if;
end process DATA_OUT;

-------------------------------------------------
   STIMULI_PROC :
-------------------------------------------------
process begin
   ------------------------------------
   -- init
   ------------------------------------
   wishbone_rst_s <= '1';
   fpga_active_i <= '0';
   fifo_rxf_n_i <= '1';
   fifo_txe_n_i <= '0';
   fifo_data_io <= (others => '-');
   wait for 100 ns;
   wishbone_rst_s <= '0';
   wait for CLK_PERIOD*10;

   ------------------------------------
   -- test fpga activation
   ------------------------------------
   assert false
      report "Will now activate fpga"
      severity note;
   fpga_active_i <= '1';
   wait for CLK_PERIOD*2;

   assert (mcu_active_o = '0')
      report   "enable_ctrl error"
      severity error;

   --------------------------------------------------------
   -- test reaction on status read (actually for the MCU)
   --------------------------------------------------------
   assert false
      report "Will now test reaction on status read"
      severity note;

   send_to_fifo(x"c3",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o);

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and -- nack
            data_out_s(data_out_cnt_s - 3) = x"00" and -- id
            data_out_s(data_out_cnt_s - 2) = x"11" and -- error code
            data_out_s(data_out_cnt_s - 1) = x"00")    -- parity
      report "Invalid answer to status read"
      severity error;

   ------------------------------------
   -- send register wr command
   ------------------------------------
   assert false
      report "Will now send REGISTER_WR"
      severity note;

   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"1D",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"53",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data
   send_to_fifo(x"29",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (wbs1_reg1_out_s = x"53")
      report "REGISTER_WR failed!"
      severity error;

   --------------------------------------------------
   -- send register wr command to non-existent core
   --------------------------------------------------
   assert false
      report "Will now send REGISTER_WR to non-existent core"
      severity note;

   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"1F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"1F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and -- nack
            data_out_s(data_out_cnt_s - 3) = x"1F" and -- id
            data_out_s(data_out_cnt_s - 2) = x"33" and -- error code
            data_out_s(data_out_cnt_s - 1) = x"3D")    -- parity
      report "Read back value differs from last write"
      severity error;

   ------------------------------------
   -- send register wr command (wrong parity)
   ------------------------------------
   assert false
      report "Will now send REGISTER_WR with wrong parity"
      severity note;

   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"1E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   ------------------------------------
   -- send register rd command
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"20",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"88" and -- rdre opcode
            data_out_s(data_out_cnt_s - 3) = x"20" and -- id
            data_out_s(data_out_cnt_s - 2) = x"53" and -- last write
            data_out_s(data_out_cnt_s - 1) = x"FB")    -- parity
      report "Register WR with wrong parity changed register"
      severity error;

   ------------------------------------
   -- send register rd command (wrong parity)
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity (wrong)

   wait for 10 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"21" and -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and -- error code
            data_out_s(data_out_cnt_s - 1) = x"12")    -- parity
      report "Unexpected reply to register RD with wrong parity"
      severity error;

   ------------------------------------
   -- send register mwr command
   ------------------------------------
   assert false
      report "Will now send REGISTER_MWR"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"1F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"AB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"BA",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   ------------------------------------
   -- send register rd command
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"20",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"88" and -- rdre opcode
            data_out_s(data_out_cnt_s - 3) = x"20" and -- id
            data_out_s(data_out_cnt_s - 2) = x"BA" and -- last write
            data_out_s(data_out_cnt_s - 1) = x"12")    -- parity
      report "Read back value differs from last write"
      severity error;

   -------------------------------------------------------------
   -- send register mwr command that requires partial reception
   -------------------------------------------------------------
   assert false
      report "Will now send a long REGISTER_MWR (14 data bytes)"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"0E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"11",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data4
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data5
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data6
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data7
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data8
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data9
   send_to_fifo(x"AA",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data10

   send_to_fifo(x"BB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data11
   send_to_fifo(x"CC",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data12
   send_to_fifo(x"DD",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data13
   send_to_fifo(x"7b",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity


   ------------------------------------
   -- send register rd command
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"20",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"88" and -- rdre opcode
            data_out_s(data_out_cnt_s - 3) = x"20" and -- id
            data_out_s(data_out_cnt_s - 2) = x"DD" and -- last write
            data_out_s(data_out_cnt_s - 1) = x"75")    -- parity
      report "Read back value differs from last write"
      severity error;

   -------------------------------------------------------------
   -- send register mwr command that failed on harware
   -------------------------------------------------------------
   assert false
      report "Will now send a long REGISTER_MWR (11 data bytes)"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"0E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"0B",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"30",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data4
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data5
   send_to_fifo(x"36",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data6
   send_to_fifo(x"37",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data7
   send_to_fifo(x"38",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data8
   send_to_fifo(x"39",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data9
   send_to_fifo(x"41",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data10
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity


   ------------------------------------
   -- send register rd command
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"20",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"88" and -- rdre opcode
            data_out_s(data_out_cnt_s - 3) = x"20" and -- id
            data_out_s(data_out_cnt_s - 2) = x"41" and -- last write
            data_out_s(data_out_cnt_s - 1) = x"E9")    -- parity
      report "Read back value differs from last write"
      severity error;

   --------------------------------------------------------------------
   -- send register mwr command that requires more partial receptions
   --------------------------------------------------------------------
   assert false
      report "Will now send a 64 byte long REGISTER_MWR"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"0e",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"40",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0 - sequence begin 0
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data4
   send_to_fifo(x"36",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data5
   send_to_fifo(x"37",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data6
   send_to_fifo(x"38",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data7
   send_to_fifo(x"39",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data8
   send_to_fifo(x"41",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data9
   send_to_fifo(x"42",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data10

   send_to_fifo(x"43",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data11
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data12
   send_to_fifo(x"45",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data13
   send_to_fifo(x"5F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data14
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data15 - sequence begin 1
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data16
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data17
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data18
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data19
   send_to_fifo(x"36",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data20
   send_to_fifo(x"37",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data21
   send_to_fifo(x"38",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data22
   send_to_fifo(x"39",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data23
   send_to_fifo(x"41",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data24
   send_to_fifo(x"42",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data25
   send_to_fifo(x"43",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data26

   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data27
   send_to_fifo(x"45",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data28
   send_to_fifo(x"5F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data29
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data30 - sequence begin 2
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data31
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data32
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data33
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data34
   send_to_fifo(x"36",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data35
   send_to_fifo(x"37",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data36
   send_to_fifo(x"38",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data37
   send_to_fifo(x"39",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data38
   send_to_fifo(x"41",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data39
   send_to_fifo(x"42",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data40
   send_to_fifo(x"43",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data41
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data42

   send_to_fifo(x"45",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data43
   send_to_fifo(x"5F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data44
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data45 - sequence begin 3
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data46
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data47
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data48
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data49
   send_to_fifo(x"36",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data50
   send_to_fifo(x"37",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data51
   send_to_fifo(x"38",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data52
   send_to_fifo(x"39",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data53
   send_to_fifo(x"41",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data54
   send_to_fifo(x"42",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data55
   send_to_fifo(x"43",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data56
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data57
   send_to_fifo(x"45",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data58

   send_to_fifo(x"5F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data59 - sequence begin 4
   send_to_fifo(x"31",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data60
   send_to_fifo(x"32",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data61
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data62
   send_to_fifo(x"34",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data63
   send_to_fifo(x"2E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (wbs1_reg1_out_s = x"34")
      report "REGISTER_MWR failed!"
      severity error;

   ------------------------------------
   -- send register rd command
   ------------------------------------
   assert false
      report "Will now send REGISTER_RD"
      severity note;

   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"20",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"88" and -- rdre opcode
            data_out_s(data_out_cnt_s - 3) = x"20" and -- id
            data_out_s(data_out_cnt_s - 2) = x"34" and -- last write
            data_out_s(data_out_cnt_s - 1) = x"9C")    -- parity
      report "Read back value differs from last write"
      severity error;

   --------------------------------------------------------------------
   -- send very short register mwr command
   --------------------------------------------------------------------
   assert false
      report "Will now send a very short REGISTER_MWR"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"23",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"46",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (wbs1_reg1_out_s = x"23")
      report "REGISTER_MWR failed!"
      severity error;

   -------------------------------------
   -- send register mwr with length 0
   -------------------------------------
   assert false
      report "Will now send REGISTER_MWR with length 0"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"45",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (wbs1_reg1_out_s = x"23")
      report "REGISTER_MWR with length 0 changed register content"
      severity error;

   --------------------------------------------------------------------
   -- send very short register mwr command with wrong parity
   --------------------------------------------------------------------
   assert false
      report "Will now send a very short REGISTER_MWR with wrong parity"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"19",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"FC",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"19" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"2A")      -- parity
      report "Did not reply NACK after REGISTER_MWR with wrong parity"
      severity error;

   -- this warning will be thrown since not all request data is known while
   -- already writing to registers. Parity check is performed afterwards.
   assert (wbs1_reg1_out_s = x"23")
      report "REGISTER_MWR with wrong parity affected register"
      severity warning;

   -----------------------------------------------------------
   -- send register mwr to non-existent core
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_MWR to non-existent core"
      severity note;

   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"56",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"09",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"90",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"05",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"11",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"11",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data4
   send_to_fifo(x"AF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"56" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"33" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"74")      -- parity
      report "Did not reply NACK after trying to access non-existent core"
      severity error;

   ------------------------------------
   -- send register awr command
   ------------------------------------
   assert false
      report "Will now send REGISTER_AWR"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"AB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"CD",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"EF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"C3",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert ((wbs1_reg1_out_s = x"AB") and (wbs1_reg2_out_s = x"CD"))
      report "Register AWR failed"
      severity error;

   ------------------------------------------------
   -- send register awr command with wrong parity
   ------------------------------------------------
   assert false
      report "Will now send REGISTER_AWR with wrong parity"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"AB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"CD",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"EF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"22" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"11")      -- parity
      report "Did not reply NACK after REGISTER_AWR with wrong parity"
      severity error;

   ------------------------------------------------------
   -- send register awr that failed in integration test
   ------------------------------------------------------
   assert false
      report "Will now send REGISTER_AWR with length 4"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"EF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"08",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"14",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"04",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"87",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"E6",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 3) = x"00" and   -- ACK opcode
            data_out_s(data_out_cnt_s - 2) = x"EF" and   -- id
            data_out_s(data_out_cnt_s - 1) = x"EF")      -- parity
      report "Did not reply ACK after REGISTER_AWR with length 4"
      severity error;

   -------------------------------------
   -- send register awr with length 0
   -------------------------------------
   assert false
      report "Will now send REGISTER_AWR with length 0"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"49",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert ((wbs1_reg1_out_s = x"AB") and (wbs1_reg2_out_s = x"CD"))
      report "Register AWR with length 0 changed register content"
      severity error;

   -----------------------------------------------------------
   -- send register awr that exceeds register address range
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_AWR that exceeds register address range - test wrap-around"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"21",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"FE",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"AB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"CD",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"EF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"3F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (wbs1_reg1_out_s = x"EF")
      report "Register AWR wrap-around failed"
      severity error;

   -----------------------------------------------------------
   -- send register awr to non-existent core
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_AWR to non-existent core"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"F0",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"F0",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"AB",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"CD",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"EF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"C1",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"22" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"33" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"00")      -- parity
      report "Did not reply NACK after trying to access non-existent core"
      severity error;

   -----------------------------------------------------------
   -- load 256-register core with data using awr
   -----------------------------------------------------------
   assert false
      report "Will now load data to 256 register core"
      severity note;

   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"69",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data0
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data1
   send_to_fifo(x"11",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data2
   send_to_fifo(x"11",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data3
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data4
   send_to_fifo(x"22",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data5
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data6
   send_to_fifo(x"33",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data7
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data8
   send_to_fifo(x"44",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data9
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data10
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data11
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data12
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data13
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data14
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data15
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data16
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data17
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data18
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data19
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data20
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data21
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data22
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data23
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data24
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data25
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data26
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data27
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data28
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data29
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data30
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data31
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data32
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data33
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data34
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data35
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data36
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data37
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data38
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data39
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data40
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data41
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data42
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data43
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data44
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data45
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data46
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data47
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data48
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data49
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data50
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data51
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data52
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data53
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data54
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data55
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data56
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data57
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data58
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data59
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data60
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data61
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data62
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data63
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data64
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data65
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data66
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data67
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data68
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data69
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data70
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data71
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data72
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data73
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data74
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data75
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data76
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data77
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data78
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data79
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data80
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data81
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data82
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data83
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data84
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data85
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data86
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data87
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data88
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data89
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data90
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data91
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data92
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data93
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data94
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data95
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data96
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data97
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data98
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data99
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data100
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data101
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data102
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data103
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data104
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data105
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data106
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data107
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data108
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data109
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data110
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data111
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data112
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data113
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data114
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data115
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data116
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data117
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data118
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data119
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data120
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data121
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data122
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data123
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data124
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data125
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data126
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data127
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data128
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data129
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data130
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data131
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data132
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data133
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data134
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data135
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data136
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data137
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data138
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data139
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data140
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data141
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data142
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data143
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data144
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data145
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data146
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data147
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data148
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data149
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data150
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data151
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data152
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data153
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data154
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data155
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data156
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data157
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data158
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data159
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data160
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data161
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data162
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data163
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data164
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data165
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data166
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data167
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data168
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data169
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data170
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data171
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data172
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data173
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data174
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data175
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data176
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data177
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data178
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data179
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data180
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data181
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data182
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data183
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data184
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data185
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data186
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data187
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data188
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data189
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data190
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data191
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data192
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data193
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data194
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data195
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data196
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data197
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data198
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data199
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data200
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data201
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data202
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data203
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data204
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data205
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data206
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data207
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data208
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data209
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data210
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data211
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data212
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data213
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data214
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data215
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data216
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data217
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data218
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data219
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data220
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data221
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data222
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data223
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data224
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data225
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data226
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data227
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data228
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data229
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data230
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data231
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data232
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data233
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data234
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data235
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data236
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data237
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data238
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data239
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data240
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data241
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data242
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data243
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data244
   send_to_fifo(x"77",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data245
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data246
   send_to_fifo(x"88",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data247
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data248
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data249
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data250
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data251
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data252
   send_to_fifo(x"66",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data253
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- data254
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 3) = x"00" and   -- ACK opcode
            data_out_s(data_out_cnt_s - 2) = x"69" and   -- id
            data_out_s(data_out_cnt_s - 1) = x"69")      -- parity
      report "Did not reply ACK after 256-byte AWR"
      severity error;

   -----------------------------------------------------------
   -- send register ard to read two bytes
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_ARD with length 2"
      severity note;

   send_to_fifo(x"79",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"23",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"02",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"59",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 10 us;
   assert(  data_out_s(data_out_cnt_s - 5) = x"90" and   -- ARDRE opcode
            data_out_s(data_out_cnt_s - 4) = x"23" and   -- id
            data_out_s(data_out_cnt_s - 3) = x"EF" and   -- data0
            data_out_s(data_out_cnt_s - 2) = x"CD" and   -- data1
            data_out_s(data_out_cnt_s - 1) = x"91")      -- parity
      report "Reading 2 bytes using ARD failed"
      severity error;

   -----------------------------------------------------------
   -- send register ard to non-existent core
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_ARD to non-existent core"
      severity note;

   send_to_fifo(x"79",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"24",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"02",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"5F",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"24" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"33" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"06")      -- parity
      report "Did not reply NACK after trying to access (ARD) non-existent core"
      severity error;

   -----------------------------------------------------------
   -- send register ard to with wrong parity
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_ARD with wrong parity"
      severity note;

   send_to_fifo(x"79",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"25",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"FF",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"12",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"12",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"25" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"16")      -- parity
      report "Did not reply NACK after REGISTER_ARD with wrong parity"
      severity error;

   -----------------------------------------------------------
   -- send register ard with length 0
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_ARD with length 0"
      severity note;

   send_to_fifo(x"79",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"35",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"01",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length
   send_to_fifo(x"4D",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 3) = x"90" and   -- ARDRE opcode
            data_out_s(data_out_cnt_s - 2) = x"35" and   -- id
            data_out_s(data_out_cnt_s - 1) = x"A5")      -- parity
      report "Unexpected answer to ARD with length 0"
      severity error;

   -----------------------------------------------------------
   -- send register ard to read 100 bytes
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_ARD with length 100"
      severity note;

   send_to_fifo(x"79",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"25",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"64",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length = 100
   send_to_fifo(x"3b",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 50 us;
   assert(  data_out_s(data_out_cnt_s - 103) = x"90" and   -- ARDRE opcode
            data_out_s(data_out_cnt_s - 102) = x"25" and   -- id
            data_out_s(data_out_cnt_s - 101) = x"FF" and   -- data0
            data_out_s(data_out_cnt_s - 100) = x"03" and   -- data1
            data_out_s(data_out_cnt_s -  99) = x"11" and   -- data2
            data_out_s(data_out_cnt_s -  98) = x"11" and   -- data3
            data_out_s(data_out_cnt_s -  97) = x"22" and   -- data4
            data_out_s(data_out_cnt_s -  96) = x"22" and   -- data5
            data_out_s(data_out_cnt_s -  95) = x"33" and   -- data6
            data_out_s(data_out_cnt_s -  94) = x"33" and   -- data7
            data_out_s(data_out_cnt_s -  93) = x"44" and   -- data8
            data_out_s(data_out_cnt_s -  92) = x"44" and   -- data9
            data_out_s(data_out_cnt_s -  91) = x"55" and   -- data10
            data_out_s(data_out_cnt_s -  90) = x"55" and   -- data11
            data_out_s(data_out_cnt_s -  89) = x"66" and   -- data12
            data_out_s(data_out_cnt_s -  88) = x"66" and   -- data13
            data_out_s(data_out_cnt_s -  87) = x"77" and   -- data14
            data_out_s(data_out_cnt_s -  86) = x"77" and   -- data15
            data_out_s(data_out_cnt_s -  85) = x"88" and   -- data16
            data_out_s(data_out_cnt_s -  84) = x"88" and   -- data17
            data_out_s(data_out_cnt_s -  83) = x"99" and   -- data18
            data_out_s(data_out_cnt_s -  82) = x"99" and   -- data19
            data_out_s(data_out_cnt_s -  81) = x"55" and   -- data20
            data_out_s(data_out_cnt_s -  80) = x"55" and   -- data21
            data_out_s(data_out_cnt_s -  79) = x"66" and   -- data22
            data_out_s(data_out_cnt_s -  78) = x"66" and   -- data23
            data_out_s(data_out_cnt_s -  77) = x"77" and   -- data24
            data_out_s(data_out_cnt_s -  76) = x"77" and   -- data25
            data_out_s(data_out_cnt_s -  75) = x"88" and   -- data26
            data_out_s(data_out_cnt_s -  74) = x"88" and   -- data27
            data_out_s(data_out_cnt_s -  73) = x"99" and   -- data28
            data_out_s(data_out_cnt_s -  72) = x"99" and   -- data29
            data_out_s(data_out_cnt_s -  71) = x"55" and   -- data30
            data_out_s(data_out_cnt_s -  70) = x"55" and   -- data31
            data_out_s(data_out_cnt_s -  69) = x"66" and   -- data32
            data_out_s(data_out_cnt_s -  68) = x"66" and   -- data33
            data_out_s(data_out_cnt_s -  67) = x"77" and   -- data34
            data_out_s(data_out_cnt_s -  66) = x"77" and   -- data35
            data_out_s(data_out_cnt_s -  65) = x"88" and   -- data36
            data_out_s(data_out_cnt_s -  64) = x"88" and   -- data37
            data_out_s(data_out_cnt_s -  63) = x"99" and   -- data38
            data_out_s(data_out_cnt_s -  62) = x"99" and   -- data39
            data_out_s(data_out_cnt_s -  61) = x"55" and   -- data40
            data_out_s(data_out_cnt_s -  60) = x"55" and   -- data41
            data_out_s(data_out_cnt_s -  59) = x"66" and   -- data42
            data_out_s(data_out_cnt_s -  58) = x"66" and   -- data43
            data_out_s(data_out_cnt_s -  57) = x"77" and   -- data44
            data_out_s(data_out_cnt_s -  56) = x"77" and   -- data45
            data_out_s(data_out_cnt_s -  55) = x"88" and   -- data46
            data_out_s(data_out_cnt_s -  54) = x"88" and   -- data47
            data_out_s(data_out_cnt_s -  53) = x"99" and   -- data48
            data_out_s(data_out_cnt_s -  52) = x"99" and   -- data49
            data_out_s(data_out_cnt_s -  51) = x"55" and   -- data50
            data_out_s(data_out_cnt_s -  50) = x"55" and   -- data51
            data_out_s(data_out_cnt_s -  49) = x"66" and   -- data52
            data_out_s(data_out_cnt_s -  48) = x"66" and   -- data53
            data_out_s(data_out_cnt_s -  47) = x"77" and   -- data54
            data_out_s(data_out_cnt_s -  46) = x"77" and   -- data55
            data_out_s(data_out_cnt_s -  45) = x"88" and   -- data56
            data_out_s(data_out_cnt_s -  44) = x"88" and   -- data57
            data_out_s(data_out_cnt_s -  43) = x"99" and   -- data58
            data_out_s(data_out_cnt_s -  42) = x"99" and   -- data59
            data_out_s(data_out_cnt_s -  41) = x"55" and   -- data60
            data_out_s(data_out_cnt_s -  40) = x"55" and   -- data61
            data_out_s(data_out_cnt_s -  39) = x"66" and   -- data62
            data_out_s(data_out_cnt_s -  38) = x"66" and   -- data63
            data_out_s(data_out_cnt_s -  37) = x"77" and   -- data64
            data_out_s(data_out_cnt_s -  36) = x"77" and   -- data65
            data_out_s(data_out_cnt_s -  35) = x"88" and   -- data66
            data_out_s(data_out_cnt_s -  34) = x"88" and   -- data67
            data_out_s(data_out_cnt_s -  33) = x"99" and   -- data68
            data_out_s(data_out_cnt_s -  32) = x"99" and   -- data69
            data_out_s(data_out_cnt_s -  31) = x"55" and   -- data70
            data_out_s(data_out_cnt_s -  30) = x"55" and   -- data71
            data_out_s(data_out_cnt_s -  29) = x"66" and   -- data72
            data_out_s(data_out_cnt_s -  28) = x"66" and   -- data73
            data_out_s(data_out_cnt_s -  27) = x"77" and   -- data74
            data_out_s(data_out_cnt_s -  26) = x"77" and   -- data75
            data_out_s(data_out_cnt_s -  25) = x"88" and   -- data76
            data_out_s(data_out_cnt_s -  24) = x"88" and   -- data77
            data_out_s(data_out_cnt_s -  23) = x"99" and   -- data78
            data_out_s(data_out_cnt_s -  22) = x"99" and   -- data79
            data_out_s(data_out_cnt_s -  21) = x"55" and   -- data80
            data_out_s(data_out_cnt_s -  20) = x"55" and   -- data81
            data_out_s(data_out_cnt_s -  19) = x"66" and   -- data82
            data_out_s(data_out_cnt_s -  18) = x"66" and   -- data83
            data_out_s(data_out_cnt_s -  17) = x"77" and   -- data84
            data_out_s(data_out_cnt_s -  16) = x"77" and   -- data85
            data_out_s(data_out_cnt_s -  15) = x"88" and   -- data86
            data_out_s(data_out_cnt_s -  14) = x"88" and   -- data87
            data_out_s(data_out_cnt_s -  13) = x"99" and   -- data88
            data_out_s(data_out_cnt_s -  12) = x"99" and   -- data89
            data_out_s(data_out_cnt_s -  11) = x"55" and   -- data90
            data_out_s(data_out_cnt_s -  10) = x"55" and   -- data91
            data_out_s(data_out_cnt_s -   9) = x"66" and   -- data92
            data_out_s(data_out_cnt_s -   8) = x"66" and   -- data93
            data_out_s(data_out_cnt_s -   7) = x"77" and   -- data94
            data_out_s(data_out_cnt_s -   6) = x"77" and   -- data95
            data_out_s(data_out_cnt_s -   5) = x"88" and   -- data96
            data_out_s(data_out_cnt_s -   4) = x"88" and   -- data97
            data_out_s(data_out_cnt_s -   3) = x"99" and   -- data98
            data_out_s(data_out_cnt_s -   2) = x"99" and   -- data99
            data_out_s(data_out_cnt_s -   1) = x"49"  )    -- parity

      report "Reading 100 bytes using ARD failed"
      severity error;

   -----------------------------------------------------------
   -- send register mrd to read 3 bytes
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_MRD with length 3"
      severity note;

   send_to_fifo(x"73",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"26",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length = 3
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 6) = x"93" and   -- MRDRE opcode
            data_out_s(data_out_cnt_s - 5) = x"26" and   -- id
            data_out_s(data_out_cnt_s - 4) = x"FF" and   -- data0
            data_out_s(data_out_cnt_s - 3) = x"FF" and   -- data1
            data_out_s(data_out_cnt_s - 2) = x"FF" and   -- data2
            data_out_s(data_out_cnt_s - 1) = x"4A")      -- parity
      report "Unexpected answer to MRD with length 3"
      severity error;

   -----------------------------------------------------------
   -- send register mrd to read 30 bytes
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_MRD with length 30"
      severity note;

   send_to_fifo(x"73",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"26",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"1E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length = 30
   send_to_fifo(x"4B",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 20 us;
   assert(  data_out_s(data_out_cnt_s - 33) = x"93" and   -- MRDRE opcode
            data_out_s(data_out_cnt_s - 32) = x"26" and   -- id
            data_out_s(data_out_cnt_s - 31) = x"11" and   -- data0
            data_out_s(data_out_cnt_s - 30) = x"11" and   -- data1
            data_out_s(data_out_cnt_s - 29) = x"11" and   -- data2
            data_out_s(data_out_cnt_s - 28) = x"11" and   -- data3
            data_out_s(data_out_cnt_s - 27) = x"11" and   -- data4
            data_out_s(data_out_cnt_s - 26) = x"11" and   -- data5
            data_out_s(data_out_cnt_s - 25) = x"11" and   -- data6
            data_out_s(data_out_cnt_s - 24) = x"11" and   -- data7
            data_out_s(data_out_cnt_s - 23) = x"11" and   -- data8
            data_out_s(data_out_cnt_s - 22) = x"11" and   -- data9
            data_out_s(data_out_cnt_s - 21) = x"11" and   -- data10
            data_out_s(data_out_cnt_s - 20) = x"11" and   -- data11
            data_out_s(data_out_cnt_s - 19) = x"11" and   -- data12
            data_out_s(data_out_cnt_s - 18) = x"11" and   -- data12
            data_out_s(data_out_cnt_s - 17) = x"11" and   -- data13
            data_out_s(data_out_cnt_s - 16) = x"11" and   -- data15
            data_out_s(data_out_cnt_s - 15) = x"11" and   -- data16
            data_out_s(data_out_cnt_s - 14) = x"11" and   -- data17
            data_out_s(data_out_cnt_s - 13) = x"11" and   -- data18
            data_out_s(data_out_cnt_s - 12) = x"11" and   -- data19
            data_out_s(data_out_cnt_s - 11) = x"11" and   -- data20
            data_out_s(data_out_cnt_s - 10) = x"11" and   -- data21
            data_out_s(data_out_cnt_s -  9) = x"11" and   -- data22
            data_out_s(data_out_cnt_s -  8) = x"11" and   -- data23
            data_out_s(data_out_cnt_s -  7) = x"11" and   -- data24
            data_out_s(data_out_cnt_s -  6) = x"11" and   -- data25
            data_out_s(data_out_cnt_s -  5) = x"11" and   -- data26
            data_out_s(data_out_cnt_s -  4) = x"11" and   -- data27
            data_out_s(data_out_cnt_s -  3) = x"11" and   -- data28
            data_out_s(data_out_cnt_s -  2) = x"11" and   -- data29
            data_out_s(data_out_cnt_s -  1) = x"B5")      -- parity
      report "Unexpected answer to MRD with length 30"
      severity error;

   -----------------------------------------------------------
   -- send register mrd with wrong parity
   -----------------------------------------------------------
   assert false
      report "Will now send REGISTER_MRD with wrong parity"
      severity note;

   send_to_fifo(x"73",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"99",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- core address
   send_to_fifo(x"03",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- register address
   send_to_fifo(x"1E",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- length = 30
   send_to_fifo(x"4B",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"99" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"AA")      -- parity
      report "Did not reply NACK after REGISTER_MRD with wrong parity"
      severity error;

   ------------------------------------
   -- enable interrupts (wrong parity)
   ------------------------------------
   assert false
      report "Will now send INT_EN (wrong parity)"
      severity note;

   send_to_fifo(x"AA",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"27",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"AA",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- wrong parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"27" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"14")      -- parity
      report "Did not reply NACK after INT_EN with wrong parity"
      severity error;

   ------------------------------------
   -- enable interrupts
   ------------------------------------
   assert false
      report "Will now send INT_EN"
      severity note;

   send_to_fifo(x"AA",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"28",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"82",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 3) = x"00" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 2) = x"28" and   -- id
            data_out_s(data_out_cnt_s - 1) = x"28")      -- parity
      report "Did not reply ACK after INT_EN"
      severity error;

   ------------------------------------
   -- send MCU_SEL (wrong parity)
   ------------------------------------
   assert false
      report "Will now send MCU_SEL with wrong parity"
      severity note;
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"29",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"00",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- wrong parity

   wait for 5 us;
   assert(  data_out_s(data_out_cnt_s - 4) = x"11" and   -- NACK opcode
            data_out_s(data_out_cnt_s - 3) = x"29" and   -- id
            data_out_s(data_out_cnt_s - 2) = x"22" and   -- error code
            data_out_s(data_out_cnt_s - 1) = x"1A")      -- parity
      report "Did not reply NACK after MCU_SEL with wrong parity"
      severity error;

   assert (mcu_active_o = '0')
      report "Wrong parity MCU_SEL caused switching to MCU"
      severity error;

   ------------------------------------
   -- test switching back to mcu
   ------------------------------------
   assert false
      report "Will now send MCU_SEL"
      severity note;
   send_to_fifo(x"55",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- opcode
   send_to_fifo(x"30",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- id
   send_to_fifo(x"65",fifo_data_io,fifo_rxf_n_i,fifo_rd_n_o); -- parity

   wait for 5 us;
   assert (mcu_active_o = '1')
      report "Switching back to MCU failed!"
      severity error;

   if (mcu_active_o = '1') then
      fpga_active_i <= '0';
   end if;

   -- terminate simulation the hard way
   assert false report "SIMULATION FINISHED" severity failure;

end process STIMULI_PROC;

-------------------------------------------------
-- UUT instantiation
-------------------------------------------------
UUT : entity work.soc_bridge
   port map (
      fpga_active_i  => fpga_active_i,
      mcu_active_o   => mcu_active_o,

      fifo_data_io   => fifo_data_io,
      fifo_rxf_n_i   => fifo_rxf_n_i,
      fifo_txe_n_i   => fifo_txe_n_i,
      fifo_rd_n_o    => fifo_rd_n_o,
      fifo_wr_o      => fifo_wr_o,

      wbm_i          => wbm_in_s,
      wbm_o          => wbm_out_s
   );

-- two pwm16 cores as slaves
WBS1 : entity work.wbs_dual_out
   port map (
      wbs_in   => wbs1_in_s,
      wbs_out  => wbs1_out_s,
      reg1_out => wbs1_reg1_out_s,
      reg2_out => wbs1_reg2_out_s
   );

WBS2 : entity work.wbs_dual_out
   port map (
      wbs_in   => wbs2_in_s,
      wbs_out  => wbs2_out_s,
      reg1_out => wbs2_reg1_out_s,
      reg2_out => wbs2_reg2_out_s
   );

WBS3 : entity work.wbs256
   port map (
      wbs_in   => wbs3_in_s,
      wbs_out  => wbs3_out_s
   );

---------------
-- Intercon
---------------
-- split address
reg_adr_s  <= wbm_out_s.adr(WB_REG_AW-1 downto 0);
core_adr_s <= wbm_out_s.adr(WB_AW-1 downto WB_REG_AW);

-- connect common signals
wbs1_in_s.dat <= wbm_out_s.dat;
wbs2_in_s.dat <= wbm_out_s.dat;
wbs3_in_s.dat <= wbm_out_s.dat;

wbs1_in_s.adr <= reg_adr_s;
wbs2_in_s.adr <= reg_adr_s;
wbs3_in_s.adr <= reg_adr_s;

wbs1_in_s.we  <= wbm_out_s.we;
wbs2_in_s.we  <= wbm_out_s.we;
wbs3_in_s.we  <= wbm_out_s.we;

wbs1_in_s.cyc <= wbs1_in_s.cyc;
wbs2_in_s.cyc <= wbs2_in_s.cyc;
wbs3_in_s.cyc <= wbs3_in_s.cyc;

wbm_in_s.clk  <= clk_s;
wbs1_in_s.clk <= clk_s;
wbs2_in_s.clk <= clk_s;
wbs3_in_s.clk <= clk_s;

wbs1_in_s.rst <= wishbone_rst_s;
wbs2_in_s.rst <= wishbone_rst_s;
wbs3_in_s.rst <= wishbone_rst_s;

-- slave data out mux
with core_adr_s select wbm_in_s.dat  <=
   wbs1_out_s.dat when WBS1_ADR,
   wbs2_out_s.dat when WBS2_ADR,
   wbs3_out_s.dat when WBS3_ADR,
   wbs3_out_s.dat when WBS8_ADR,
   (others => '-') when others;

-- address comparator
adr_match_1_s <= '1' when core_adr_s = WBS1_ADR else '0';
adr_match_2_s <= '1' when core_adr_s = WBS2_ADR else '0';
adr_match_3_s <= '1' when (core_adr_s = WBS3_ADR OR core_adr_s = WBS8_ADR) else '0';

-- ack or gate
wbm_in_s.ack <=   wbs1_out_s.ack or
                  wbs2_out_s.ack or
                  wbs3_out_s.ack;

-- stb and gates
wbs1_in_s.stb <= wbm_out_s.cyc and wbm_out_s.stb and adr_match_1_s;
wbs2_in_s.stb <= wbm_out_s.cyc and wbm_out_s.stb and adr_match_2_s;
wbs3_in_s.stb <= wbm_out_s.cyc and wbm_out_s.stb and adr_match_3_s;

-------------------------------------------------
   CLK_GENERATOR :
-------------------------------------------------
process begin
   clk_s <= '0';
   wait for CLK_PERIOD/2;
   clk_s <= '1';
   wait for CLK_PERIOD/2;
end process CLK_GENERATOR;

end simulation;
