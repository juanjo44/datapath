library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shiftLeft2Abajo is
port
(
	entrada : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
);

end shiftLeft2Abajo;

architecture arch of shiftLeft2Abajo is
begin
	process (entrada)
	begin
		salida(31 downto 2) <= entrada(29 downto 0);
		salida(1 downto 0) <= "00";
	end process;
end arch;