-- Program memory
--
-- Authors:
--   L. R. Henderson
--   T. D. McKellar
--   J. L. Hay

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;

entity program_memory is
    port (
        clk        : in std_logic;
        enable     : in std_logic;
        address    : in natural range 0 to PROGRAM_MEMORY_AMOUNT;
        read_write : in std_logic; -- 1 for write, 0 for read  -- what a nerd
        data_in    : in word;
        ---
        data_out   : out word
        );
end entity;

architecture behavioral of program_memory is
    
    signal mem : program_space := (others => (others => '0')); 
begin
    process (clk) is
    begin
        if (rising_edge(clk) and enable = '1') then
            if read_write = '1' then
                mem(address) <= data_in;
            else 
                data_out <= mem(address);
            end if;
        end if;        
    end process;
end architecture behavioral;

