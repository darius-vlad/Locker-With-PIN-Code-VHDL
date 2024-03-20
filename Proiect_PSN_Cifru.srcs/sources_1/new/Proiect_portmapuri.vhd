----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2023 09:25:00 PM
-- Design Name: 
-- Module Name: Proiect_portmapuri - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Proiect_portmapuri is
Port
(start:in std_logic;
 adaugare_cifru: in std_logic;
 up:in std_logic;
 down:in std_logic;
 clk:in std_logic;
 reset:in std_logic;
 liber_ocupat: inout std_logic;
 int_cifra: out std_logic;
 an:inout std_logic_Vector(7 downto 0);
 a,b,c,d,e,f,g:out std_logic
 );
end Proiect_portmapuri;

architecture Behavioral of Proiect_portmapuri is


component UnitateControl IS
  PORT (
start: in std_logic;
        adaugare_cifru: in std_logic;
        clk:in std_logic;
        egal1,egal2,egal3:in std_logic;
        reset: in std_logic;
        liber_ocupat:inout std_logic;
        int_cifra: out std_logic;
        enb_reg1: out std_logic;
        enb_reg1v: out std_logic;
        enb_reg2: out std_logic;
        enb_reg2v: out std_logic;
        enb_reg3:out std_logic;
        enb_reg3v: out std_logic;
        reset_num15: out std_logic;
        reset_reg: out std_logic;
        reset_regv: out std_logic
      
        
         
        
    );
END component;

component comparator4biti IS
  PORT (
numar1: in std_logic_vector(3 downto 0);
        numar2: in std_logic_vector(3 downto 0);
        egal: out std_logic
 
    );
END component;

component full_display is
	port (
			clk : in std_logic;
			num1 : in std_logic_vector(3 downto 0);
			num1v : in std_logic_vector(3 downto 0);
			num2 : in std_logic_vector(3 downto 0);
			num2v : in std_logic_vector(3 downto 0);
			num3 : in std_logic_vector(3 downto 0);
			num3v : in std_logic_vector(3 downto 0);
			liber_ocupat : in std_logic;
			cat : out std_logic_vector(6 downto 0);
			an : out std_logic_vector(7 downto 0)
		  );
end  component;


component Numarator_rev_1_15 IS
	PORT(up : in std_logic;
  		down : in std_logic;
  		clk: in std_logic;
  		load : in std_logic;
  		numar : out std_logic_vector(3 downto 0));
END component;


component Registru_mem IS
  PORT (
clk: in std_logic;
        data_in: in std_logic_vector(3 downto 0);
        we: in std_logic;
        reset: in std_logic;  
        data_out: out std_logic_vector(3 downto 0)
    );
END component;



component ssdec IS
	PORT(
nr : in std_logic_vector(6 downto 0);
		anod : in std_logic_vector(7 downto 0);
		a, b, c, d, e, f, g : out std_logic);
END component;

signal auxegal1,auxegal2,auxegal3:std_logic:='0';
signal auxreg1,auxreg1v,auxreg2,auxreg2v,auxreg3,auxreg3v,auxreset_num,auxreset_reg,auxreset_regv: std_logic;
signal auxnumar:std_logic_Vector(3 downto 0);
signal auxnrreg1,auxnrreg1v,auxnrreg2,auxnrreg2v,auxnrreg3,auxnrreg3v: std_logic_Vector(3 downto 0);
signal catod:std_logic_Vector(6 downto 0);
begin
C1: UnitateControl port map(start,adaugare_cifru,clk,auxegal1,auxegal2,auxegal3,reset,liber_ocupat,int_cifra,auxreg1,auxreg1v,auxreg2,auxreg2v,auxreg3,auxreg3v,auxreset_num,auxreset_reg,auxreset_regv);
C2:Numarator_rev_1_15 port map(up,down,clk,auxreset_num,auxnumar);
Reg_mem1: Registru_mem port map(clk,auxnumar,auxreg1,auxreset_reg,auxnrreg1);
Reg_mem1v: Registru_mem port map(clk,auxnumar,auxreg1v,auxreset_regv,auxnrreg1v);
Reg_mem2: Registru_mem port map(clk,auxnumar,auxreg2,auxreset_reg,auxnrreg2);
Reg_mem2v: Registru_mem port map(clk,auxnumar,auxreg2v,auxreset_regv,auxnrreg2v);
Reg_mem3: Registru_mem port map(clk,auxnumar,auxreg3,auxreset_reg,auxnrreg3);
Reg_mem3v: Registru_mem port map(clk,auxnumar,auxreg3v,auxreset_regv,auxnrreg3v);
Comp1: comparator4biti port map(auxnrreg1,auxnrreg1v,auxegal1);
comp2: comparator4biti port map(auxnrreg2,auxnrreg2v,auxegal2);
comp3: comparator4biti port map(auxnrreg3,auxnrreg3v,auxegal3);
disp: full_display port map(clk,auxnrreg1,auxnrreg1v,auxnrreg2,auxnrreg2v,auxnrreg3,auxnrreg3v,liber_ocupat,catod,an);
dec1: ssdec port map(catod,an,a,b,c,d,e,f,g);


end Behavioral;






