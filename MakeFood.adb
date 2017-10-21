with Ada.Text_IO; use Ada.Text_IO;
with Parent;

package body MakeFood is

	package FIO is new Float_IO(float); use FIO;
	
	procedure PrintString8(str: string8) is
	begin
		for i in 1..8 loop
			put(str(i));
		end loop;
	end PrintString8;
	
	procedure print(aFood: in Food) is
	begin
		put("The food type is : "); PrintString8(aFood.foodType); put(", ");
		put("the number of calories is: "); FIO.put(aFood.calories);
	end print;
	
	function getFoodType(aFood: Food) return string8 is
	begin
		return aFood.foodType;
	end getFoodType;
	
	function getCalories(aFood: Food) return float is
	begin
		return aFood.calories;
	end getCalories;
	
end MakeFood;