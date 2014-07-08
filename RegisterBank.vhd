----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:23:51 05/26/2014 
-- Design Name: 
-- Module Name:    RegisterBank - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterBank is
	Generic	( RegSize  : natural := 3;			
				  DataSize : natural := 32
				);
    Port ( clock : in std_logic;
			  reset : in std_logic;
			  X_in 	: in  std_logic_vector(DataSize - 1 downto 0);
           Y_in : in  std_logic_vector(DataSize - 1 downto 0);
           Z_in : in  std_logic_vector(DataSize - 1 downto 0);
           X_out : out 	std_logic_vector(DataSize - 1 downto 0);
           Y_out : out  std_logic_vector(DataSize - 1 downto 0);
           Z_out : out  std_logic_vector(DataSize - 1 downto 0)
			  );
end RegisterBank;

architecture Behavioral of RegisterBank is
	type Reg_Array is array (0 to regSize - 1) 
		of std_logic_vector(DataSize - 1 downto 0);
	signal Reg: Reg_Array;
begin

	process(clock,reset)--do reset stuff
	begin
		if reset = '1' then
					Reg(0) <= "00000000000000000000000000000001"; -- SCALE FACTOR MAYBE?
					Reg(1) <= "00000000000000000000000000000000";
					Reg(2) <= "00110010010000111111011010101001"; --Delta: 1 Theta: 7.853982e-01 
		elsif rising_edge(clock) then	
					Reg(0) <= X_in;
					Reg(1) <= Y_in;
					Reg(2) <= Z_in;
		end if;
	 	
		
	end process;
	X_out <= Reg(0);
	Y_out <= Reg(1);
	Z_out <= Reg(2); 	
end Behavioral;

