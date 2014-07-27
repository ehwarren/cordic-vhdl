--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:41:10 07/07/2014
-- Design Name:   
-- Module Name:   M:/ceng441/cordic-vhdl/RegBanktestbench.vhd
-- Project Name:  CORDIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegisterBank
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
use ieee.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegBanktestbench IS
END RegBanktestbench;
 
ARCHITECTURE behavior OF RegBanktestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterBank
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         en    : IN  std_logic;
         m     : IN  std_logic_vector(1 downto 0);
         op    : IN  std_logic;
         X_in : IN  std_logic_vector(31 downto 0);
         Y_in : IN  std_logic_vector(31 downto 0);
         Z_in : IN  std_logic_vector(31 downto 0);
         X_out : OUT  std_logic_vector(31 downto 0);
         Y_out : OUT  std_logic_vector(31 downto 0);
         Z_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal en    : std_logic := '0';
   signal m     : std_logic_vector(1 downto 0) := (others => '0');
   signal op    : std_logic := '0';
   signal X_in : std_logic_vector(31 downto 0) := (others => '0');
   signal Y_in : std_logic_vector(31 downto 0) := (others => '0');
   signal Z_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal X_out : std_logic_vector(31 downto 0);
   signal Y_out : std_logic_vector(31 downto 0);
   signal Z_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterBank PORT MAP (
          clock => clock,
          reset => reset,
          en => en,
          m => m,
          op => op,
          X_in => X_in,
          Y_in => Y_in,
          Z_in => Z_in,
          X_out => X_out,
          Y_out => Y_out,
          Z_out => Z_out
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
      		en <= '1';
      		
      		m <= "00";
      		op <= '0';
      		wait for 2*clock_period;
      		
      		m <= "00";
      		op <= '1';
      		wait for 2*clock_period;
      		
      		m <= "01";
      		op <= '0';
      		wait for 2*clock_period;
      		
      		m <= "01";
      		op <= '1';
      		wait for 2*clock_period;
      		
      		m <= "10";
      		op <= '0';
      		wait for 2*clock_period;
      		
      		m <= "10";
      		op <= '1';
      		wait for 2*clock_period;
      		
      		m <= "11";
      		op <= '0';
      		wait for 2*clock_period;
      		
		X_in <= "11111111111111110000000000000000";
		Y_in <= "11111111000000001111111100000000";
		Z_in <= "10101010101010101010101010101010";
		--wait for clock_period*2;
      wait;
   end process;

END;
