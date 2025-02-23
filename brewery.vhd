--Date: 16.01.2024

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 



entity brewery is
	port ( clk, reset : in std_logic; 
			cash : in std_logic; --wejscie
			progress : out std_logic); --wyjscie
end brewery;

architecture Behavioral of brewery is

type STATES is (transit,nowork,cleaning, capping, packaging, brewing); --enum type for all states of state machine
signal state,next_state : STATES; --state and next_state for readibility in testbench
signal beer_level : unsigned(3 downto 0); 
signal storage_room : unsigned(3 downto 0);  

begin


reg:process(clk,reset) 
begin
	if(reset='1') then		--high reset
		state <=nowork;		
	elsif(clk'event and clk='1') then	--awaits clk signal to choose next state
		state<=next_state;
	end if;
end process reg;

brewery:process(state, cash)

begin
	next_state<=state;
	case state is
		when nowork=>
			if(cash='1') then
				next_state<=transit;
			end if;
		when transit=>
			if (cash='0') then
				next_state<=nowork;
			else
				next_state<=cleaning;
			end if;
		when cleaning=>		--cleaning before brewing starts
			if(cash='1') then
				next_state <= brewing;

			elsif(cash='0') then
				next_state <= nowork;
			end if;
		when brewing=>			
			if(cash='1') then
				next_state<=capping;
			else
				next_state<= nowork;
			end if;
		when capping=>			
			if(cash='1' and beer_level/="0000") then
				next_state<=packaging;
			elsif(cash='1' and beer_level="0000") then
				next_state<= brewing;
			end if;
			if(cash='1' and storage_room/="0000") then
				next_state<= packaging;
			elsif(cash='1' and storage_room="0000") then
				next_state<=transit;
			elsif(cash='0') then
				next_state<=nowork;
			end if;

		when packaging=>
			if(cash='1') then
				next_state<=capping;			--capping until beer_level equals zero
			else
				next_state<=nowork;
			end if;
			end case;

end process brewery;


counter:process(clk,reset)

begin
	if reset='1' then
		storage_room <="0000";
	elsif(clk'event and clk = '1') then
			if(state=capping and storage_room /= "0000") then
				storage_room<= storage_room-1;

			end if;
			
			elsif(state=transit) then
				storage_room<="1111";

			end if;
			
end process counter;

counter2:process(clk,reset)
begin
	if reset='1' then
		beer_level<="0000";
	elsif(clk'event and clk = '1') then

			if(state=capping and beer_level /="0000") then
				beer_level<=beer_level-1;
			end if;
			
			elsif(state=brewing) then
				beer_level<="1111";
			end if;
			
end process counter2;

progress <= '1' when state = packaging else '0'; --update values for progress


end Behavioral;
