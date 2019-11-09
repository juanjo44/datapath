library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity MUX25Bits is
port
(
	enable : in std_logic;--_vector(1 downto 0);
	A, B : in std_logic_vector(4 downto 0);
	salida : out std_logic_vector(4 downto 0)
);
end MUX25Bits;

architecture archMUX2 of MUX25Bits is
begin
	process (enable)
	begin
		if (enable = '0') then
			salida <= A;
		else
			salida <= B;
		end if;
	end process;
end archMUX2;