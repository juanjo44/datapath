library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity MUX4 is
port
(
	enable : in std_logic_vector(1 downto 0);
	A, B, C, D : in std_logic_vector(7 downto 0);
	salida : out std_logic_vector(7 downto 0)
);
end MUX4;

architecture archMUX4 of MUX4 is
begin
	process (enable)
	begin
		if (enable = "00") then
			salida <= A;
		elsif (enable = "01") then
			salida <= B;
		elsif (enable = "10") then
			salida <= C;
		elsif (enable = "11") then
			salida <= D;
		end if;
	end process;
end archMUX4;