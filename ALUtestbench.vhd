--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:58:38 06/09/2014
-- Design Name:   
-- Module Name:   M:/ceng441/cordic-vhdl/ALUTestbench.vhd
-- Project Name:  CORDIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALUTestbench IS
END ALUTestbench;
 
ARCHITECTURE behavior OF ALUTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         inX : IN  std_logic_vector(31 downto 0);
         inY : IN  std_logic_vector(31 downto 0);
         inZ : IN  std_logic_vector(31 downto 0);
         i : IN  std_logic_vector(4 downto 0);
         theta : IN  std_logic_vector(31 downto 0);
			m: in std_logic_vector(1 downto 0); -- current mode 
         addSub : IN  std_logic;
         result_X : OUT  std_logic_vector(31 downto 0);
         result_Y : OUT  std_logic_vector(31 downto 0);
         result_Z : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal inX : std_logic_vector(31 downto 0) := (others => '0');
   signal inY : std_logic_vector(31 downto 0) := (others => '0');
   signal inZ : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic_vector(4 downto 0) := (others => '0');
   signal theta : std_logic_vector(31 downto 0) := (others => '0');
	signal m : std_logic_vector(1 downto 0) := (others => '0');
   signal addSub : std_logic := '0';

 	--Outputs
   signal result_X : std_logic_vector(31 downto 0);
   signal result_Y : std_logic_vector(31 downto 0);
   signal result_Z : std_logic_vector(31 downto 0);

   -- Clock period definitions
	signal clock : std_logic := '0';
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          inX => inX,
          inY => inY,
          inZ => inZ,
          i => i,
          theta => theta,
			 m => m,
          addSub => addSub,
          result_X => result_X,
          result_Y => result_Y,
          result_Z => result_Z
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
   stim_proc: process is 
	variable A, B: integer;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;
		A := 1;
		B := 4;
      -- insert stimulus here 
		i <= "00001";
		m <= "00";
		addSub <= '0';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		addSub <= '1';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		m <= "01";
		addSub <= '0';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		addSub <= '1';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		m <= "10";
		addSub <= '0';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		addSub <= '1';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		m <= "11";
		addSub <= '0';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
		addSub <= '1';
		inX <= std_logic_vector(to_signed(A,32)); --(31 downto 1 => '0', 0 => '1'); 
		inY <= std_logic_vector(to_signed(B,32)); --(31 downto 2 => '0', 1 => '1', 0 => '0');
		inZ <= (others => '0');
		theta <= (31 downto 1 => '0', 0 => '1');

			
		wait for clock_period;
		
			
      wait;
   end process;

END;
