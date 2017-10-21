with Ada.Text_IO; use Ada.Text_IO;
with Parent;

package body MakePerson is
		
	procedure PrintString8(str: string8) is
	begin
		for i in 1..8 loop
			put(str(i));
		end loop;
	end PrintString8;
	
	procedure print(aPerson: in Person) is
	begin
		put("The person type is : "); PrintString8(aPerson.personType); put(", ");
		put("the person class is: "); PrintString8(aPerson.personClass);
	end print;
	
	function getPersonType(aPerson: Person) return string8 is
	begin
		return aPerson.personType;
	end getPersonType;
	
	function getPersonClass(aPerson: Person) return string8 is
	begin
		return aPerson.personClass;
	end getPersonClass;
	
end MakePerson;