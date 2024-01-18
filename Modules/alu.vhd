-- ALU
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

entity alu is
    generic (
        ALU_WIDTH : integer := XLEN
    );
    port (
        a       : in  std_logic_vector(ALU_WIDTH-1 downto 0);
        b       : in  std_logic_vector(ALU_WIDTH-1 downto 0);
        opcode  : in  std_logic_vector(ALUCODE_LENGTH-1 downto 0);
        equal   : out std_logic;
        less    : out std_logic;
        overflow: out std_logic;

        result  : out std_logic_vector(ALU_WIDTH-1 downto 0);
        zero    : out std_logic
    );
end entity alu;

architecture behavioral of alu is

    procedure set_zero
        (signal result_p : in std_logic_vector(ALU_WIDTH-1 downto 0);
        signal zero_p : out std_logic) is
    begin
        if result_p = (result_p'range => '0') then
            zero_p <= '1';
        else
            zero_p <= '0';
        end if;
    end procedure set_zero;

    signal s_result : std_logic_vector(ALU_WIDTH-1 downto 0);


begin
    process (a, b, opcode)
    begin
        case opcode is

            when ALU_ADD =>
                s_result <= std_logic_vector(unsigned(a) + unsigned(b));
                set_zero(s_result, zero);

            when ALU_SUB =>
                s_result <= std_logic_vector(unsigned(a) - unsigned(b));
                set_zero(s_result, zero);

            when ALU_AND =>
                s_result <= a and b;
                set_zero(s_result, zero);

            when ALU_OR =>
                s_result <= a or b;
                set_zero(s_result, zero);

            when ALU_XOR =>
                s_result <= a xor b;
                set_zero(s_result, zero);

            when ALU_SLL =>
                s_result <= std_logic_vector(shift_left(unsigned(a), to_integer(unsigned(b(24 downto 20))))); -- Shift amount is stored in bits 24-20 of the instruction
                set_zero(s_result, zero);                                                                     -- See p14 of https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

            when ALU_SRL =>
                s_result <= std_logic_vector(shift_right(unsigned(a), to_integer(unsigned(b(24 downto 20)))));
                set_zero(s_result, zero);

            when ALU_SRA =>
                s_result <= std_logic_vector(shift_right(signed(a), to_integer(unsigned(b(24 downto 20)))));
                set_zero(s_result, zero);

            when others =>
                s_result <= (others => 'X');
                zero   <= 'X';

        end case;
        
    end process;
    result <= s_result;
end architecture behavioral;

