----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:42 04/11/2018 
-- Design Name: 
-- Module Name:    zad6vhdlmain - Behavioral 
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

entity zad7vhdlmain is
Port( clk_i 		: in STD_LOGIC;
		btn_i			: in STD_LOGIC_VECTOR(3 downto 0);
		sw_i			: in STD_LOGIC_VECTOR(7 downto 0);
		led_7_an_o 	: out STD_LOGIC_VECTOR(3 downto 0);
		led_7_seg_o : out STD_LOGIC_VECTOR(7 downto 0)
	);
end zad7vhdlmain;

architecture Behavioral of zad7vhdlmain is
	
	
--deklaracja komponentow
--________________________________________________________________________________________________
component clock_divider is
Port (clk_i 		: in STD_LOGIC;
		rst_i			: in STD_LOGIC;
		clk_o 		: out STD_LOGIC);
end component clock_divider;

component reset_gen is
Port (clk_i : in STD_LOGIC;
		rst_o : out STD_LOGIC);
end component reset_gen;

component led_7_display is
Port (clk_i 		: in STD_LOGIC;
		rst_i 		: in STD_LOGIC;
		digit_i 		: in STD_LOGIC_VECTOR(31 downto 0);
		led_7_an_o 	: out STD_LOGIC_VECTOR(3 downto 0);
		led_7_seg_o : out STD_LOGIC_VECTOR(7 downto 0)
		);
end component led_7_display;

component led_7_input_data is
Port (clk_i 		: in STD_LOGIC;
		rst_i 		: in STD_LOGIC;
		btn_i			: in STD_LOGIC_VECTOR(3 downto 0);
		sw_i			: in STD_LOGIC_VECTOR(7 downto 0);
		digit_o 		: out STD_LOGIC_VECTOR(31 downto 0)
		);
end component led_7_input_data;

--deklaracja sygnalow
--________________________________________________________________________________________________
signal rst_i				: STD_LOGIC;
signal clk_led_display 	: STD_LOGIC;
signal digit   			: STD_LOGIC_VECTOR(31 downto 0);

begin

--rozmieszczenie sygnalow
--________________________________________________________________________________________________
clock_divider1 : clock_divider port map (
		clk_i 		=> clk_i,
      rst_i 		=> rst_i,
      clk_o    	=> clk_led_display
		);

reset_gen1: reset_gen port map (
		clk_i			=> clk_i,
      rst_o       => rst_i
		);

led_7_input_data1: led_7_input_data port map (
		clk_i 		=> clk_led_display,
      rst_i 		=> rst_i,
      btn_i			=> btn_i,		
      sw_i			=> sw_i,		
      digit_o 		=> digit
		);

led_7_display1: led_7_display port map (
		clk_i 		=> clk_led_display,
      rst_i 		=> rst_i,	
      digit_i 		=> digit,
      led_7_an_o 	=> led_7_an_o,
      led_7_seg_o => led_7_seg_o
		);

end Behavioral;

