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
			  en	: in std_logic;
			  m : in std_logic_vector(1 downto 0);
			  op : in std_logic;
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

	process(clock,reset)
	begin
		if reset = '1' then 
		 case m is -- case statement to determine starting values for each individual mode and op.
			when "01" =>
				if op = '0' then -- rotational circular
					Reg(0) <= x"26DD3B6A"; 
					Reg(1) <= x"00000000";
					Reg(2) <= x"2182A470"; 
				else -- vectoring circular
					Reg(0) <= x"26DD3B6A"; 
					Reg(1) <= x"26DD3B6A";
					Reg(2) <= x"3243F6A9"; 				
				end if;
			when "00" =>
				if op = '0' then -- rotational linear
					Reg(0) <= x"0CCCCCCD"; 
					Reg(1) <= x"051EB852";
					Reg(2) <= x"60000000"; 				
				else  -- vectoring linear
					Reg(0) <= x"0CCCCCCD"; 
					Reg(1) <= x"051EB852";
					Reg(2) <= x"40000000"; 
				end if;
			when "10" =>
				if op = '0' then -- rotational hyperbolic
					Reg(0) <= x"07BA5CFA"; 
					Reg(1) <= x"0F74B9F5";
					Reg(2) <= x"40000000"; 				
				else -- vectoring hyperbolic
					Reg(0) <= x"3DD2E7D3"; 
					Reg(1) <= x"172F16EF";
					Reg(2) <= x"00000000"; 				
				end if;
			when others => -- error state values. Occurs when mode is set to "11"
					Reg(0) <= x"00000000"; 
					Reg(1) <= x"00000000";
					Reg(2) <= x"00000000";
		 end case;
		elsif rising_edge(clock) and en = '1' then	
					Reg(0) <= X_in; -- register bank updates only on a rising edge clock cycle.
					Reg(1) <= Y_in; -- this ensures correct values are loaded for each clock cycle
					Reg(2) <= Z_in;
		
		end if;
	 	
		
	end process;
	X_out <= Reg(0); -- register bank always outputs the register values
	Y_out <= Reg(1);
	Z_out <= Reg(2); 	
end Behavioral;

