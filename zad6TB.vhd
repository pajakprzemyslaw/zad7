--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:04:17 04/11/2018
-- Design Name:   
-- Module Name:   C:/Designs/zad6wyswietlacz/zad6TB.vhd
-- Project Name:  zad6wyswietlacz
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: zad6vhdlmain
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY zad7TB IS
END zad7TB;
 
ARCHITECTURE behavior OF zad7TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT zad7vhdlmain
    PORT(
         clk_i : IN  std_logic;
         btn_i : IN  std_logic_vector(3 downto 0);
         sw_i : IN  std_logic_vector(7 downto 0);
         led_7_an_o : OUT  std_logic_vector(3 downto 0);
         led_7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal btn_i : std_logic_vector(3 downto 0) := (others => '0');
   signal sw_i : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal led_7_an_o : std_logic_vector(3 downto 0);
   signal led_7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: zad7vhdlmain PORT MAP (
          clk_i => clk_i,
          btn_i => btn_i,
          sw_i => sw_i,
          led_7_an_o => led_7_an_o,
          led_7_seg_o => led_7_seg_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		btn_i <= (others => '0');
		sw_i 	<= (others => '0');
      wait for clk_i_period*50;
		sw_i(3 downto 0) <= X"A";
		sw_i(7 downto 4) <= X"F";
		wait for clk_i_period*28;
		btn_i(2) <= '1';
		wait for clk_i_period*20;
		--btn_i(0) <= '1';
		
		wait for clk_i_period*10;
		sw_i(3 downto 0) <= X"D";
		sw_i(7 downto 4) <= X"0";
		
		wait for clk_i_period*10;
		btn_i(2) <= '0';
		wait for clk_i_period*10;
		btn_i(2) <= '1';
		--wait for clk_i_period*10;
		--sw_i(7 downto 3) <=X"A";
      -- insert stimulus here 

      wait;
   end process;

END;
