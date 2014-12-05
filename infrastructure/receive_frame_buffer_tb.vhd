--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


entity receive_frame_buffer_tb is
end receive_frame_buffer_tb;

architecture write_sequence of receive_frame_buffer_tb is
   constant CLK_PERIOD           : time      := 10 ns;
   constant UUT_WORD_COUNT_MAX   : natural   := 11;
   constant UUT_WIDTH            : natural   := 8;

   signal clk, clr, store  : std_logic;
   signal complete, full   : std_logic;
   signal word             : std_logic_vector(UUT_WIDTH -1 downto 0);
   signal frame            : std_logic_vector(UUT_WORD_COUNT_MAX*UUT_WIDTH -1 downto 0);

   procedure clear  (signal clr   : out std_logic;
                     signal store : out std_logic
                     ) is
   begin
      clr   <= '1';
      store <= '1';
      wait for CLK_PERIOD;
   end clear;

   procedure send_word (constant word_arg : in std_logic_vector(UUT_WIDTH -1 downto 0);
                        signal word       : out std_logic_vector(UUT_WIDTH -1 downto 0);
                        signal clr        : out std_logic;
                        signal store      : out std_logic
                        ) is
   begin
      clr   <= '0';
      store <= '1';
      word  <= word_arg;
      wait for CLK_PERIOD;
   end send_word;

begin
   --**************************************
   --   instantiation of unit under test
   --**************************************
   UUT : entity work.receive_frame_buffer
      generic map (
         WIDTH          => UUT_WIDTH ,
         WORD_COUNT_MAX => UUT_WORD_COUNT_MAX
      ) port map (
         clk_i             => clk,
         clear_i           => clr,
         store_i           => store,
         frame_complete_o  => complete,
         full_o            => full,
         word_i            => word,
         frame_o           => frame
      );

   --*****************************
   --   clock generator process
   --*****************************
   CLOCK_GEN_PROC : process is
   begin
      clk <= '0';
      wait for CLK_PERIOD/2;
      clk <= '1';
      wait for CLK_PERIOD/2;
   end process CLOCK_GEN_PROC;

   --*******************************
   --   stimuli generator process
   --*******************************
   STIMULI_GEN_PROC : process is
   begin
      -- hold in reset for 100 ns
      clr   <= '1';
      store <= '0';
      word  <= x"00";
      wait for 100 ns;

      --******************
      --   send MCU_SEL
      --******************
      assert false report "will now send MCU_SEL" severity note;
      send_word(word_arg => x"8A", word => word, clr => clr, store => store);
      send_word(word_arg => x"55", word => word, clr => clr, store => store);
      clear(clr => clr, store => store);

      --**********************
      --   send REGISTER_WR
      --**********************
      assert false report "will now send REGISTER_WR" severity note;
      send_word(word_arg => x"8A", word => word, clr => clr, store => store);
      send_word(word_arg => x"66", word => word, clr => clr, store => store);
      -- data
      send_word(word_arg => x"00", word => word, clr => clr, store => store);
      send_word(word_arg => x"11", word => word, clr => clr, store => store);
      send_word(word_arg => x"22", word => word, clr => clr, store => store);
      send_word(word_arg => x"33", word => word, clr => clr, store => store);
      -- address
      send_word(word_arg => x"44", word => word, clr => clr, store => store);
      send_word(word_arg => x"AA", word => word, clr => clr, store => store);
      send_word(word_arg => x"BB", word => word, clr => clr, store => store);
      send_word(word_arg => x"CC", word => word, clr => clr, store => store);
      -- parity (correct)
      send_word(word_arg => x"99", word => word, clr => clr, store => store);
      -- clear
      clear(clr => clr, store => store);

      wait; -- forever
   end process STIMULI_GEN_PROC;
end write_sequence;
