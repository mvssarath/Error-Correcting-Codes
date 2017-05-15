--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:16:34 11/09/2015
-- Design Name:   
-- Module Name:   E:/Docs/Xilinx_Workspaces/hc/tb.vhd
-- Project Name:  hc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: hammingcode
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT hammingcode
    PORT(
         datain : IN  std_logic_vector(1 to 8);
         errors : IN  std_logic_vector(1 to 12);
         clk : IN  std_logic;
         data_ec : OUT  std_logic_vector(1 to 8)
        );
    END COMPONENT;
    

   --Inputs
   signal datain : std_logic_vector(1 to 8) := (others => '0');
   signal errors : std_logic_vector(1 to 12) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal data_ec : std_logic_vector(1 to 8);

   -- Clock period definitions
   constant clk_period : time := 2 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hammingcode PORT MAP (
          datain => datain,
          errors => errors,
          clk => clk,
          data_ec => data_ec
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
	
		datain<="11111111";
		errors<="000000000000";
		wait for 50 ns;
		
		datain<="11111111";
		errors<="000000000001";
      
      wait for 50 ns;
		datain<="00000000";
		errors<="000000000010";
		wait for 50 ns;
		
		datain<="10101010";
		errors<="000000000100";
		wait for 50 ns;
		
		datain<="01010101";
		errors<="000000001000";
		wait for 50 ns;
		
		datain<="11110000";
		errors<="000000010000";
		wait for 50 ns;
		
		datain<="00001111";
		errors<="000000100000";
		wait for 50 ns;
		
		datain<="11001100";
		errors<="000000100000";
		wait for 50 ns;
		
		datain<="00110011";
		errors<="000010000000";
		wait for 50 ns;
		
		datain<="11100011";
		errors<="000100000000";
		wait for 50 ns;
		
		datain<="00011100";
		errors<="001000000000";
		wait for 50 ns;
		
		datain<="11101110";
		errors<="010000000000";
		wait for 50 ns;
		
		datain<="00010001";
		errors<="100000000000";
		wait for 50 ns;
   end process;

END;
