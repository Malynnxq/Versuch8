-- Laboratory GdTi solutions/versuch5
-- Winter Semester 25/26
-- Group Details
-- Lab Date: 10.12.2025
-- 1. Participant First and  Last Name: Maksym Morozov
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Constant_Package.ALL;

-- begin solution:

entity my_gen_and is
	generic (G_DATA_WIDTH : Integer := 8);
	port (
		p_op1 : in STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
		p_op2 : in STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0);
		p_res : out STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0)
	);
end my_gen_and;

architecture dataflow of my_gen_and is
begin
	p_res <= p_op1 and p_op2;
end dataflow;

-- end solution!!
