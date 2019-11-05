library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity signExtend is
port
(
	entrada : in std_logic_vector(15 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end signExtend;

architecture arch of signExtend is
begin
	process (entrada)
	begin
		salida <= "0000000000000000" & entrada;
	end process;
end arch;
