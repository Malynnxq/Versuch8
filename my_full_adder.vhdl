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

entity my_full_adder is
  port (
    -- begin solution:
    P_A         : in  std_logic;
    P_B         : in  std_logic;
    P_CARRY_IN  : in  std_logic;
    P_SUM       : out std_logic;
    P_CARRY_OUT : out std_logic
    -- end solution!!
  );
end my_full_adder;

-- structure
architecture structure of my_full_adder is
  signal s_sum1     : std_logic;
  signal s_carry1   : std_logic;
  signal s_carry2   : std_logic;
begin
-- begin solution:
  HA0 : entity work.my_half_adder(dataflow)
    port map (
      P_A         => P_A,
      P_B         => P_B,
      P_SUM       => s_sum1,
      P_CARRY_OUT => s_carry1
    );

  HA1 : entity work.my_half_adder(dataflow)
    port map (
      P_A         => s_sum1,
      P_B         => P_CARRY_IN,
      P_SUM       => P_SUM,
      P_CARRY_OUT => s_carry2
    );

  -- OR using NAND only: COUT = C1 or C2 = (C1 nand C1) nand (C2 nand C2)
  P_CARRY_OUT <= (s_carry1 nand s_carry1) nand (s_carry2 nand s_carry2);
-- end solution!!
end structure;
