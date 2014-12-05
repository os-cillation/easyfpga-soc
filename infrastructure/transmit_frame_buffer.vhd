-------------------------------------------------------------------------------
-- T R A N S M I T    F R A M E    B U F F E R    (transmit_frame_buffer.vhd)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;

-------------------------------------------------------------------------------
-- Type and component definition package
-------------------------------------------------------------------------------
package transmit_frame_buffer_comp is

   type transmit_frame_buffer_in_type is record
      frame         : std_logic_vector((FIFO_WIDTH*PROTO_WC_TX_MAX)-1 downto 0);
      frame_valid   : std_logic;
      fifo_busy     : std_logic; -- fifo_ctrl direction output
      fifo_wr       : std_logic;
      transmit_mode : std_logic;
      length        : integer range 0 to PROTO_WC_TX_MAX; -- if 0, the buffer determines the
                                                          -- length using the opcode.
                                                          -- For ardre frames the length is
                                                          -- > 0 indicating how many bytes
                                                          -- should be transmitted.
   end record;

   type transmit_frame_buffer_out_type is record
      word         : std_logic_vector(FIFO_WIDTH-1 downto 0);
      send         : std_logic;
      trabuf_busy  : std_logic;
   end record;

   component transmit_frame_buffer
      port (
         clk   : in  std_logic;
         rst   : in  std_logic;
         d     : in  transmit_frame_buffer_in_type;
         q     : out transmit_frame_buffer_out_type
      );
   end component;

end package;


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.transmit_frame_buffer_comp.all;
use work.constants.all;

-------------------------------------------------------------------------------
entity transmit_frame_buffer is
-------------------------------------------------------------------------------
   port (
      clk   : in  std_logic;
      rst   : in  std_logic;
      d     : in  transmit_frame_buffer_in_type;
      q     : out transmit_frame_buffer_out_type
   );
end transmit_frame_buffer;

-------------------------------------------------------------------------------
architecture two_proc of transmit_frame_buffer is
-------------------------------------------------------------------------------

   type frame_type is array (0 to PROTO_WC_TX_MAX-1)
                      of std_logic_vector(FIFO_WIDTH-1 downto 0);

   type state_type is (
                        idle,
                        buffer_frame,
                        set_length,
                        apply_word,
                        wait_for_wr_high,
                        wait_for_wr_low,
                        wait_for_fifo,
                        check_index
                      );

   type reg_type is record
      frame          : frame_type;
      state          : state_type;
      byte_count     : integer range 0 to PROTO_WC_TX_MAX;
      byte_index     : integer range 0 to PROTO_WC_TX_MAX;
   end record;

   signal reg_out, reg_in : reg_type;

begin

-------------------------------------------------------------------------------
   COMBINATIONAL : process(d, reg_out)
-------------------------------------------------------------------------------
      variable tmp : reg_type;
   begin
      -- read register to tmp variable
      tmp := reg_out;

      case tmp.state is

      --IDLE-------------------------------------------------------------------
      when idle =>
         -- outputs
         q.word <= (others => '-');
         q.trabuf_busy <= '0';
         q.send <= '0';

         -- reset register variables
         tmp.byte_index := 0;
         tmp.byte_count := 0;

         -- next state
         if (d.frame_valid = '1') then
            tmp.state := buffer_frame;
         else
            tmp.state := idle;
         end if;

      --BUFFER_FRAME-----------------------------------------------------------
      when buffer_frame =>
         -- outputs
         q.word <= (others => '-');
         q.trabuf_busy <= '1';
         q.send <= '0';

         -- buffer frame
         for index in 0 to PROTO_WC_TX_MAX-1 loop
            tmp.frame(index) :=
               d.frame((index*FIFO_WIDTH)+(FIFO_WIDTH-1) downto index*FIFO_WIDTH);
         end loop;

         -- next state
         tmp.state := set_length;

      --SET_LENGTH-------------------------------------------------------------
      when set_length =>
         -- outputs
         q.word <= (others => '-');
         q.trabuf_busy <= '1';
         q.send <= '0';

         if (d.length = 0) then
            -- set byte_count by means of the opcode
            case tmp.frame(0) is
               when ACK_OPC            => tmp.byte_count := ACK_LEN;
               when NACK_OPC           => tmp.byte_count := NACK_LEN;
               when REGISTER_RDRE_OPC  => tmp.byte_count := REGISTER_RDRE_LEN;
               when SOC_INT_OPC        => tmp.byte_count := SOC_INT_LEN;
               when others             => tmp.byte_count := 0;
            end case;

         -- if the length is given by frame_ctrl
         else
            tmp.byte_count := d.length;
         end if;

         -- next state
         if (d.transmit_mode = '1') then
            tmp.state := apply_word;
         else
            tmp.state := set_length;
         end if;

      --APPLY_WORD-------------------------------------------------------------
      when apply_word =>
         -- outputs
         q.word <= tmp.frame(tmp.byte_index);
         q.trabuf_busy <= '1';
         q.send <= '1';
         -- next state: wait until fifo is busy
         if (d.fifo_busy = '1') then
            tmp.state := wait_for_wr_high;
         else
            tmp.state := apply_word;
         end if;

      --WAIT_FOR_WR_HIGH-------------------------------------------------------
      when wait_for_wr_high =>
         -- outputs
         q.word <= tmp.frame(tmp.byte_index);
         q.trabuf_busy <= '1';
         q.send <= '1';

         -- next state: wait until wr has been asserted ...
         if (d.fifo_wr = '1') then
            tmp.state := wait_for_wr_low;
         else
            tmp.state := wait_for_wr_high;
         end if;

      --WAIT_FOR_WR_LOW--------------------------------------------------------
      when wait_for_wr_low =>
         -- outputs
         q.word <= tmp.frame(tmp.byte_index);
         q.trabuf_busy <= '1';
         q.send <= '1';

         -- next state: wait until wr is zero again
         if (d.fifo_wr = '0') then
            tmp.state := wait_for_fifo;
         else
            tmp.state := wait_for_wr_low;
         end if;

      --WAIT_FOR_FIFO----------------------------------------------------------
      when wait_for_fifo =>
         -- outputs (the same as in apply_word)
         q.word <= tmp.frame(tmp.byte_index);
         q.trabuf_busy <= '1';
         q.send <= '0';

         -- next state: wait until fifo is done
         if (d.fifo_busy = '1') then
            tmp.state := wait_for_fifo;
         else
            -- increment index when leaving state
            tmp.byte_index := tmp.byte_index + 1;
            tmp.state := check_index;
         end if;

      --CHECK_INDEX------------------------------------------------------------
      when check_index =>
         -- outputs
         q.word <= (others => '-');
         q.trabuf_busy <= '1';
         q.send <= '0';

         -- next state
         if (tmp.byte_index = tmp.byte_count) then
            tmp.state := idle;
         else
            tmp.state := apply_word;
         end if;

      end case;

      -- write back to register
      reg_in <= tmp;

   end process COMBINATIONAL;

-------------------------------------------------------------------------------
   REGISTERS : process(clk,rst)
-------------------------------------------------------------------------------
   begin
      if (rst = '1') then
         reg_out.frame <= (others => (others => '0'));
         reg_out.state <= idle;
         reg_out.byte_count <= 0;
         reg_out.byte_index <= 0;
      elsif rising_edge(clk) then
         reg_out <= reg_in;
      end if;
   end process REGISTERS;

end two_proc;
