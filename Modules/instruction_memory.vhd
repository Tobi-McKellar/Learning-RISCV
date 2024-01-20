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

-- Because this willl likely be stored in block ram,
-- there will be no need for a reset signal. This is 
-- because block ram cannot be reset.

entity instruction_memory is
    port (
        clk        : in std_logic;
        enable     : in std_logic;
        address    : in natural range 0 to PROGRAM_MEMORY_AMOUNT;
        data_out   : out word
        );
end entity;

architecture behavioral of instruction_memory is
    
    signal mem : instruction_space := (others => (others => '0')); 
begin
    process (clk) is
    begin
        if (rising_edge(clk) and enable = '1') then
                data_out <= mem(address);
            end if;
        end if;        
    end process;
end architecture behavioral;

