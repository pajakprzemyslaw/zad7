----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:40 04/11/2018 
-- Design Name: 
-- Module Name:    reset_gen1 - Behavioral 
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

entity reset_gen is
Port (clk_i : in STD_LOGIC;
		rst_o : out STD_LOGIC);
end reset_gen;

architecture Behavioral of reset_gen is
signal counter : STD_LOGIC_VECTOR(4 downto 0) := "00000";


begin
proces: process(clk_i) is
begin 
	if rising_edge (clk_i) then
		if (counter(4) = '0') then
			counter<=counter+1;
		end if;
	end if;
end process proces;
	
rst_o <= not(counter(4));

end Behavioral;

