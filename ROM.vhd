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
		r			: in std_logic;	-- read. design decision needs to be made about read
		i			: in integer; -- iteration number/address
		theta		: out std_logic_vector(data_width - 1 downto 0)
);
end ROM;

architecture Behavioral of ROM is

type ROM_Array is array (0 to rom_width - 1) 
	of std_logic_vector(data_width - 1 downto 0);

    constant Circular: ROM_Array := (
        0 => "00110010010000111111011010101001",
	1 => "00011101101011000110011100000101",
	2 => "00001111101011011011101011111101",
	3 => "00000111111101010110111010100111",
	4 => "00000011111111101010101101110111",
	5 => "00000001111111111101010101011100",
	6 => "00000000111111111111101010101011",
	7 => "00000000011111111111111101010101",
	8 => "00000000001111111111111111101011",
	9 => "00000000000111111111111111111101",
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
  	OTHERS => null
	);   

    constant Hyperbolic: ROM_Array := (
        0 => "00000001",		--  Needs 32 bit look up table results
        1 => "00000010",		-- 
        2 => "00000011",		-- 
        3 => "00000100",      --
        4 => "00000101",		--
        5 => "00000110",      --
        6 => "00000111",		--
        7 => "00001000",      --
        8 => "00001001",      --
        9 => "00001010",      --
        10 => "00001011",		--
		  11 => "00001100",     --
        12 => "00001101",     --
        13 => "00001110",		--
		  14 => 						--
		  15 =>
		  16 =>
		  17 =>
		  18 =>
		  19 =>
		  20 =>
		  21 =>
		  22 =>
		  23 =>
		  24 =>
		  25 =>
		  26 =>
		  27 =>
		  28 =>
		  29 =>
		  30 =>
		  31 =>
		  OTHERS => null
	);       

begin
	process(clock)
	begin
		if (clock = '1' and clock'event) then
			if en = '1' then
				if( r = '1' ) then -- design decision needs to be made about read
					if mode = "01" then -- circular
							theta <= Circular(i);
						elsif mode = "10" then -- hyperbolic
							theta <= Hyperbolic(i);
						else 
							theta <= "zzzzzz"; -- 32 bit representation needed
					end if;
				else
				  theta <= "ZZZZZZZZ"; -- 32 bit representation needed
				end if;
		  end if;
			
		end if;
	end process;
end Behavioral;

