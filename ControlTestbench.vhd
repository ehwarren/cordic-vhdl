--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:31:36 07/10/2014
-- Design Name:   
-- Module Name:   M:/ceng441/cordic-vhdl/ControlTestbench.vhd
-- Project Name:  CORDIC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Controller
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
 
ENTITY ControlTestbench IS
END ControlTestbench;
 
ARCHITECTURE behavior OF ControlTestbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Controller
    PORT(
         clock : IN  std_logic;
         mode : IN  std_logic_vector(1 downto 0);
         op : IN  std_logic;
         start : IN  std_logic;
         reset : IN  std_logic;
         X : IN  std_logic_vector(31 downto 0);
         Y : IN  std_logic_vector(31 downto 0);
         Z : IN  std_logic_vector(31 downto 0);
         m : OUT  std_logic_vector(1 downto 0);
         i : OUT  std_logic_vector(4 downto 0);
         done : OUT  std_logic;
         addSub : OUT  std_logic;
         Xout : OUT  std_logic_vector(31 downto 0);
         Yout : OUT  std_logic_vector(31 downto 0);
         Zout : OUT  std_logic_vector(31 downto 0);
			oState  : out std_logic_vector (3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal mode : std_logic_vector(1 downto 0) := (others => '0');
   signal op : std_logic := '0';
   signal start : std_logic := '0';
   signal reset : std_logic := '0';
   signal X : std_logic_vector(31 downto 0) := (others => '0');
   signal Y : std_logic_vector(31 downto 0) := (others => '0');
   signal Z : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal m : std_logic_vector(1 downto 0);
   signal i : std_logic_vector(4 downto 0);
   signal done : std_logic;
   signal addSub : std_logic;
   signal Xout : std_logic_vector(31 downto 0);
   signal Yout : std_logic_vector(31 downto 0);
   signal Zout : std_logic_vector(31 downto 0);
	signal oState  : std_logic_vector (3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Controller PORT MAP (
          clock => clock,
          mode => mode,
          op => op,
          start => start,
          reset => reset,
          X => X,
          Y => Y,
          Z => Z,
          m => m,
          i => i,
          done => done,
          addSub => addSub,
          Xout => Xout,
          Yout => Yout,
          Zout => Zout,
			 oState => oState
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
		X <= "11111111111111110000000000000000";
		Y <= "11111111000000001111111100000000";
		Z <= "10101010101010101010101010101010";
		mode <= "01";
		op <= '0';
		start <= '1';
		wait for clock_period*16;
		mode <= "10";
		start <= '0';
		op <= '1';
		wait for clock_period*30;
		start <= '1';
      wait;
   end process;

END;
