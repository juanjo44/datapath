library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shiftLeft2 is
port
(
	cuatroMasSignificativo : in std_logic_vector(3 downto 0);
	entrada : in std_logic_vector(25 downto 0);
	salida : out std_logic_vector(31 downto 0)
);

end shiftLeft2;

architecture arch of shiftLeft2 is
begin
	process (cuatroMasSignificativo, entrada)
	begin
		salida(31 downto 28) <= cuatroMasSignificativo;
		salida(27 downto 26) <= "00";
		salida(25 downto 2) <= entrada(23 downto 0);
		salida(1 downto 0) <= "00";
		
	end process;
end arch;