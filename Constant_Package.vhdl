-- Laboratory GdTi solutions/versuch8
-- Winter Semester 25/26
-- Group Details
-- Lab Date:
-- 1. Participant First and  Last Name: 
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables


library IEEE;
use ieee.std_logic_1164.all;

package Constant_Package is

  -- General constants
  constant C_OCW : Integer := 4;
  constant C_DWG : Integer := 4;

  -- Instruction Opcodes
  constant C_AND_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0111";
  constant C_XOR_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0100";
  constant C_OR_OP  : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0110";

  constant C_SLL_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0001"; 
  constant C_SRL_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0101"; 
  constant C_SRA_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "1101";

  constant C_ADD_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "0000";
  constant C_SUB_OP : STD_LOGIC_VECTOR(C_OCW - 1 downto 0) := "1000";


end package Constant_Package;
