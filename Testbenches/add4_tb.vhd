-- A basic testbench for add4.vhd. 
--
-- Authors:
--   T. D. McKellar

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;

entity add4_tb is
end entity add4_tb;

architecture test of add4_tb is
  component add4 is
    port (
        clk : in std_logic;
        reset : in std_logic;
        pc : in std_logic_vector(XLEN - 1 downto 0);
        pc_plus_4 : out std_logic_vector(XLEN - 1 downto 0)
    );
    end component;

    component reg is
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
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal pc : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    signal pc_plus_4 : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    signal flip_flop : std_logic_vector(XLEN - 1 downto 0) := (others => '0');

    signal simDone : boolean := false;

begin

    add4_inst : add4
        port map (
        clk => clk,
        reset => reset,
        pc => pc,
        pc_plus_4 => pc_plus_4
        );


    clk_gen : process is
    begin
        wait for CLK_PERIOD/2;
        clk <= not clk;
        if simDone then
            wait;
        end if;
    end process;

    test_process : process is 
    begin
        reset <= RESET_STATE;
        wait for CLK_PERIOD;
        reset <= not RESET_STATE;
        wait for 20*CLK_PERIOD;
        reset <= RESET_STATE;
        wait for CLK_PERIOD;
        reset <= not RESET_STATE;
        wait for 20*CLK_PERIOD;
        pc <= X"11111110";
        wait for 20*CLK_PERIOD;
        simdone <= true;
        wait;
    end process;

    flip_flop <= pc_plus_4;
    pc <= flip_flop;
end architecture test;
