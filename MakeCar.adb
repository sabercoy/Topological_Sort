with Ada.Text_IO; use Ada.Text_IO;
with Parent;

package body MakeCar is
		
	package IIO is new Integer_IO(integer); use IIO;
	
	procedure PrintString5(str: string5) is
	begin
		for i in 1..5 loop
			put(str(i));
		end loop;
	end PrintString5;
	
	procedure print(aCar: in Car) is
	begin
		put("The car type is : "); PrintString5(aCar.CarType); put(", ");
		put("the number of doors is: "); IIO.put(aCar.numDoors, 0);
	end print;
	
	function getCarType(aCar: Car) return string5 is
	begin
		return aCar.carType;
	end getCarType;
	
	function getCarDoors(aCar: Car) return integer is
	begin
		return aCar.numDoors;
	end getCarDoors;
	
end MakeCar;