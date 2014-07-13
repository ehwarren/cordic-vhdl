--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:24:56 07/13/2014
-- Design Name:   
-- Module Name:   /home/austin/441/cordic-vhdl/ROMTestbench.vhd
-- Project Name:  CORDIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ROM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ROMTestbench IS
END ROMTestbench;
 
ARCHITECTURE behavior OF ROMTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ROM
    PORT(
         mode : IN  std_logic_vector(1 downto 0);
         i : IN  std_logic_vector(4 downto 0);
         theta : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mode : std_logic_vector(1 downto 0) := (others => '0');
   signal i : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal theta : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace clock below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ROM PORT MAP (
          mode => mode,
          i => i,
          theta => theta
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- Set mode to Linear
		mode <= "00";
		wait for clock_period;
		-- Run through each itteration
		for iteration in 0 to 31 loop
			i <= std_logic_vector(to_unsigned(iteration, i'length));
			wait for clock_period;
		end loop;
		
		-- Set mode to Circular
		mode <= "01";
		wait for clock_period;
		-- Run through each itteration
		for iteration in 0 to 31 loop
			i <= std_logic_vector(to_unsigned(iteration, i'length));
			wait for clock_period;
		end loop;
		
		-- Set mode to hyperbolic
		mode <= "10";
		wait for clock_period;
		-- Run through each itteration
		for iteration in 1 to 31 loop
			i <= std_logic_vector(to_unsigned(iteration, i'length));
			wait for clock_period;
		end loop;
		
		-- Set mode to invalid, should get all zeros
		mode <= "11";
		wait for clock_period;
		-- Run through each itteration
		for iteration in 0 to 31 loop
			i <= std_logic_vector(to_unsigned(iteration, i'length));
			wait for clock_period;
		end loop;
		
      wait;
      wait;
   end process;

END;
