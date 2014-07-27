----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:33 05/26/2014 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;
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
				 reset : in std_logic; -- resets
				 X		 : in std_logic_vector(31 downto 0); 	-- FROM RegisterBank 
				 Y		 : in std_logic_vector(31 downto 0); 	-- FROM RegisterBank
				 Z		 : in std_logic_vector(31 downto 0);    -- FROM RegisterBank
				 m		 : out std_logic_vector (1 downto 0); 	-- Mode out for rom table and ALU calculation of x.
				 i		 : out std_logic_vector (n - 1 downto 0); -- current iteration
				 done	 : out std_logic;				-- signals that final output is complete
				 addSub  : out std_logic; 				-- Mode out
				 en : out std_logic; -- enable for register bank, ensures values are only written for the operation sequence
				 Xout	 : out std_logic_vector(31 downto 0); 		-- Final Result
				 Yout	 : out std_logic_vector(31 downto 0); 		-- ..
				 Zout	 : out std_logic_vector(31 downto 0); 		-- ..
				 oState  : out std_logic_vector (3 downto 0)  -- outputs value for next state. FOR TESTING PURPOSES ONLY.
			  );

end Controller;

architecture Behavioral of Controller is
	type state is (InitialState, Linear, Circular, Hyperbolic, DoneState, EndState);
	signal current_state: state := InitialState;
	signal next_state: state := InitialState;
	signal count: integer range 0 to 31;
begin

	 CS: process(clock, reset) -- current state and asynchronous reset
	 begin
		if reset = '1' then
			current_state <= InitialState; -- Reset state failsafe. 
		elsif rising_edge(clock) then
			current_state <= next_state; -- manage current state
		end if;
	end process CS;

	Nxt: process(clock, reset) -- Next state process. 
	begin
		if reset = '1' then
			next_state <= InitialState; -- on reset, next_state is reset as well. Ensures that current_state will not change to an invalid state.
		elsif rising_edge(clock) then
			if current_state = DoneState or current_state = EndState then -- after values have been output, system sits in an "EndState" until reset is pressed.
				next_state <= EndState; -- sitting in an end state ensures that the cordic processor does not run multiple extra iterations.
				oState <= "0000";
			elsif current_state = InitialState then -- system has been reset and is in initial state. Next_state is calculated once start is pressed.
			 	if start = '1' then
					m <= mode;
							if mode = "00" then -- linear mode
								next_state <= Linear;
								oState <= "0001";
							elsif mode = "01" then -- circular mode
								next_state <= Circular;
								oState <= "0010";
							elsif mode = "10" then -- hyperbolic mode
								next_state <= Hyperbolic;
								oState <= "0011";
							else 
								next_state <= current_state; -- error state. occurs if m = "11"
								oState <= "1000";
							end if;
				else 
					next_state <= current_state; -- start has not been pressed and next_state should not update.
					oState <= "1011";
				end if;
			elsif count = 30 then -- counter is finished counting. This is asserted 1 clock cycle in advance because the system updates on the next clock cycle.
				next_state <= DoneState; -- donestate outputs the "Done" bit to denote that the correct values for x, y, and z.
				oState <= "0111";
			else 
				next_state <= current_state; -- error state. Should not occur.

			end if;
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
--'00' is linear, '01' is circular, '10' hyperbolic, '11' is nothing
	OutP: process(current_state, clock) is -- Output process
	begin
		if rising_edge(clock) then
			case current_state is
				when Linear => 
				-- i = 0,1,2...n-1. n, for this project, is 32
				--	m <= "00"; -- output mode
					en <= '1'; -- enable regbank
					done <= '0'; -- CORDIC operations have not finished, done is set low.
					i <= conv_std_logic_vector (count, 5); -- i is updated to the counter value
				when Circular => 
				-- i = 0,1,2...n-1
				--	m <= "01";
					en <= '1'; -- enable regbank
					done <= '0'; -- CORDIC operations have not finished, done is set low.					
					i <= conv_std_logic_vector(count, 5); -- i is updated to the counter value

				when Hyperbolic => 
				-- hyperbolic iterations repeat at i = 4, 13 for n = 32. i = 1,2...n-1
				-- iteration repeats given by i = (3^(j+1)-1)/2 for j = 1,2,3...
				--	m <= "10";
					en <= '1'; -- enable regbank
					done <= '0'; -- CORDIC operations have not finished, done is set low.					

					if (count = 0) then -- Hyperbolic has a special case where "i" cannot equal 0.
						i <= conv_std_logic_vector(1,5); -- i starts at value 1 instead of 0.
					else
						i <= conv_std_logic_vector(count,5); -- i is updated to the counter value
					end if;
					
				when DoneState =>
				 done <= '1'; -- Done is asserted, correct values for x, y, and z are available.
				 en <= '0'; -- deenable regbank to prevent new values from being written on the final values
				when EndState =>
					done <= '0'; -- done is no longer asserted. Done is only asserted for one clock cycle
					en <= '0'; -- deenable regbank to prevent new values from being written on the final values
				when InitialState =>
				 done <= '0'; -- initial state, values are initial values
				 en <= '0'; -- CORDIC operations have not occured, done is set low.
			end case;
		end if;
	end process OutP;
	
	Xout <= X; -- values are always being sent out. This ensures the latest values are always being set.
	Yout <= Y; -- The UART ONLY takes the x, y, z values when done is set to '1' which is accomplished in
	Zout <= Z; -- "DoneState" for one clock cycle.
	
	addSubUpdate: process(Z) is -- addSub is calculated in a seperate process and is asynchronous. 
	begin -- this ensures that the value for mu (addSub) is the latest, and correct, value.
		case op is -- which variable goes to zero is determined by op
			when '0' => -- rotational operation
				if signed(Z) > 0 then -- z is positive, addSub = value 1
					addSub <= '1';
				else
					addSub <= '0'; -- z is negative, addSube = value -1
				end if;
			when '1' => -- vectoring operation
				if signed(Y) > 0 then-- Y is positive, addSube = value -1
					addSub <= '0';
				else
					addSub <= '1';-- Y is negative, addSube = value 1
				end if;
			when others =>
				addSub <= '1'; -- error state, should not occur.
		end case;
			

	end process;
	
	countR: process(clock) is -- counter process.
	variable repeat: boolean := false; -- boolean variable that checks if hyperbolic iteration is to be repeated
	begin
		if rising_edge(clock) then
			if Current_State = InitialState then -- initial state, counter should not be counting and is set to 0.
			 count <= 0;
			elsif Current_State = Hyperbolic then -- hyperbolic state has special cases in which some iterations are repeated.
				if (count = 0) then -- no '0' iteration for hyperbolic. iteration 1 is set in controller, counter then starts at 2.
							count <= 2;
				elsif ((count = 4 or count = 13) and repeat = true) then -- counter repeats for iteration 4 and 13
							repeat := false;
				else
							count <= count + 1; -- normal counting.
							if count = 3 or count = 12 then -- sets repeat as 1 clock cycle ahead for repetition iterations.
								repeat := true;
							else
								repeat := false;
							end if; 
				end if;
			else
				count <= count + 1; -- circular or linear mode, counter counts as normal.
			end if;
		end if;
			
	end process countR;

end Behavioral;

