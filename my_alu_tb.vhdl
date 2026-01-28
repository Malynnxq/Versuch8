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
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;
use work.CONSTANT_Package.ALL;

entity my_alu_tb is
end my_alu_tb;

architecture behavior of my_alu_tb is
  signal s_op1, s_op2,  s_lu_out,  s_expect : std_logic_vector(C_DWG-1 downto 0) := (others => '0');
  signal  s_lu_op: std_logic_vector(C_OCW-1 downto 0) := (others => '0');
  signal  s_carry_out,s_shift_type,s_shift_direction : std_logic;
  constant C_PERIOD : time := 10 ns; -- Example: ClockPERIOD of 10 ns
  signal s_clk: std_logic := '0';
begin
 LU1: entity work.my_alu generic map (C_DWG,C_OCW) 
 port map (
    p_op1=>s_op1, p_op2=>s_op2,
    p_alu_op=>s_lu_op,
    p_alu_out=>s_lu_out,
    p_carry_out=> s_carry_out );   
 lu: process
 
  begin
    s_clk <= '1'; wait for C_PERIOD/2;
    s_clk <= '0'; wait for C_PERIOD/2;
    for op1_i in -(2**(C_DWG-1)) to (2**(C_DWG-1)-1) loop
	  
      s_op1 <= std_logic_vector(to_signed(op1_i, C_DWG));
      for op2_i in -(2**(C_DWG-1)) to (2**(C_DWG-1)-1) loop
      
        s_op2 <= std_logic_vector(to_signed(op2_i, C_DWG));
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        -- and
        s_lu_op<=C_AND_OP;
        s_expect <= s_op1 and s_op2;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in AND-Function " severity error;
        -- or
        s_lu_op<=C_OR_OP;
        s_expect <= s_op1 or s_op2;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in OR-Function " severity error;

        -- xor
        s_lu_op<=C_XOR_OP;
        s_expect <= s_op1 xor s_op2;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in XOR-Function " severity error;
        
        
        if op2_i>=0 and op2_i<integer(log2(real( C_DWG))) then
        -- sll
        s_lu_op<=C_SLL_OP;
        if (op2_i<=0) then 
        s_expect <= s_op1;
        elsif (op2_i<C_DWG) then
        s_expect(op2_i-1 downto 0) <= (others => '0');
        s_expect(C_DWG-1 downto op2_i) <= s_op1(C_DWG-1-op2_i downto 0);
        end if;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in sll-Function " severity error;

        -- srl
        s_lu_op<=C_SRL_OP;
        s_expect <= (others => '0');
        if (op2_i<=0) then 
        s_expect <= s_op1;
        elsif (op2_i<C_DWG) then
        s_expect <= (others => '0');
        s_expect(C_DWG-1-op2_i downto 0) <= s_op1(C_DWG-1 downto op2_i);
        end if;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in srl-Function " severity error;

        -- sra
        s_lu_op<=C_SRA_OP;
        if (op2_i<=0) then 
        s_expect <= s_op1;
        elsif (op2_i<C_DWG) then
        s_expect <= (others => s_op1(C_DWG-1));
        s_expect(C_DWG-1-op2_i downto 0) <= s_op1(C_DWG-1 downto op2_i);
        end if;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        assert(s_expect= s_lu_out) report "Had error in sra-Function" severity error;
        end if;
        -- add
        s_lu_op<=C_ADD_OP;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        if ((op1_i+op2_i) /= to_integer(signed(s_lu_out))) and ((op1_i+op2_i- 2**C_DWG) /= (to_integer(signed(s_lu_out)))) and (( to_integer(signed(s_lu_out)) /=  (op1_i+op2_i) mod (2**(C_DWG)))) then
          report integer'image(op1_i) & "+" & integer'image(op2_i) & " ==> " & integer'image(op1_i+op2_i) & " but add-op simulation returns " & integer'image(to_integer(signed(s_lu_out))) severity error;
        end if;

        -- sub
        s_lu_op<=C_SUB_OP;
        s_clk <= '1'; wait for C_PERIOD/2;
        s_clk <= '0'; wait for C_PERIOD/2;
        if ((op1_i-op2_i) /= to_integer(signed(s_lu_out))) and ((op1_i-op2_i- 2**C_DWG) /= (to_integer(signed(s_lu_out)))) and (( to_integer(signed(s_lu_out)) /=  (op1_i-op2_i) mod (2**(C_DWG)))) then
          report integer'image(op1_i) & "+" & integer'image(op2_i) & " ==> " & integer'image(op1_i+op2_i) & " but sub-op simulation returns " & integer'image(to_integer(signed(s_lu_out))) severity error;
        end if;

        end loop;
        end loop;

    assert false report "end of test" severity note;

   wait; --  Wait forever; this will finish the simulation.
  end process;
end behavior;
