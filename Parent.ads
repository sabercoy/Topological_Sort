package Parent is
	type AbstractStack is limited private;
	type ASE is tagged private;
	type ASEPtr is
		access all ASE'Class;
		
	procedure push(Stack: access AbstractStack; Y: ASEPtr);
	function pop(Stack: access AbstractStack) return ASEPtr;
	function StackSize(Stack: AbstractStack) return integer;
	
	private
		type ASE is tagged
			record
				Next: ASEPtr;
			end record;
		
		type AbstractStack is limited
			record
				Count: integer := 0;
				Top: ASEPtr := null;
			end record;
end Parent;
				