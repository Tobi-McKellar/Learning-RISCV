-- Simple fixed adder to increment PC by 4.
--
-- Authors:
--   T. D. McKellar

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;

entity programme_counter is 
    port (
        clk : in std_logic;
        reset : in std_logic;
        pc_sel : in std_logic;
        jump_address : in std_logic_vector(XLEN - 1 downto 0);
        pc_out : out std_logic_vector(XLEN - 1 downto 0)
    );
end entity programme_counter;

architecture behavioural of programme_counter is

    signal s_pc_out : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    signal s_pc_in : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
begin


    update_pc : process (clk) is
    begin
        if rising_edge(clk) then
            if reset = '1' then
                s_pc_out <= (others => '0');
            else
                if pc_sel = '0' then
                    s_pc_out <= std_logic_vector(unsigned(s_pc_in) + to_unsigned(4, s_pc_in'length));
                else
                    s_pc_out <= jump_address;
                end if;
            end if;
        end if;
    end process update_pc;
   
    s_pc_in <= s_pc_out;
    pc_out <= s_pc_out;
end architecture;