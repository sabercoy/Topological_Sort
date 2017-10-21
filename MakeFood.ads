with Parent;

package MakeFood is
	
	subtype string8 is String(1..8);
	
	type Food is new Parent.ASE with record
		foodType: string8;
		calories: float;
	end record;
	
	procedure print(aFood: in Food);
	
	function getFoodType(aFood: Food) return string8;
	function getCalories(aFood: Food) return float;
	
end MakeFood;