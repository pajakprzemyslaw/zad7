----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:12 04/11/2018 
-- Design Name: 
-- Module Name:    led_7_input_data1 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_7_input_data is
Port (clk_i 		: in STD_LOGIC;
		digit1		: in STD_LOGIC_VECTOR(3 downto 0);
		digit2		: in STD_LOGIC_VECTOR(3 downto 0);
		digit3		: in STD_LOGIC_VECTOR(3 downto 0);
		digit4		: in STD_LOGIC_VECTOR(3 downto 0); 
		dot1234     : in STD_LOGIC_VECTOR(3 downto 0):= "1011";
		digit_o 		: out STD_LOGIC_VECTOR(31 downto 0)
		);

end led_7_input_data;

architecture Behavioral of led_7_input_data is
constant D00 : STD_LOGIC_VECTOR(6 downto 0) := "0000001"; --abcdef-
constant D01 : STD_LOGIC_VECTOR(6 downto 0) := "1001111"; --bc
constant D02 : STD_LOGIC_VECTOR(6 downto 0) := "0010010"; --abdeg
constant D03 : STD_LOGIC_VECTOR(6 downto 0) := "0000110"; --abcdg
constant D04 : STD_LOGIC_VECTOR(6 downto 0) := "1001100"; --bcfg
constant D05 : STD_LOGIC_VECTOR(6 downto 0) := "0100100"; --acdfg
constant D06 : STD_LOGIC_VECTOR(6 downto 0) := "0100000"; --acdefg
constant D07 : STD_LOGIC_VECTOR(6 downto 0) := "0001111"; --abc
constant D08 : STD_LOGIC_VECTOR(6 downto 0) := "0000000"; --abcdefg
constant D09 : STD_LOGIC_VECTOR(6 downto 0) := "0000100"; --abcdefg
--constant BN : Integer := 50; --abcdefg
Type tablica is Array (0 to 9) of STD_LOGIC_VECTOR(6 downto 0);
Constant Table: tablica:=(D00,D01,D02,D03,D04,D05,D06,D07,D08,D09);
signal Digit:  STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001";
signal Clock:  STD_LOGIC := '0';
signal Button:  STD_LOGIC := '0';
signal Stan: Integer range 0 to 3 := 0;


signal digit7 		: STD_LOGIC_VECTOR(7 downto 1);
signal btn_i_reg	: STD_LOGIC_VECTOR(3 downto 0);

begin

proces_encode: process(sw_i(3 downto 0)) 
begin
	case sw_i(3 downto 0) is
		--                                  ( ABCDEFG   DP)
		when "0000" => digit7(7 downto 1) <= "0000001";
		when "0001" => digit7(7 downto 1) <= "1001111";
		when "0010" => digit7(7 downto 1) <= "0010010";
		when "0011" => digit7(7 downto 1) <= "0000110";
		when "0100" => digit7(7 downto 1) <= "1001100";
		when "0101" => digit7(7 downto 1) <= "0100100";
		when "0110" => digit7(7 downto 1) <= "0100000";
		when "0111" => digit7(7 downto 1) <= "0001111";
		when "1000" => digit7(7 downto 1) <= "0000000";
		when "1001" => digit7(7 downto 1) <= "0000100";
		when "1010" => digit7(7 downto 1) <= "0001000";
		when "1011" => digit7(7 downto 1) <= "1100000";
		when "1100" => digit7(7 downto 1) <= "0110001";
		when "1101" => digit7(7 downto 1) <= "1000010";
		when "1110" => digit7(7 downto 1) <= "0110000";
		when "1111" => digit7(7 downto 1) <= "0111000";
		when others => digit7 <= "1111110";
	end case;
end process proces_encode;

proces_btn: process(clk_i,rst_i) is
begin 
	if rst_i = '1' then
		digit_o <= (others => '1');
		btn_i_reg <= (others => '0');
	elsif rising_edge (clk_i) then
		btn_i_reg <= btn_i;
		-- warunek dla cyfry 0
		if (btn_i(0) = '1' and btn_i_reg(0) = '0') then
			digit_o( 7 downto  1) <= digit7;
		elsif (btn_i(1) = '1' and btn_i_reg(1) = '0') then
			digit_o(15 downto  9) <= digit7;
		elsif (btn_i(2) = '1' and btn_i_reg(2) = '0') then
			digit_o(23 downto 17) <= digit7;
		elsif (btn_i(3) = '1' and btn_i_reg(3) = '0') then
			digit_o(31 downto 25) <= digit7;
		end if;
		digit_o(0) 				 <= not(sw_i(4));
		digit_o( 8) 			 <= not(sw_i(5));
		digit_o(16) 			 <= not(sw_i(6));
		digit_o(24) 			 <= not(sw_i(7));

	end if;
end process proces_btn;


end Behavioral;

