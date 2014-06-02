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
		  14 => 						
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
				  Data_out <= "ZZZZZZZZ"; -- 32 bit representation needed
				end if;
		  end if;
			
		end if;
	end process;
end Behavioral;

