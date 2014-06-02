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
    Port ( clock : in bit;
			  wr		: in bit; -- write/read flag. '0' is write, '1' is read
			  en		: in bit; -- enable bit
			  X_in : in  std_logic_vector(DataSize - 1 downto 0);
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

	process(clock)
	begin
	
		if clock = '1' and clock'event then
		
			if en = '1' then
				
				if wr = '0' then -- write mode
					Reg(0) <= X_in;
					Reg(1) <= Y_in;
					Reg(2) <= Z_in;
				elsif wr = '1' then -- read mode
					X_out <= Reg(0);
					Y_out <= Reg(1);
					Z_out <= Reg(2); 
				end if;
				
			end if;
			
		end if;
		
	end process;
end Behavioral;

