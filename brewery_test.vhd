
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY brewery_test IS
END brewery_test;
 
ARCHITECTURE behavior OF brewery_test IS 
 
 
    COMPONENT brewery
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         cash : IN  std_logic;
         progress : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal cash : std_logic := '0';

 	--Outputs
   signal progress : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: brewery PORT MAP (
          clk => clk,
          reset => reset,
          cash => cash,
          progress => progress
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   stim_proc: process
   begin		
		reset<='1'; cash<='0'; wait for clk_period*5; 
		
		reset<='1'; cash<='1'; wait for clk_period*5;  
		
		reset<='1'; cash<='0'; wait for clk_period*5; 

		reset<='0'; cash<='1'; wait for clk_period*40; --default scenario
		
		reset<='0'; cash<='0'; wait for clk_period*5;
	assert false severity failure;
   end process;

END;
