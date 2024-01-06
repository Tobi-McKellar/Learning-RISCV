-- Project configuration
--
-- Contains constants and types pertinent to the entire project development.
--
-- Authors:
--   T. D. McKellar
--   J. L. Hay
--   L. R. Henderson


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package config is

    -- type address_record is record
    --     address_start : unsigned; -- memory address
    --     address_length: unsigned; -- length of the space in bytes
    -- end record address_record;

    -- 
    -- 0xA0 -> uart_1_input
    -- 0xA1 -> uart_1_output
    -- 0xA2 -> 
    --
    -- (When address space is defined we would like to map component outputs and inputs in a 
    -- consistent matter. It would be nice to simply refer to component labels rather than
    -- literal adresses and reduce boilerplate/redundant definitions)

    -- Instruction len
    constant XLEN : natural := 32;

    constant RESET_STATE : std_logic := '1';

    subtype word is std_logic_vector(XLEN-1 downto 0);
    subtype data_word is std_logic_vector(7 downto 0);
    constant NUM_REGISTERS : integer := 16; -- Does not count P.C.

    
    -- Unit in bytes
    constant DATA_MEMORY_AMOUNT : natural := 2048;
    constant PROGRAM_MEMORY_AMOUNT : natural := 2048;
    
    constant TOTAL_AVAILABLE_MEMORY : natural := 4096; --[TODO] reference

    -- assert DATA_MEMORY_AMOUNT+PROGRAM_MEMORY_AMOUNT <= TOTAL_AVAILABLE_MEMORY 
    --     report "ACHTUNG!: Too much memory allocated."  
    --     severity error;


    constant ADDRESS_SPACE_LENGTH : natural := DATA_MEMORY_AMOUNT;
    
    type address_space is array(ADDRESS_SPACE_LENGTH-1 downto 0) of data_word; -- Address space?
    type program_space is array(PROGRAM_MEMORY_AMOUNT-1 downto 0) of word; -- Address space?
    

    -- constant uart : address_record := (
    --     address_start =>  1023; -- 1023
    --     address_length =>  5;   -- bytes
    -- );

    




    constant OPCODE_LENGTH : integer := 7;
    -- subtype opcode is std_logic_vector(OPCODE_LENGTH-1 downto 0); -- Consider??

    constant OP_LUI    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110111";
    constant OP_AUIPC  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010111";
    constant OP_JAL    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1101111";
    constant OP_JALR   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100111";
    constant OP_BEQ    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_BNE    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_BLT    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_BGE    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_BLTU   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_BGEU   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1100011";
    constant OP_LB     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0000011";
    constant OP_LH     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0000011";
    constant OP_LW     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0000011";
    constant OP_LBU    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0000011";
    constant OP_LHU    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0000011";
    constant OP_SB     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0100011";
    constant OP_SH     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0100011";
    constant OP_SW     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0100011";
    constant OP_ADDI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_SLTI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_SLTIU  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_XORI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_ORI    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_ANDI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_SLLI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_SRLI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_SRAI   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0010011";
    constant OP_ADD    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SUB    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SLL    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SLT    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SLTU   : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_XOR    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SRL    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_SRA    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_OR     : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_AND    : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0110011";
    constant OP_FENCE  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0001111";
    -- constant OP_FENCE  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "0001111"; -- technically opfence.i
    constant OP_ECALL  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011";
    constant OP_EBREAK : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011"; 
    constant OP_CSRRW  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011";
    constant OP_CSRRS  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011";
    constant OP_CSRRC  : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011";
    constant OP_CSRRWI : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011"; 
    constant OP_CSRRSI : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011"; 
    constant OP_CSRRCI : std_logic_vector(OPCODE_LENGTH-1 downto 0) := "1110011";

    constant ALUCODE_LENGTH : integer := 3;
    constant ALU_ADD : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "000";
    constant ALU_SUB : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "001";
    constant ALU_AND : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "010";
    constant ALU_OR  : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "011";
    constant ALU_XOR : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "100";
    constant ALU_SLL : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "101";
    constant ALU_SRL : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "110";
    constant ALU_SRA : std_logic_vector(ALUCODE_LENGTH-1 downto 0) := "111";


    -- simulation configs
    constant CLK_PERIOD : time := 1 us;

end package;    