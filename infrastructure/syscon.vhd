--------------------------------------------------------------------------------
-- W I S H B O N E    S Y S C O N
-- (syscon.vhd)
--
-- Structural
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library UNISIM;
use UNISIM.vcomponents.all;

--------------------------------------------------------------------------------
ENTITY syscon is
--------------------------------------------------------------------------------
   generic (
      -- multiply clock to 80 MHz
      MULTIPLY : natural := 10
   );
   port (
      clk_in   : in  std_logic;
      clk_out  : out std_logic;
      rst_out  : out std_logic
   );
end syscon;

--------------------------------------------------------------------------------
ARCHITECTURE structural of syscon is
--------------------------------------------------------------------------------

   signal dcm_status_s     : std_logic_vector(7 downto 0);
   signal reset_dcm : std_logic;
   signal clk_feedback1x_s : std_logic;

--------------------------------------------------------------------------------
begin -- architecture structural
--------------------------------------------------------------------------------

   -- tie rst_out to zero
   rst_out <= '0';

   -- reset if status(1) is asserted (clk_in is not toggling)
   reset_dcm <= dcm_status_s(1);

--------------------------------------------------------------------------------
Clock_Manager : DCM_SP
--------------------------------------------------------------------------------
   generic map (
      CLKDV_DIVIDE => 2.0,                   -- CLKDV divide value
      CLKFX_DIVIDE => 1,                     -- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => MULTIPLY,            -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 125.0,                 -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "1X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   port map (
      CLKIN       => clk_in,
      CLKFX       => clk_out,
      CLK0        => clk_feedback1x_s,
      CLKFB       => clk_feedback1x_s,
      STATUS      => dcm_status_s,
      RST         => reset_dcm
   );

end structural;
