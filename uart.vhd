-- Created by Dr. Gebali June 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.cordic_package.ALL;

ENTITY uart IS
PORT (
	byte_in : in std_logic_vector (7 downto 0);
	byte_in_ready: in std_logic;
	sel : in std_logic_vector (2 downto 0);
	clk : in std_logic;
	reset : in std_logic;
	-- outputs
	bit_out: out std_logic;	
	uart_ready: out std_logic;
	slow_clk_out: out std_logic;
	ns_uart, ps_uart: out uart_state_type
);
END uart;


ARCHITECTURE uart OF uart IS

	component serialTx IS
		port (
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
	end component serialTx;

   COMPONENT slow_clk IS
	port (
	clk_in : in STD_LOGIC;
	sel : in std_logic_vector (2 downto 0);
	-- output
	clk_out : out STD_LOGIC		
	);
   END component slow_clk;

	signal slow_clk_internal :  STD_LOGIC;

BEGIN
	slow_clk_out <= slow_clk_internal;

	serialTx_instance: serialTx
		port map (
				byte_in => byte_in, 
				byte_in_ready => byte_in_ready,
				slow_clk_in => slow_clk_internal,
				reset  => reset,
				bit_out =>  bit_out,
				uart_ready  => uart_ready,
				ns_uart => ns_uart,
				ps_uart => ps_uart
		); 
		
	slow_clk_instance: slow_clk 
		port map (
			clk_in  => clk,
			sel 	 => sel,
			clk_out  => slow_clk_internal
		);
   
END  uart;

