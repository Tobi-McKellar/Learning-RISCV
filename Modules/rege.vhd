-- Register
--
-- Authors:
--   T. D. McKellar
--   J. L. Hay
--   L. R. Henderson


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;


entity rege is
    generic(
        REG_WIDTH   : integer := XLEN
    );
    port(
        clk : in std_logic;
        rst : in std_logic; -- Async reset
        r_en: in std_logic;
        w_en: in std_logic;
        din : in std_logic_vector(REG_WIDTH-1 downto 0);
        dout: out std_logic_vector(REG_WIDTH-1 downto 0)
    );
end entity rege;


architecture rtl of rege is
    signal s_data : std_logic_vector(REG_WIDTH-1 downto 0) := (others => '0');
    signal s_dout : std_logic_vector(REG_WIDTH-1 downto 0) := (others => '0');
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- if rst = RESET_STATE then
            --     dout <= (others => '0');
            -- else
            --     dout <= s_data;
            --     if w_en = '1' then
            --         s_data <= din;
            --     end if;
            -- end if;
            s_dout <= din;
            -- dout <= din;
        end if;
    end process;
    dout <= s_dout;
end architecture rtl;