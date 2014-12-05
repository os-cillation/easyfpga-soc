-------------------------------------------------------------------------------
--   S O C    B R I D G E
--
-- Purpose: Bridge FT245 style FIFO interface and Wishbone interconnection
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--library unisim;
--use unisim.vcomponents.all;

use work.constants.all;
use work.interfaces.all;

-------------------------------------------------------------------------------
ENTITY soc_bridge is
-------------------------------------------------------------------------------
   port (
      -- mcu
      fpga_active_i  : in  std_logic;
      mcu_active_o   : out std_logic;

      -- fifo interface
      fifo_data_io   : inout std_logic_vector(7 downto 0);
      fifo_rxf_n_i   : in    std_logic;
      fifo_txe_n_i   : in    std_logic;
      fifo_rd_n_o    : out   std_logic;
      fifo_wr_o      : out   std_logic;

      -- wishbone master
      wbm_i          : in wbm_in_type;
      wbm_o          : out wbm_out_type
   );
end soc_bridge;

-------------------------------------------------------------------------------
ARCHITECTURE structural of soc_bridge is
-------------------------------------------------------------------------------
   ----------------------------------------------
   --   Constants
   ----------------------------------------------
   constant FIFO_WIDTH     : natural := 8;

   ----------------------------------------------
   --   Signals
   ----------------------------------------------
   -- global signals
   signal clk, rst : std_logic;

   -- signals connecting ...
   -- ... fifo_adapter and fifo_controller
   signal fifo_ctrl_direction_s           : std_logic;
   signal rxf_s, txe_s, wr_s, rd_s        : std_logic;
   signal data_transmit_s, data_receive_s : std_logic_vector(FIFO_WIDTH -1 downto 0);

   -- ... fifo_adapter and enable_controller
   signal fifo_enable_s                   : std_logic;

   -- ... receive buffer and fifo controller
   signal fifo_controller_word_s          : std_logic_vector(FIFO_WIDTH -1 downto 0);
   signal fifo_controller_receive_store_s : std_logic;
   signal receive_buffer_busy_s           : std_logic;

   -- ... receive buffer and frame controller
   signal frame_ctrl_clear_recbuf_s       : std_logic;
   signal receive_buffer_frame_s          : std_logic_vector(PROTO_WC_RX_MAX*FIFO_WIDTH -1 downto 0);
   signal receive_buffer_complete_s       : std_logic;

   -- ... frame controller, transmit buffer and fifo controller
   signal transmitter_mode_s              : std_logic;

   -- ... frame controller and enable controller
   signal mcu_select_s                    : std_logic;

   -- ... frame controller and transmit buffer
   signal frame_ctrl_trabuf_frame_s       : std_logic_vector(PROTO_WC_TX_MAX*FIFO_WIDTH -1 downto 0);
   signal frame_ctrl_trabuf_valid_s       : std_logic;
   signal frame_ctrl_trabuf_length_s      : integer range 0 to PROTO_WC_TX_MAX;
   signal trabuf_frame_ctrl_busy_s        : std_logic;

   -- ... transmit buffer and fifo controller
   signal trabuf_word_out_s               : std_logic_vector(FIFO_WIDTH -1 downto 0);
   signal trabuf_send_s                   : std_logic;

   -- ... wishbone master and the intercon (outside this entity)
   signal wbm_i_s                         : wbm_in_type;
   signal wbm_o_s                         : wbm_out_type;

-------------------------------------------------------------------------------
begin -- architecture structural
-------------------------------------------------------------------------------
   ----------------------------------------------
   -- global signals
   ----------------------------------------------
   clk <= wbm_i.clk;
   rst <= not fpga_active_i;

   wbm_o   <= wbm_o_s;
   wbm_i_s <= wbm_i;

-------------------------------------------------------------------------------
   FRAME_CTRL : entity work.frame_ctrl
