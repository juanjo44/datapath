library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity registro is
port
(
  clk,
  clr: in  std_logic;
  d:   in  std_logic_vector (31 downto 0);
  q:   out std_logic_vector (31 downto 0)
);
end registro;


architecture arch of registro is
begin
  process ( clk, clr )
  begin
    if ( clr = '1' ) then
      q <= ( others => '0' );
    elsif ( clk'event and clk = '1' ) then
      q <= d;
    end if;
  end process;
end arch;