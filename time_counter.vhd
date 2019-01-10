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

entity time_counter is

Port (clk_i 				: in STD_LOGIC;
		rst_i 				: in STD_LOGIC;
		start_stop_reset 	: in STD_LOGIC);
		
end time_counter;


architecture Behavioral of time_counter is

TYPE time_counter_states IS (START_PRESSED, STOP_PRESSED, RESET_PRESSED);
signal time_counter_state 		: time_counter_states;
signal start_stop_reset_prev  : std_logic;
signal button_toggle				: std_logic;
signal one_ms_tick				: std_logic;
signal ms_counter					: integer;
constant ms_counter_value		: integer:=40;

signal ms_x1	: std_logic_vector(3 downto 0);
signal ms_x10  : std_logic_vector(3 downto 0);
signal s_x1    : std_logic_vector(3 downto 0);
signal s_x10   : std_logic_vector(3 downto 0);

begin

	button_toggle <= start_stop_reset and (not start_stop_reset_prev);

	proces_FSM: process(clk_i,rst_i) is
	begin 
		if rst_i = '1' then
			time_counter_state 		<= RESET_PRESSED;	
			start_stop_reset_prev	<= '0';
		elsif rising_edge (clk_i) then
			start_stop_reset_prev 	<= start_stop_reset;
			case time_counter_state is
				when RESET_PRESSED =>
					if button_toggle = '1' then
						time_counter_state <=  START_PRESSED;
					end if;
				when START_PRESSED =>
					if button_toggle = '1' then
						time_counter_state <=  STOP_PRESSED;
					end if;			
				when STOP_PRESSED =>
					if button_toggle = '1' then
						time_counter_state <=  RESET_PRESSED;
					end if;						
				when OTHERS =>
					time_counter_state <=  RESET_PRESSED;			
			end case;
		end if;
	end process proces_FSM; -- FSM: Finite State Machine  / Skonczona Maszyna Stanow
	
	
	proces_ms_counter: process(clk_i,rst_i) is
	begin 
		if rst_i = '1' then
			one_ms_tick					<= '0';
			ms_counter					<= 0;
		elsif rising_edge (clk_i) then
			if time_counter_state = START_PRESSED then
				if (ms_counter < (ms_counter_value-1)) then
					ms_counter 	<= ms_counter + 1;
					one_ms_tick <= '0';
				else
					ms_counter 	<= 0;
					one_ms_tick <= '1';
				end if;
			else
				ms_counter 	<= 0;
				one_ms_tick <= '0';
			end if;
		end if;
	end process proces_ms_counter;
	
	proces_time_counter: process(clk_i,rst_i) is
	begin 
		if rst_i = '1' then
			ms_x1	 <= (others => '0');
			ms_x10 <= (others => '0');
			s_x1   <= (others => '0');
			s_x10  <= (others => '0');
		elsif rising_edge (clk_i) then
			case time_counter_state is
				when RESET_PRESSED =>
					ms_x1	 <= (others => '0');
					ms_x10 <= (others => '0');
					s_x1   <= (others => '0');
					s_x10  <= (others => '0');
				when START_PRESSED =>
					if (ms_x1 < "1001") then -- jezeli ilosc jednosci milisekund <= 9
						ms_x1 <= ms_x1 + 1;
					else
						ms_x1 <= (others => '0');
						if (ms_x10 < "1001") then -- jezeli ilosc dziesiatek milisekund <= 9
							ms_x10 <= ms_x10 + 1;
						else
							ms_x10 <= (others => '0');
							if (s_x1 < "1001") then -- jezeli ilosc jednosci sekund <= 9
								s_x1 <= s_x1 + 1;
							else
								s_x1 <= (others => '0');
								if (s_x10 < "1001") then -- jezeli ilosc dziesiatek sekund <= 9
									s_x10 <= s_x10 + 1;
								else
									ms_x1 	<= (others => '1');
									ms_x10 	<= (others => '1');
									s_x1 		<= (others => '1');
									s_x10 	<= (others => '1');
								end if;													
							end if;													
						end if;						
					end if;

				when STOP_PRESSED =>

				when OTHERS =>
					ms_x1	 <= (others => '0');
					ms_x10 <= (others => '0');
					s_x1   <= (others => '0');
					s_x10  <= (others => '0');				
			end case;
		end if;
	end process proces_time_counter;
	
end Behavioral;

