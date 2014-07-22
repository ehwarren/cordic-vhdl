-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.cordic_package.ALL;

entity parallel_2_serial is
    Port ( 
           x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : in  STD_LOGIC_VECTOR (31 downto 0);
           z : in  STD_LOGIC_VECTOR (31 downto 0);
           done : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			   --outpus
           bit_out : out  STD_LOGIC;
           slow_clk_out : out  STD_LOGIC;
           ns_send_data : out  send_data_state_type;
           ps_send_data : out  send_data_state_type;
           ns_ascii : out  ascii_state_type;
           ps_ascii : out  ascii_state_type;
           ns_uart : out  uart_state_type;
           ps_uart : out  uart_state_type;
			  uart_ready, ascii_ready: out std_logic 
			  );
end parallel_2_serial;

architecture Behavioral of parallel_2_serial is

component send_data is
    Port ( 
			  x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : in  STD_LOGIC_VECTOR (31 downto 0);
           z : in  STD_LOGIC_VECTOR (31 downto 0);
           done : in  STD_LOGIC;
           ascii_ready : in  STD_LOGIC; -- ascii_ready comes from serial interface. 
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  ---- outputs 
			  byte_out : out STD_LOGIC_VECTOR (7 downto 0);
			  byte_out_ready : out  STD_LOGIC;
			  is_ascii: out std_logic;
			  ns_send_data, ps_send_data: out send_data_state_type
           );
end component send_data;

component ascii is
	port (
			byte_in : in std_logic_vector (7 downto 0);
			byte_in_ready : in std_logic;
			is_ascii : in std_logic;
			uart_ready : in std_logic;
			clk : in std_logic;
			reset : in std_logic;
			-- outputs
			byte_out : out std_logic_vector (7 downto 0);
			byte_out_ready : out std_logic;
			ascii_ready : out std_logic;
			ns_ascii, ps_ascii : out ascii_state_type
			);
end component ascii;

component uart IS
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
END component uart;

	--signal x, y, z: std_logic_vector (31 downto 0);
	signal byte_send_data_2_ascii: std_logic_vector (7 downto 0);
	signal byte_ready_send_data_2_ascii: std_logic;
	signal byte_ascii_2_uart: std_logic_vector (7 downto 0);
	signal byte_ready_ascii_2_uart: std_logic;
	signal is_ascii_internal: std_logic;
	signal ascii_ready_internal: std_logic;
	signal uart_ready_internal: std_logic;

begin

	--x <= X"03020100"; y <= X"13121110"; z <= X"23222120";
	uart_ready <= uart_ready_internal;
	ascii_ready <= ascii_ready_internal;

	send_data_instance: send_data 
		Port Map( 
			  x  => x,
           y  => y,
           z  => z,
           done  => done,
           ascii_ready => ascii_ready_internal,
           clk  => clk,
           reset => reset, 
			  ---- outputs
			  byte_out  =>             byte_send_data_2_ascii,
			  byte_out_ready  => byte_ready_send_data_2_ascii,
			  is_ascii => is_ascii_internal,
			  ns_send_data => ns_send_data,
			  ps_send_data  => ps_send_data
           );
			  
	ascii_instance: ascii
		port map (
		byte_in =>             byte_send_data_2_ascii,
		byte_in_ready => byte_ready_send_data_2_ascii,
		is_ascii => is_ascii_internal,
		uart_ready => uart_ready_internal,
		clk => clk,
		reset => reset,
		-- outputs
		byte_out => byte_ascii_2_uart,
		byte_out_ready => byte_ready_ascii_2_uart,
		ascii_ready => ascii_ready_internal,
		ns_ascii => ns_ascii,
		ps_ascii => ps_ascii
	);
			  
	uart_instance:  uart 
		PORT MAP(
			byte_in  =>            byte_ascii_2_uart,
			byte_in_ready => byte_ready_ascii_2_uart,
			sel  => sel,
			clk  => clk,
			reset  => reset,
			-- outputs
			bit_out	 => bit_out,
			uart_ready => uart_ready_internal,
			slow_clk_out => slow_clk_out,
			ns_uart => ns_uart, 
			ps_uart => ps_uart
		);

end Behavioral;


