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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Constant_Package.ALL;


entity my_alu is
  generic (
    G_DATA_WIDTH  : integer := C_DWG;
    G_OP_WIDTH    : integer := C_OCW
  );
  port (
    p_op1     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    p_op2     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    p_alu_op  : in  std_logic_vector(G_OP_WIDTH - 1 downto 0);
    p_alu_out : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    p_carry_out : out std_logic
  );

end entity my_alu;

architecture rtl_structure of my_alu is
  signal s_res_xor : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_res_or  : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_res_and : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_res_add : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_res_sub : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_res_shift : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');
  signal s_carry_add : std_logic := '0';
  signal s_carry_sub : std_logic := '0';
  signal s_shift_type : std_logic := '0';
  signal s_shift_dir  : std_logic := '0';
begin
  XOR_U: entity work.my_gen_xor generic map (G_DATA_WIDTH => G_DATA_WIDTH) port map (p_op1, p_op2, s_res_xor);
  OR_U:  entity work.my_gen_or  generic map (G_DATA_WIDTH => G_DATA_WIDTH) port map (p_op1, p_op2, s_res_or);
  AND_U: entity work.my_gen_and generic map (G_DATA_WIDTH => G_DATA_WIDTH) port map (p_op1, p_op2, s_res_and);

  ADD_U: entity work.my_gen_add_sub generic map (G_DATA_WIDTH)
    port map (p_op1 => p_op1, p_op2 => p_op2, p_add_sub => '0', p_res => s_res_add, p_carry => s_carry_add);

  SUB_U: entity work.my_gen_add_sub generic map (G_DATA_WIDTH)
    port map (p_op1 => p_op1, p_op2 => p_op2, p_add_sub => '1', p_res => s_res_sub, p_carry => s_carry_sub);

  s_shift_type <= p_alu_op(G_OP_WIDTH - 1);
  s_shift_dir <= '1' when (p_alu_op = C_SRL_OP or p_alu_op = C_SRA_OP) else '0';

  SHIFTER_U: entity work.my_shifter(behavior)
    generic map (G_DATA_WIDTH => G_DATA_WIDTH)
    port map (p_op1 => p_op1, p_op2 => p_op2, p_shift_type => s_shift_type, p_shift_dir => s_shift_dir, p_res => s_res_shift);

  with p_alu_op select
    p_alu_out <= s_res_and   when C_AND_OP,
                 s_res_or    when C_OR_OP,
                 s_res_xor   when C_XOR_OP,
                 s_res_add   when C_ADD_OP,
                 s_res_sub   when C_SUB_OP,
                 s_res_shift when C_SLL_OP,
                 s_res_shift when C_SRL_OP,
                 s_res_shift when C_SRA_OP,
                 (others => '0') when others;

  with p_alu_op select
    p_carry_out <= s_carry_add when C_ADD_OP,
                   s_carry_sub when C_SUB_OP,
                   '0'         when others;


end architecture rtl_structure;