-------------------------------------------------------------------------------
      port map (
         clk => clk,
         rst => rst,

         -- inputs
         d.recbuf_frame          => receive_buffer_frame_s ,
         d.recbuf_complete       => receive_buffer_complete_s,
         d.trabuf_busy           => trabuf_frame_ctrl_busy_s,

         -- outputs
         q.recbuf_clear          => frame_ctrl_clear_recbuf_s,
         q.trabuf_frame          => frame_ctrl_trabuf_frame_s,
         q.trabuf_valid          => frame_ctrl_trabuf_valid_s,
         q.mcu_select            => mcu_select_s,
         q.transmitter_mode      => transmitter_mode_s,
         q.trabuf_length         => frame_ctrl_trabuf_length_s,

         -- wishbone
         wbo   => wbm_o_s,
         wbi   => wbm_i_s
      );

-------------------------------------------------------------------------------
   FIFO_ADAPTER : entity work.fifo_adapter
-------------------------------------------------------------------------------
      port map (
         -- external fifo pins (ucf)
         data_pins => fifo_data_io(FIFO_WIDTH -1 downto 0),
         rxf_pin   => fifo_rxf_n_i,
         txd_pin   => fifo_txe_n_i,
         wr_pin    => fifo_wr_o,
         rd_pin    => fifo_rd_n_o,

         -- internal fifo signals
         enable_i          => fifo_enable_s, -- async enable
         direction_i       => fifo_ctrl_direction_s,   -- data direction (0:receive, 1:send)
         data_transmit_i   => data_transmit_s,
         data_receive_o    => data_receive_s,
         rxf_o             => rxf_s,
         txd_o             => txe_s,
         wr_i              => wr_s,
         rd_i              => rd_s
      );

-------------------------------------------------------------------------------
   FIFO_CONTROLLER : entity work.fifo_controller
-------------------------------------------------------------------------------
      port map (
         -- fifo adapter interface
         data_transmit_o   => data_transmit_s,
         txe_i             => txe_s,
         wr_o              => wr_s,
         data_receive_i    => data_receive_s,
         rxf_i             => rxf_s,
         rd_o              => rd_s,
         direction_o       => fifo_ctrl_direction_s, -- 0:receiver, 1:transmitter
         -- receive buffer interface
         word_recbuf_o     => fifo_controller_word_s,
         store_recbuf_o    => fifo_controller_receive_store_s,
         busy_recbuf_i     => receive_buffer_busy_s,
         -- transmit buffer interface
         word_trabuf_i     => trabuf_word_out_s,
         send_trabuf_i     => trabuf_send_s,
         -- misc
         transmitter_mode_i=> transmitter_mode_s,
         clk_i             => clk,
         rst_i             => rst
      );

-------------------------------------------------------------------------------
   RECEIVE_FRAME_BUFFER : entity work.receive_frame_buffer
-------------------------------------------------------------------------------
      port map (
         clk_i             => clk,
         clear_i           => frame_ctrl_clear_recbuf_s,
         store_i           => fifo_controller_receive_store_s,
         frame_complete_o  => receive_buffer_complete_s,
         word_i            => fifo_controller_word_s,
         frame_o           => receive_buffer_frame_s,
         busy_o            => receive_buffer_busy_s
      );

-------------------------------------------------------------------------------
   TRANSMIT_FRAME_BUFFER : entity work.transmit_frame_buffer
-------------------------------------------------------------------------------
      port map (
         clk => clk,
         rst => rst,

         -- inputs
         d.frame         => frame_ctrl_trabuf_frame_s,
         d.frame_valid   => frame_ctrl_trabuf_valid_s,
         d.transmit_mode => transmitter_mode_s,
         d.fifo_busy     => fifo_ctrl_direction_s,
         d.fifo_wr       => wr_s,
         d.length        => frame_ctrl_trabuf_length_s,

         -- outputs
         q.trabuf_busy   => trabuf_frame_ctrl_busy_s,
         q.word           => trabuf_word_out_s,
         q.send           => trabuf_send_s
      );

-------------------------------------------------------------------------------
   ENABLE_CONTROLLER : entity work.enable_controller
-------------------------------------------------------------------------------
      port map (
         -- mcu interface
         fpga_active_i  => fpga_active_i, -- ucf
         mcu_active_o   => mcu_active_o,  -- ucf
         -- soc interface
         mcu_select_i   => mcu_select_s,
         fifo_enable_o  => fifo_enable_s,
         clk_i          => clk,
         rst_i          => rst
      );

end structural;
