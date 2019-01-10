----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:32 04/11/2018 
-- Design Name: 
-- Module Name:    clock_divider1 - Behavioral 
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

entity button_filter is

Port (clk_i 	: in STD_LOGIC;
		rst_i 	: in STD_LOGIC;
		button_i : in STD_LOGIC;
		button_o	: out STD_LOGIC);
		
end button_filter;


architecture Behavioral of button_filter is

constant button_filter_delay : integer:=200;
--constant button_filter_delay : integer:=10;
signal button_filter_counter : integer;
signal button_reg 		: STD_LOGIC;
signal button_lock		: STD_LOGIC;

begin
	proces: process(clk_i,rst_i) is
	begin 
		if rst_i = '1' then
			button_reg 					<= '0';
			button_lock					<= '0';
			button_filter_counter	<= 0;
		elsif rising_edge (clk_i) then
			if button_lock = '0' then   -- jezeli nie jest zablokowane sprawdzanie przycisku to reaguj na zmiane przycisku
				if button_i /= button_reg then
					button_lock <= '1';
					button_reg	<= button_i;
				end if;
			else								-- jezeli jest zablokowane sprawdzanie przycisku to czekaj czas okreslony przez button_filter_delay
				if button_filter_counter < button_filter_delay-1 then
					button_filter_counter <=  button_filter_counter + 1;
				else
					button_filter_counter 	<= 0;
					button_lock					<= '0';
				end if;
			end if;
		end if;
	end process proces;
	
	button_o <= button_reg;
	
end Behavioral;

