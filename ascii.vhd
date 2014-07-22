-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.cordic_package.ALL;

entity ascii is
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
end entity ascii;

architecture Behavioral of ascii is
	procedure std_2_ascii (
		signal nibble: in std_logic_vector (3 downto 0);
		signal byte : out std_logic_vector (7 downto 0))  is
	begin
		case nibble is
			when X"0" =>  byte <= X"30";  
			when X"1" =>  byte <= X"31";
			when X"2" =>  byte <= X"32";
			when X"3" =>  byte <= X"33";
			when X"4" =>  byte <= X"34";
			when X"5" =>  byte <= X"35";
			when X"6" =>  byte <= X"36";
			when X"7" =>  byte <= X"37";
			when X"8" =>  byte <= X"38";
			when X"9" =>  byte <= X"39";
			when X"A" =>  byte <= X"41";
			when X"B" =>  byte <= X"42";
			when X"C" =>  byte <= X"43";
			when X"D" =>  byte <= X"44";
			when X"E" =>  byte <= X"45";
			when X"F" =>  byte <= X"46";
			when others =>byte <= X"3F"; -- ?
		end case;
	end procedure std_2_ascii;
	
	signal present_state, next_state: ascii_state_type;
	signal byte : std_logic_vector(7 downto 0);

	
begin

	---------------------------------------------------------------------------------	
	ps_update: PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN -- asynchronous reset
			present_state <= idle; 
		ELSIF rising_edge (clk) THEN
			present_state <= next_state; -- implied FF	
		END IF;
	END PROCESS ps_update;
	
------------------------------------------------------------------------------------
	capture: process (clk) is begin
		if ((rising_edge(clk)) and (byte_in_ready = '1')) then -- caputre valid input data
					byte <= byte_in; 
		end if;
	end process capture;
	
------------------------------------------------------------------------------------
	ns_update: PROCESS (byte_in, byte_in_ready, is_ascii, present_state, uart_ready) is
	BEGIN
				CASE present_state IS 

				when idle => ps_ascii<= idle;  
						byte_out<= X"00"; byte_out_ready <= '0'; ascii_ready <= '1';
						if ((byte_in_ready = '1') and (is_ascii = '1')) then 
							next_state <= byte_asciiw; ns_ascii<= byte_asciiw;
						elsif ((byte_in_ready = '1') and (is_ascii = '0')) then 
							next_state <= nibble0w; ns_ascii<= nibble0w;
						else
							next_state <= idle; ns_ascii<= idle;
						end if; 
-------------------------------------------------------------------------------------

-- ASCII states
						
----------------------------------------------------------------------------------------						
				when byte_asciiw => ps_ascii<= byte_asciiw;
						byte_out <= byte; 
						byte_out_ready <= '1'; ascii_ready <= '0';
						if uart_ready = '1' then 
							next_state <= byte_asciiw; ns_ascii<= byte_asciiw;
						else
							next_state <= byte_ascii; ns_ascii<= byte_ascii;	
						end if; 					
				when byte_ascii => ps_ascii<= byte_ascii;
						byte_out <= byte;  
						byte_out_ready <= '1';	ascii_ready <= '0';
						if uart_ready = '0' then 
							next_state <= byte_ascii; ns_ascii<= byte_ascii;
						else 
							next_state <= idle; ns_ascii<= idle;	
						end if;
						
-------------------------------------------------------------------------------------

-- Non-ASCII states
						
----------------------------------------------------------------------------------------						
				when nibble0w => ps_ascii<= nibble0w;
						std_2_ascii (byte (7 downto 4), byte_out); 
						byte_out_ready <= '1'; ascii_ready <= '0';
						if uart_ready = '1' then 
							next_state <= nibble0w; ns_ascii<= nibble0w;
						else
							next_state <= nibble0; ns_ascii<= nibble0;	
						end if; 					
				when nibble0 => ps_ascii<= nibble0;
						std_2_ascii (byte (7 downto 4), byte_out);  
						byte_out_ready <= '1';	ascii_ready <= '0';
						if uart_ready = '0' then 
							next_state <= nibble0; ns_ascii<= nibble0;
						else 
							next_state <= nibble1w; ns_ascii<= nibble1w;	
						end if;					
				when nibble1w => ps_ascii<= nibble1w;
						std_2_ascii (byte (3 downto 0), byte_out); 
						byte_out_ready <= '1'; ascii_ready <= '0';
						if uart_ready = '1' then 
							next_state <= nibble1w; ns_ascii<= nibble1w;
						else
							next_state <= nibble1; ns_ascii<= nibble1;	
						end if; 					
				when nibble1 => ps_ascii<= nibble1;
						std_2_ascii (byte (3 downto 0), byte_out);  
						byte_out_ready <= '1';	ascii_ready <= '0';
						if uart_ready = '0' then 
							next_state <= nibble1; ns_ascii<= nibble1;
						else 
							next_state <= idle; ns_ascii<= idle;	
						end if;			
						
				end case;
		end process ns_update;
end architecture Behavioral;


