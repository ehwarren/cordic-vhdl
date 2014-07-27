--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:48:22 07/14/2014
-- Design Name:   
-- Module Name:   M:/ceng441/cordic-vhdl/cordic_test.vhd
-- Project Name:  CORDIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CORDIC
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cordic_test IS
END cordic_test;
 
ARCHITECTURE behavior OF cordic_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CORDIC
    PORT(
         mode : IN  std_logic_vector(1 downto 0);
         op : IN  std_logic;
         start : IN  std_logic;
         reset : IN  std_logic;
         clock : IN  std_logic;
         x : OUT  std_logic_vector(31 downto 0);
         y : OUT  std_logic_vector(31 downto 0);
         z : OUT  std_logic_vector(31 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal mode : std_logic_vector(1 downto 0) := (others => '0');
   signal op : std_logic := '0';
   signal start : std_logic := '0';
   signal reset : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal x : std_logic_vector(31 downto 0);
   signal y : std_logic_vector(31 downto 0);
   signal z : std_logic_vector(31 downto 0);
   signal done : std_logic;
   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CORDIC PORT MAP (
          mode => mode,
          op => op,
          start => start,
          reset => reset,
          clock => clock,
          x => x,
          y => y,
          z => z,
          done => done
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 
		mode <= "01";
		op <= '0';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
		
		mode <= "00";
		op <= '0';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
		
		mode <= "10";
		op <= '0';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
		
		mode <= "01";
		op <= '1';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
		
		mode <= "00";
		op <= '1';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
		
		mode <= "10";
		op <= '1';
		reset <= '1';
		wait for clock_period*3;
		reset <= '0';
		wait for clock_period*3;
		start <= '1';
		wait for clock_period*3;
		start <= '0';
		
		wait for clock_period*35;
			
      wait;
   end process;

END;
