-- Laboratory GdTi solutions/versuch7
-- Winter Semester 25/26
-- Group Details
-- Lab Date: 21.01.2026
-- 1. Participant First and  Last Name: Maksym Morozov
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables

library ieee;
use ieee.std_logic_1164.all;

entity my_half_adder is
  port (
    -- begin solution:
    P_A         : in  std_logic;
    P_B         : in  std_logic;
    P_SUM       : out std_logic;
    P_CARRY_OUT : out std_logic
    -- end solution!!
  );
end my_half_adder;

	--Notieren Sie ihre Umformungsschritte unter diesem Kommentar:
	
  
	-- begin solution:
	-- not A = A nand A
	-- A B A xor B A and B
	-- 1 1    0       1
	-- 1 0    1       0
	-- 0 1    1       0
	-- 0 0    0       0
	-- SUM = (A and not B) or (not A and B) = (A and (B nand B)) or ((A nand A) and B) =
	-- = not(not((A and (B nand B))) and (not((A nand A) and B))) = not((A and (B nand B)) nand not((A nand A) and B)) =
	-- = (A nand (B nand B)) nand (A nand A) nand B)
	-- CARRY = A and B = not(not(A and B)) = not(A nand B) = (A nand B) nand (A nand B)
	-- end solution!!	

-- dataflow
architecture dataflow of my_half_adder is
  begin
-- begin solution:
  P_SUM       <= (P_A nand (P_B nand P_B)) nand (P_B nand (P_A nand P_A));
  P_CARRY_OUT <= (P_A nand P_B) nand (P_A nand P_B);
-- end solution!!
end dataflow;
