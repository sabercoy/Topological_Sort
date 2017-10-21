with Parent;

package MakeName is

	subtype string5 is String(1..5);
	
	type NameType is new Parent.ASE with record
		charValue: string5;
	end record;
	
	procedure print(aName: in NameType);
	
	function getName(aName: NameType) return string5;
	
end MakeName;