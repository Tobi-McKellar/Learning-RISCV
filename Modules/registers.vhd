-- Registers
--
-- Authors:
--   T. D. McKellar
--   J. L. Hay
--   L. R. Henderson


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config;


entity registers is
    generic (
        NUM_REGISTERS : integer := config.NUM_REGISTERS;
        REG_WIDTH     : integer := config.XLEN
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        r_en  : in std_logic_vector(REG_WIDTH-1 downto 0);
        w_en  : in std_logic_vector(REG_WIDTH-1 downto 0);
        din : in std_logic_vector(REG_WIDTH-1 downto 0);
        dout: out std_logic_vector(REG_WIDTH-1 downto 0);
        addr: in integer range 0 to NUM_REGISTERS-1
    );
end entity registers;

architecture structural of registers is
    
begin
    register_0 : entity work.rege
        generic map (
            REG_WIDTH => REG_WIDTH
        )
        port map (
            clk => clk,
            rst => rst,
            r_en  => r_en(0),
            w_en  => w_en(0),
            din => X"00000000",
            dout => dout
        );

    registers_1_16 : for i in 1 to NUM_REGISTERS - 1 generate
        reg : entity work.rege
            generic map (
                REG_WIDTH => REG_WIDTH
            )
            port map (
                clk => clk,
                rst => rst,
                r_en => r_en(i),
                w_en => w_en(i),
                din => din,
                dout => dout
            );
    end generate;
    
end architecture structural;