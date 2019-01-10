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
			rst_i	: IN  std_logic;
         btn_0 : IN  std_logic;
         led_7_an_o : OUT  std_logic_vector(3 downto 0);
         led_7_seg_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
	signal rst_i : std_logic := '0';
   signal btn_0 : std_logic := '0';

 	--Outputs
   signal led_7_an_o : std_logic_vector(3 downto 0);
   signal led_7_seg_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: zad7vhdlmain PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          btn_0 => btn_0,
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
	
	
--	btn_0_process :process
--   begin
--		btn_0 <= '0';
--		wait for clk_i_period*1.2;
--		btn_0 <= '1';
--		wait for clk_i_period*1.2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst_i <= '0';
      wait for clk_i_period*15;
		rst_i <= '1';
      wait for clk_i_period*15;
		rst_i <= '0';
		
		wait for clk_i_period*50;
		
		-- start
		btn_0 <= '1';
		wait for clk_i_period*15;
		btn_0 <= '0';
		
		wait for clk_i_period*55000;
		
		-- stop
		btn_0 <= '1';
		wait for clk_i_period*15;
		btn_0 <= '0';
		
		wait for clk_i_period*22000;
		
		-- reset
		btn_0 <= '1';
		wait for clk_i_period*15;
		btn_0 <= '0';

      wait;
   end process;

END;
