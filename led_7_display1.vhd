----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:33 04/11/2018 
-- Design Name: 
-- Module Name:    led_7_display1 - Behavioral 
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

entity led_7_display is
Port (clk_i 		: in STD_LOGIC;
		rst_i 		: in STD_LOGIC;
		digit_i 		: in STD_LOGIC_VECTOR(31 downto 0);
		led_7_an_o 	: out STD_LOGIC_VECTOR(3 downto 0);
		led_7_seg_o : out STD_LOGIC_VECTOR(7 downto 0)
		);
end led_7_display;

architecture Behavioral of led_7_display is

signal an_o 	: STD_LOGIC_VECTOR(3 downto 0);
signal seg_o 	: STD_LOGIC_VECTOR(7 downto 0);
signal licznik:  Integer range 0 to 3:=0;

--begin

--proces_an_o: process(clk_i,rst_i,digit_i) is
--begin
	--if rst_i = '1' then
		--licznik <= 0;
	--elsif rising_edge (clk_i) then
		--if (an_o = "0000") then
			--an_o 					<= "1110";
		--else
			--an_o(3 downto 1) 	<= an_o(2 downto 0);
			--an_o(0)				<= an_o(3);
		--end if;
	--end if;
--end process proces_an_o;

--proces_seg_o: process(clk_i,rst_i) is
begin 
	if rst_i = '1' then
		seg_o <= (others => '0');
	elsif rising_edge (clk_i) then
		-- warunek dla cyfry 0
		if (an_o(3) = '0') then
			seg_o <= digit_i( 7 downto  0);
		-- warunek dla cyfry 1
		elsif (an_o(0) = '0') then
			seg_o <= digit_i(15 downto  8);
		-- warunek dla cyfry 2
		elsif (an_o(1) = '0') then
			seg_o <= digit_i(23 downto 16);
		-- warunek dla cyfry 3
		elsif (an_o(2) = '0') then
			seg_o <= digit_i(31 downto 24);
		end if;

	end if;
end process proces_seg_o;

led_7_an_o 	<= an_o;
led_7_seg_o	<= seg_o;


end Behavioral;

