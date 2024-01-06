-- Maps address space.
--
-- Author: 
--   J. L. Hay
--   L. R. Henderson
--   T. D. McKellar


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package memory_map is

    constant PC_ADDR : integer := 16;

    constant X0_ADDR  : integer := 0;
    constant X1_ADDR  : integer := 1;
    constant X2_ADDR  : integer := 2;
    constant X3_ADDR  : integer := 3;
    constant X4_ADDR  : integer := 4;
    constant X5_ADDR  : integer := 5;
    constant X6_ADDR  : integer := 6;
    constant X7_ADDR  : integer := 7;
    constant X8_ADDR  : integer := 8;
    constant X9_ADDR  : integer := 9;
    constant X10_ADDR : integer := 10;
    constant X11_ADDR : integer := 11;
    constant X12_ADDR : integer := 12;
    constant X13_ADDR : integer := 13;
    constant X14_ADDR : integer := 14;
    constant X15_ADDR : integer := 15;

end package;