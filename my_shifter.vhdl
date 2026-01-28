-- Laboratory GdTi solutions/versuch8
-- Winter Semester 25/26
-- Group Details
-- Lab Date: 28.01.2026
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use work.CONSTANT_Package.ALL;

entity my_shifter is
    generic(
        G_DATA_WIDTH : integer := C_DWG
    );
    port(
        -- begin solution:
        p_op1        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        p_op2        : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        p_shift_type : in  std_logic;
        p_shift_dir  : in  std_logic;
        p_res        : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)
        -- end solution!!
    );
end entity;

architecture behavior of my_shifter is
 signal s_shamtInt : integer range 0 to (2**(integer(log2(real(G_DATA_WIDTH)))));
 signal s_tmp_val :  std_logic:='0';
begin
    s_shamtInt <= to_integer(unsigned(p_op2(integer(log2(real(G_DATA_WIDTH))) - 1 downto 0)));
    -- begin solution:
    process(p_op1, p_shift_type, p_shift_dir, s_shamtInt)
    begin
        if p_shift_dir = '0' then
            p_res <= std_logic_vector(shift_left(unsigned(p_op1), s_shamtInt));
        else
            if p_shift_type = '0' then
                p_res <= std_logic_vector(shift_right(unsigned(p_op1), s_shamtInt));
            else
                p_res <= std_logic_vector(shift_right(signed(p_op1), s_shamtInt));
            end if;
        end if;
    end process;
    -- end solution!!
end architecture behavior;

architecture dataflow of my_shifter is

 signal s_shamtInt : integer range 0 to (2**(integer(log2(real(G_DATA_WIDTH)))));
 signal s_res :      std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '0');

begin
    -- begin solution:
    s_shamtInt <= to_integer(unsigned(p_op2(integer(log2(real(G_DATA_WIDTH))) - 1 downto 0)));
    s_res <= std_logic_vector(shift_left(unsigned(p_op1), s_shamtInt)) when p_shift_dir = '0' else
             std_logic_vector(shift_right(unsigned(p_op1), s_shamtInt)) when (p_shift_dir = '1' and p_shift_type = '0') else
             std_logic_vector(shift_right(signed(p_op1), s_shamtInt));
    -- end solution!!
    P_RES <= s_res;
        
end architecture dataflow;
