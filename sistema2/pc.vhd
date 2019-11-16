library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pc is
port
(
  enable, clk: in  std_logic;
  entrada:   in  std_logic_vector (31 downto 0);
  salida:   out std_logic_vector (31 downto 0)
);
end pc;


architecture arch of pc is
begin
  process ( enable, entrada, clk )
  begin
	if ( clk'event and clk = '1' and enable = '1' ) then
		salida <= entrada;
	end if;
  end process;
end arch;