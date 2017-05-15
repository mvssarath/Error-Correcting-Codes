----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:26 11/07/2015 
-- Design Name: 
-- Module Name:    hammingcode - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hammingcode is
    Port ( datain : in  STD_LOGIC_VECTOR (1 to 8);    ----- input data sequence 8 bits
				errors: in std_logic_vector (1 to 12);    ----- errors introduced for testing
				clk:in std_logic;                          -- global clock
	 			data_ec : out  STD_LOGIC_VECTOR (1 to 8));  --- data out after error correction
end hammingcode;

architecture Behavioral of hammingcode is


signal p1,p2,p4,p8,c1,c2,c4,c8: std_logic;
signal pgout: std_logic_vector (1 to 12);
signal tx: std_logic_vector (1 to 12);
signal cgout: std_logic_vector (1 to 12);
signal ec: std_logic_vector(1 to 12);
signal check: std_logic_vector(1 to 4);
begin
process(clk)
begin
if (clk'event and clk='1') then
------------------------ < STAGE - I > ------------------

p1<= datain(1) xor datain(2) xor datain(4) xor datain(5) xor datain(7);    ---- Parity bit P1
p2<= datain(1) xor datain(3) xor datain(4) xor datain(6) xor datain(7);    ---- Parity bit P2
p4<= datain(2) xor datain(3) xor datain(4) xor datain(8);						---- Parity bit P4
p8<= datain(5) xor datain(6) xor datain(7) xor datain(8);						---- Parity bit P8

pgout<=(p1,p2,datain(1),p4,datain(2),datain(3),datain(4),p8,datain(5),datain(6),datain(7),datain(8)); --- the sequence that is transmitted

------------------------ < STAGE - II > ------------------

tx<= pgout xor errors ;           ------ Introducing Errors to each bit

------------------------ < STAGE - III and STAGE - IV > ------------------

c1<= pgout(1) xor pgout(3) xor pgout(5) xor pgout(7) xor pgout(9) xor pgout(11);   -----Check bit C1
c2<= pgout(2) xor pgout(3) xor pgout(6) xor pgout(7) xor pgout(10) xor pgout(11);	-----Check bit C1
c4<= pgout(4) xor pgout(5) xor pgout(6) xor pgout(7) xor pgout(12);						-----Check bit C1
c8<= pgout(8) xor pgout(9) xor pgout(10) xor pgout(11) xor pgout(12);					-----Check bit C1
check<=(c1,c2,c4,c8);
cgout<=(C1,C2,C4,C8,pgout(3),pgout(5),pgout(6),pgout(7),pgout(9),pgout(10),pgout(11),pgout(12));  ---- Checkbit sequence

case check is                                    ---- error detection and Correction
		when "0000" => ec<=pgout(1 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "1000" => ec(1)<=(not(pgout(1)));
							ec(2 to 12)<=pgout(2 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "0100" => ec(1)<=pgout(1);
							ec(2)<=(not(pgout(2)));
							ec(3 to 12)<=pgout(3 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "1100"	=> ec(1 to 2)<=(pgout(1 to 2));ec(3)<=(not(pgout(3)));ec(4 to 12)<=pgout(4 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "0010" => ec(1 to 3)<=pgout(1 to 3);ec(4)<=not(pgout(4));ec(5 to 12)<=pgout(5 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "1010" => ec(1 to 4)<=pgout(1 to 4);ec(5)<=not(pgout(5));ec(6 to 12)<=pgout(6 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "0110" => ec(1 to 5)<=(pgout(1 to 5));ec(6)<=not(pgout(6));ec(7 to 12)<=pgout(7 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "1110" => ec(1 to 6)<=(pgout(1 to 6));ec(7)<=not(pgout(7));ec(8 to 12)<=pgout(8 to 12);
		       			data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
							
		when "0001" => ec(1 to 7)<=(pgout(1 to 7));ec(8)<=not(pgout(8));ec(9 to 12)<=pgout(9 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
							
		when "1001" => ec(1 to 8)<=(pgout(1 to 8));ec(9)<=not(pgout(9));ec(10 to 12)<=pgout(10 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
							
		when "0101" => ec(1 to 9)<=(pgout(1 to 9));ec(10)<=not(pgout(10));ec(11 to 12)<=pgout(11 to 12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
							
		when "1101" => ec(1 to 10)<=(pgout(1 to 10));ec(11)<=not(pgout(11));ec(12)<=pgout(12);
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		
		when "0011" => ec(1 to 11)<= pgout(1 to 11);ec(12)<=not(pgout(12));
							data_ec<=(ec(3),ec(5),ec(6),ec(7),ec(9),ec(10),ec(11),ec(12));
		when others => data_ec <= "XXXXXXXX";
end case;		
end if;
end process;
end Behavioral;

