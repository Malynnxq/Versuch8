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

entity my_shifter_tb is
end my_shifter_tb;

architecture behavior of my_shifter_tb is
  signal s_op1,s_op2, s_result : std_logic_vector( C_DWG-1 downto 0) := (others => '0');
  signal s_expect : std_logic_vector( C_DWG-1 downto 0) := (others => '0');
  signal s_shift_type, s_shift_direction :std_logic:='0';
  constant PERIOD : time := 10 ns; -- Example: Clockperiod of 10 ns
  
  
begin
  SHIFTER:        entity work.my_shifter(behavior)  generic map (G_DATA_WIDTH =>  C_DWG) port map (s_op1,s_op2,s_shift_type,s_shift_direction, s_result);

 process

  begin
  -- init 
  s_op1 <= std_logic_vector(to_unsigned(0,  C_DWG));
  s_op2 <= std_logic_vector(to_unsigned(0,  C_DWG));
  s_shift_type<=not s_shift_type;
  s_shift_direction<= not s_shift_direction;
   for op1_i in -(2**( C_DWG-1)) to (2**( C_DWG-1)-1) loop
     for op2_i in 0 to (2**(integer(log2(real( C_DWG))))-1) loop
        s_op1 <= std_logic_vector(to_signed(op1_i,  C_DWG));
        s_op2 <= std_logic_vector(to_unsigned(op2_i,  C_DWG));

        -- sll
        s_shift_type<='0';
        s_shift_direction<='0';
        wait for PERIOD/2;
        s_expect <= (others => '0');
        s_expect( C_DWG-1 downto op2_i) <= s_op1( C_DWG-1-op2_i downto 0);
        wait for PERIOD/2;
        assert(s_expect= s_result)  report "Had error in sll-Function (behavior)"  & "s_expect: " & integer'image(to_integer(unsigned(s_expect))) & " but is " & integer'image(to_integer(unsigned(s_result))) severity error;

        -- srl
        s_shift_type<='0';
        s_shift_direction<='1';
        wait for PERIOD/2;
        s_expect <= (others => '0');
        if (op2_i<=0) then 
        s_expect <= s_op1;
        elsif (op2_i< C_DWG) then
        s_expect( C_DWG-1-op2_i downto 0) <= s_op1( C_DWG-1 downto op2_i);
        end if;
        wait for PERIOD/2;
        assert(s_expect= s_result)  report "Had error in srl-Function (behavior)"& "s_expect: " & integer'image(to_integer(unsigned(s_expect)))   & " but is " & integer'image(to_integer(unsigned(s_result))) severity error;

        -- sra
        s_shift_type<='1';
        s_shift_direction<='1';
        wait for PERIOD/2;
        s_expect <= (others => s_op1( C_DWG-1));
        if (op2_i<=0) then 
        s_expect <= s_op1;
        elsif (op2_i< C_DWG) then
        s_expect( C_DWG-1-op2_i downto 0) <= s_op1( C_DWG-1 downto op2_i);
        end if;
        wait for PERIOD/2;
        assert(s_expect= s_result) report  "Had error in sra-Function (behavior)"  & "s_expect: " & integer'image(to_integer(unsigned(s_expect))) & " but is " & integer'image(to_integer(unsigned(s_result))) severity error;

      end loop;
    end loop;
    assert false report "end of test" severity note;
    wait; --  Wait forever; this will finish the simulation.
  end process;
end behavior;