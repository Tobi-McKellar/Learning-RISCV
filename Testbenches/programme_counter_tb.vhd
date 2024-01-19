-- A basic testbench for add4.vhd. 
--
-- Authors:
--   T. D. McKellar

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.config.all;

entity programme_counter_tb is
end entity programme_counter_tb;

architecture test of programme_counter_tb is
  component programme_counter is
    port (
        clk : in std_logic;
        reset : in std_logic;
        pc_sel : in std_logic;
        jump_address : in std_logic_vector(XLEN - 1 downto 0);
        pc_out : out std_logic_vector(XLEN - 1 downto 0)
    );
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal pc_sel : std_logic := '0';
    signal jump_address : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    signal pc_out : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    signal simDone : boolean := false;

begin

    programme_counter_inst : programme_counter
        port map (
            clk => clk,
            reset => reset,
            pc_sel => pc_sel,
            jump_address => jump_address,
            pc_out => pc_out
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
        jump_address <= X"DEADBEEF";
        pc_sel <= '1';
        wait for CLK_PERIOD;
        pc_sel <= '0';
        wait for 20*CLK_PERIOD;
        simdone <= true;
        wait;
    end process;

end architecture test;
