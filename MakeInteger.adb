with Ada.Text_IO; use Ada.Text_IO;
with Parent;

package body MakeInteger is

	package IIO is new Integer_IO(integer); use IIO;
		
	procedure print(aInteger: in IntegerType) is
	begin
		IIO.put(aInteger.integerValue, 0);
	end print;
	
	function getInteger(aInteger: IntegerType) return integer is
	begin
		return aInteger.integerValue;
	end getInteger;
	
end MakeInteger;
