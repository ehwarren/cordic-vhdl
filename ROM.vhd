----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:41:13 05/26/2014 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
	Generic (data_width 	: natural := 32;
				rom_width 	: natural := 32
				);
port(	clock	   : in std_logic;
		mode		: in std_logic_vector(1 downto 0);	-- 0 is circular or 1 is hyperbolic table
		en			: in std_logic;	-- enable
--		r			: in std_logic;	-- read. design decision needs to be made about read
		i			: in STD_LOGIC_VECTOR(4 downto 0); -- iteration number/address
		theta		: out std_logic_vector(data_width - 1 downto 0)
);
end ROM;

architecture Behavioral of ROM is

type ROM_Array is array (0 to rom_width - 1) 
	of std_logic_vector(data_width - 1 downto 0);

    constant Circular: ROM_Array := (       
		0 => "00110010010000111111011010101001", --Delta: 1 Theta: 7.853982e-01 
		1 => "00011101101011000110011100000101", --Delta: 5.000000e-01 Theta: 4.636476e-01 
		2 => "00001111101011011011101011111101", --Delta: 2.500000e-01 Theta: 2.449787e-01 
		3 => "00000111111101010110111010100111", --Delta: 1.250000e-01 Theta: 1.243550e-01 
		4 => "00000011111111101010101101110111", --Delta: 6.250000e-02 Theta: 6.241881e-02 
		5 => "00000001111111111101010101011100", --Delta: 3.125000e-02 Theta: 3.123983e-02 
		6 => "00000000111111111111101010101011", --Delta: 1.562500e-02 Theta: 1.562373e-02 
		7 => "00000000011111111111111101010101", --Delta: 7.812500e-03 Theta: 7.812341e-03 
		8 => "00000000001111111111111111101011", --Delta: 3.906250e-03 Theta: 3.906230e-03 
		9 => "00000000000111111111111111111101", --Delta: 1.953125e-03 Theta: 1.953123e-03 
		10 => "00000000000100000000000000000000", --Delta: 9.765625e-04 Theta: 9.765622e-04 
		11 => "00000000000010000000000000000000", --Delta: 4.882812e-04 Theta: 4.882812e-04 
		12 => "00000000000001000000000000000000", --Delta: 2.441406e-04 Theta: 2.441406e-04 
		13 => "00000000000000100000000000000000", --Delta: 1.220703e-04 Theta: 1.220703e-04 
		14 => "00000000000000010000000000000000", --Delta: 6.103516e-05 Theta: 6.103516e-05 
		15 => "00000000000000001000000000000000", --Delta: 3.051758e-05 Theta: 3.051758e-05 
		16 => "00000000000000000100000000000000", --Delta: 1.525879e-05 Theta: 1.525879e-05 
		17 => "00000000000000000010000000000000", --Delta: 7.629395e-06 Theta: 7.629395e-06 
		18 => "00000000000000000001000000000000", --Delta: 3.814697e-06 Theta: 3.814697e-06 
		19 => "00000000000000000000100000000000", --Delta: 1.907349e-06 Theta: 1.907349e-06 
		20 => "00000000000000000000010000000000", --Delta: 9.536743e-07 Theta: 9.536743e-07 
		21 => "00000000000000000000001000000000", --Delta: 4.768372e-07 Theta: 4.768372e-07 
		22 => "00000000000000000000000100000000", --Delta: 2.384186e-07 Theta: 2.384186e-07 
		23 => "00000000000000000000000010000000", --Delta: 1.192093e-07 Theta: 1.192093e-07 
		24 => "00000000000000000000000001000000", --Delta: 5.960464e-08 Theta: 5.960464e-08 
		25 => "00000000000000000000000000100000", --Delta: 2.980232e-08 Theta: 2.980232e-08 
		26 => "00000000000000000000000000010000", --Delta: 1.490116e-08 Theta: 1.490116e-08 
		27 => "00000000000000000000000000001000", --Delta: 7.450581e-09 Theta: 7.450581e-09 
		28 => "00000000000000000000000000000100", --Delta: 3.725290e-09 Theta: 3.725290e-09 
		29 => "00000000000000000000000000000010", --Delta: 1.862645e-09 Theta: 1.862645e-09 
		30 => "00000000000000000000000000000001", --Delta: 9.313226e-10 Theta: 9.313226e-10 
		31 => "00000000000000000000000000000001", --Delta: 4.656613e-10 Theta: 4.656613e-10
  	OTHERS => "0"
	);   

    constant Hyperbolic: ROM_Array := ( --DO NOT FORGET to offset iteration number by 1 in controller
        1 => "00100011001001111101010011110101",
	2 => "00010000010110001010111011111011",
	3 => "00001000000010101100010010001110",
	4 => "00000100000000010101011000100011",
	5 => "00000010000000000010101010110001",
	6 => "00000001000000000000010101010110",
	7 => "00000000100000000000000010101011",
	8 => "00000000010000000000000000010101",
	9 => "00000000001000000000000000000011",
	10 => "00000000000100000000000000000000",
	11 => "00000000000010000000000000000000",
	12 => "00000000000001000000000000000000",
	13 => "00000000000000100000000000000000",
	14 => "00000000000000010000000000000000",
	15 => "00000000000000001000000000000000",
	16 => "00000000000000000100000000000000",
	17 => "00000000000000000010000000000000",
	18 => "00000000000000000001000000000000",
	19 => "00000000000000000000100000000000",
	20 => "00000000000000000000010000000000",
	21 => "00000000000000000000001000000000",
	22 => "00000000000000000000000100000000",
	23 => "00000000000000000000000010000000",
	24 => "00000000000000000000000001000000",
	25 => "00000000000000000000000000100000",
	26 => "00000000000000000000000000010000",
	27 => "00000000000000000000000000001000",
	28 => "00000000000000000000000000000100",
	29 => "00000000000000000000000000000010",
	30 => "00000000000000000000000000000001",
	31 => "00000000000000000000000000000001",
	32 => "00000000000000000000000000000000",
	OTHERS => "0"
	);       

begin
	process(clock)
	begin
		if (clock = '1' and clock'event) then
			if en = '1' then
				--if( r = '1' ) then -- design decision needs to be made about read
					if mode = "01" then -- circular
							theta <= Circular(to_integer(unsigned(i)));
						elsif mode = "10" then -- hyperbolic
							theta <= Hyperbolic(to_integer(unsigned(i)));
						else 
							theta <= "0"; -- 32 bit representation needed
					end if;
				--else
			else
				  theta <= "0"; -- 32 bit representation needed
				--end if;
		  	end if;
		end if;
	end process;
end Behavioral;

