-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.cordic_package.ALL;

-- We send a byte at a time
-- LSB is sent first
-- There is a byte_in_ready bit value = 0
-- There are stop bits value = 1
-- Serial line is idle at value 1

entity serialTx is
    Port (
				byte_in : in  STD_LOGIC_VECTOR (7 downto 0);	
				byte_in_ready: in  STD_LOGIC;
				slow_clk_in : in  STD_LOGIC;
				reset : in std_logic;
				-- outputs
				bit_out : out STD_LOGIC;
				uart_ready : out  STD_LOGIC;
				slow_clk_out: out std_logic;
				ns_uart, ps_uart: out uart_state_type
			);
end entity serialTx; 

architecture Behavioral of SerialTx is

	signal p_state, n_state: uart_state_type;
begin
	
	process (slow_clk_in, reset) is begin
		if reset = '1' then
			p_state <= idle;
		elsif rising_edge(slow_clk_in) then
			p_state <= n_state;
		end if;
	end process; 
	
	process (p_state, byte_in_ready) is begin
		case p_state  is
			when idle =>
				ps_uart <= idle; 
				uart_ready <= '1'; bit_out<= '1';
				if byte_in_ready = '1' then
					n_state <= start_bit; ns_uart <= start_bit;
				else
					n_state <= idle;  ns_uart <= idle;
				end if;
			when start_bit =>
				ps_uart <= start_bit; ns_uart <= bit0;
				uart_ready <= '0'; n_state <= bit0; bit_out <= '0'; 
			when bit0 =>
				ps_uart <= bit0; ns_uart <= bit1;
				uart_ready <= '0'; n_state <= bit1; bit_out <= byte_in(0);
			when bit1 =>
				ps_uart <= bit1; ns_uart <= bit2;
				uart_ready <= '0'; n_state <= bit2; bit_out <= byte_in(1);
			when bit2 =>
				ps_uart <= bit2; ns_uart <= bit3;
				uart_ready <= '0'; n_state <= bit3; bit_out <= byte_in(2);
			when bit3 =>
				ps_uart <= bit3; ns_uart <= bit4;
				uart_ready <= '0'; n_state <= bit4; bit_out <= byte_in(3);
			when bit4 =>
				ps_uart <= bit4; ns_uart <= bit5;
				uart_ready <= '0'; n_state <= bit5; bit_out <= byte_in(4);
			when bit5 =>
				ps_uart <= bit5; ns_uart <= bit6;
				uart_ready <= '0'; n_state <= bit6; bit_out <= byte_in(5);
			when bit6 => 
				ps_uart <= bit6; ns_uart <= bit7;
				uart_ready <= '0'; n_state <= bit7; bit_out <= byte_in(6);
			when bit7 =>
				ps_uart <= bit7; ns_uart <= stop_bit1;
				uart_ready <= '0'; n_state <= stop_bit1; bit_out <= byte_in(7);
			when stop_bit1 =>
				ps_uart <= stop_bit1; ns_uart <= stop_bit2;
				uart_ready <= '0'; n_state <= stop_bit2; bit_out <= '1';
			when stop_bit2 =>
				ps_uart <= stop_bit2; ns_uart <= stop_bit3;
				uart_ready <= '0'; n_state <= stop_bit3; bit_out <= '1';
			when stop_bit3 =>
				ps_uart <= stop_bit3; ns_uart <= idle;
				uart_ready <= '0'; n_state <= idle; bit_out <= '1';			
			
		end case;
	end process;
end Behavioral;


