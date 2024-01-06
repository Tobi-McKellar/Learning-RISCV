-- Simple fixed adder to increment PC by 4.
--
-- Authors:
--   T. D. McKellar

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;

entity add4 is 
    port (
        clk : in std_logic;
        reset : in std_logic;
        pc : in std_logic_vector(XLEN - 1 downto 0);
        pc_plus_4 : out std_logic_vector(XLEN - 1 downto 0)
    );
end entity add4;

architecture behavioural of add4 is


    signal s_pc_plus_4 : std_logic_vector(XLEN - 1 downto 0) := (others => '0');

begin
    update_pc : process (clk) is
    begin
        if rising_edge(clk) then
            if reset = RESET_STATE then
                pc_plus_4 <= (others => '0');
            else
                pc_plus_4 <= std_logic_vector(to_unsigned(to_integer(unsigned(pc) + 4), pc'length));
            end if;
        end if;
    end process update_pc;
end architecture behavioural;