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

entity clock_divider is

Port (clk_i : in STD_LOGIC;
		rst_i : in STD_LOGIC;
		clk_o : out STD_LOGIC);
		
end clock_divider;


architecture Behavioral of clock_divider is
-- constant N: integer:=12500;
constant N: integer:=5;
signal clk_o_1 : STD_LOGIC :='0';
signal licznik: integer:=0;

begin
proces: process(clk_i,rst_i) is
begin 
	if rst_i = '1' then
		clk_o_1 <='0';
		licznik <= 0;
			else if rising_edge (clk_i) then
				if licznik < (N/2 -1) then
					clk_o_1<='0';
					licznik <= licznik +1;
				end if;
				if licznik >=( N/2 - 1) and licznik < (N -1) then
					clk_o_1<='1';
					licznik <= licznik +1;
				end if;
				if licznik >= (N -1) then
					clk_o_1 <= not clk_o_1;
					licznik <= 0;
				end if;
			end if;
	end if;
	end process proces;
	clk_o<=clk_o_1;
end Behavioral;

