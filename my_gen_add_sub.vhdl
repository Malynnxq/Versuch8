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

library ieee;
use ieee.std_logic_1164.all;
use work.Constant_Package.ALL;

entity my_gen_add_sub is
  generic (
    G_DATA_WIDTH : integer := C_DWG
  );
  port (
    p_op1     : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
    p_op2     : in  std_logic_vector(G_DATA_WIDTH-1 downto 0);
    p_add_sub : in  std_logic; -- '0' add, '1' sub
    p_res     : out std_logic_vector(G_DATA_WIDTH-1 downto 0);
    p_carry   : out std_logic
  );
end my_gen_add_sub;

architecture structure of my_gen_add_sub is
  signal s_carry  : std_logic_vector(G_DATA_WIDTH downto 0);
  signal s_temp_b : std_logic_vector(G_DATA_WIDTH-1 downto 0);
begin
  s_carry(0) <= p_add_sub;

  gen_fa : for i in 0 to G_DATA_WIDTH-1 generate
    s_temp_b(i) <= p_op2(i) xor p_add_sub;
    u_fa : entity work.my_full_adder(structure)
      port map (
        P_A         => p_op1(i),
        P_B         => s_temp_b(i),
        P_CARRY_IN  => s_carry(i),
        P_SUM       => p_res(i),
        P_CARRY_OUT => s_carry(i+1)
      );
  end generate;

  p_carry <= s_carry(G_DATA_WIDTH);
end structure;
