-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Controller is
Generic (n 	: positive := 5 -- 2^5 = 32
				);
		Port ( clock : in std_logic;
				 mode	 : in std_logic_vector (1 downto 0); -- '00' is linear, '01' is circular, '10' hyperbolic, '11' is nothing
				 op	 : in std_logic; -- '0' rotation or '1' vectoring
				 start : in std_logic; -- start to be included in controller logic.
				 reset : in std_logic;
				 X		 : in std_logic_vector(31 downto 0); 
				 Y		 : in std_logic_vector(31 downto 0); 
				 Z		 : in std_logic_vector(31 downto 0); 
				 en	 : out std_logic; -- enable for memory
				 wr 	 : out std_logic; -- read flag for memory
				 i		 : out std_logic_vector (n - 1 downto 0); -- current iteration
				 done	 : out std_logic
			  );

end Controller;

architecture Behavioral of Controller is
	type state is (VLinear, RLinear, VCircular, RCircular, VHyperbolic, RHyperbolic, DoneState);
	signal current_state: state;
	signal next_state: state;
	signal count: integer range 0 to 32;
begin

	 CS: process(clock, reset) -- current state and asynchronous reset
	 begin
		if reset = '1' then
			current_state <= DoneState; -- Reset state failsafe. State to be discussed, VLinear is temp.
		elsif rising_edge(clock) then
			current_state <= next_state; -- manage current state
		end if;
	end process CS;

	Nxt: process(current_state, mode, op) -- Next state process. 
	begin
		if current_state = DoneState then
			case op is
				when '0' => -- rotational
					if mode = "00" then
						next_state <= RLinear;
					elsif mode = "01" then
						next_state <= RCircular;
					elsif mode = "10" then
						next_state <= RHyperbolic;
					else 
						next_state <= current_state;
					end if;
				when '1' => -- vectoring
					if mode = "00" then
						next_state <= VLinear;
					elsif mode = "01" then
						next_state <= VCircular;
					elsif mode = "10" then
						next_state <= VHyperbolic;
					else 
						next_state <= current_state;
					end if;
				when others => -- others should not occur
					next_state <= current_state;
			end case;
		elsif count = 31 then
			next_state <= DoneState;
		else 
			next_state <= current_state;
		end if;
	end process Nxt;

--Circular mode m = 1
--Linear mode m = 0
--Hyperbolic mode m = -1
--
--Vectoring operation y => 0
--Rotation operation z => 0
--
--delta = 2^(-i) => from lookup table
--theta => lookup table
--
--generalized cordic
--xi+1 = xi - (m) * (Mew)i * (y)i * (delta)i
--yi+1 = yi + (Mew)i * (x)i * (delta)i
--zi+1 = zi - (Mew)i * (theta)i 
--
--binary point is after the second MSB (sign bit, bit, binary point, frac bit, frac bit, frac bit....)
--
	OutP: process(current_state) is -- Output process
	variable repeat: boolean := true; -- checks if hyperbolic iteration is to be repeated
	begin
		if start = '1' then
			case current_state is
				when RLinear => 
				-- i = 0,1,2...n-1. n, for this project, is 32
				--	m <= 0;
				
					i <= conv_std_logic_vector (count, 32);
					count <= count + 1;
				when VLinear =>
				--	m <= 0;
				
					i <= conv_std_logic_vector(count, 32);
					count <= count + 1;
				when RCircular => 
				-- i = 0,1,2...n-1
				--	m <= 1;
				
					i <= conv_std_logic_vector(count, 32);
					count <= count + 1;
				when VCircular =>
				--	m <= 1;
				
					i <= conv_std_logic_vector(count, 32);
					count <= count + 1;
				when RHyperbolic => 
				-- hyperbolic iterations repeat at i = 4, 13 for n = 32. i = 1,2...n-1
				-- iteration repeats given by i = (3^(j+1)-1)/2 for j = 1,2,3...
				--	m <= -1;
					

					if (count = 4 or count = 13) and repeat = true then
						i <= conv_std_logic_vector(count, 32);
						repeat := false;
					else
						i <= conv_std_logic_vector(count, 32);
						count <= count + 1;
						if count = 4 or count = 13 then
							repeat := true;
						else
							repeat := false;
						end if;
					end if;
					
				when VHyperbolic =>
				--	m <= -1;
				
				
					if (count = 4 or count = 13) and repeat = true then
						i <= conv_std_logic_vector(count, 32);
						repeat := false;
					else
						i <= conv_std_logic_vector(count, 32);
						count <= count + 1;
						if count = 4 or count = 13 then
							repeat := true;
						else
							repeat := false;
						end if;
					end if;
				when DoneState =>
				 done <= '1';
				 -- send X,Y,Z, outputs, scale outputs by factor K
				 -- reset counter
				 count <= 0;
			end case;
		end if;
	end process OutP;


end Behavioral;

