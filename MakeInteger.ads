with Parent;

package MakeInteger is
	
	--subtype string1 is String(1..1);
	
	type IntegerType is new Parent.ASE with record
		integerValue: integer;
	end record;
	
	procedure print(aInteger: in IntegerType);
	
	function getInteger(aInteger: IntegerType) return integer;
	
end MakeInteger;