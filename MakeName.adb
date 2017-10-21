with Ada.Text_IO; use Ada.Text_IO;
with Parent;

package body MakeName is
		
	procedure PrintString5(str: string5) is
	begin
		for i in 1..5 loop
			put(str(i));
		end loop;
	end PrintString5;
		
	procedure print(aName: in NameType) is
	begin
		PrintString5(aName.charValue);
	end print;
	
	function getName(aName: NameType) return string5 is
	begin
		return aName.charValue;
	end getName;
	
end MakeName;