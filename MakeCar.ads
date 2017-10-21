with Parent;

package MakeCar is
	
	subtype string5 is String(1..5);
	
	type Car is new Parent.ASE with record
		carType: string5;
		numDoors: integer;
	end record;
	
	procedure print(aCar: in Car);
	
	function getCarType(aCar: Car) return string5;
	function getCarDoors(aCar: Car) return integer;
	
end MakeCar;