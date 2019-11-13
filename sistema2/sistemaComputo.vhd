library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
entity sistemaComputo is
port
(
  clk : in std_logic;
  address,
  writeData: in  std_logic_vector (31 downto 0);
  memRead, memWrite : in std_logic;
  dataOut: out std_logic_vector (31 downto 0)
);

end sistemaComputo;