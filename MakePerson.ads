with Parent;

package MakePerson is
	
	subtype string8 is String(1..8);
	
	type Person is new Parent.ASE with record
		personType: string8;
		personClass: string8;
	end record;
	
	procedure print(aPerson: in Person);
	
	function getPersonType(aPerson: Person) return string8;
	function getPersonClass(aPerson: Person) return string8;
	
end MakePerson;