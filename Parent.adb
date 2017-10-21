package body Parent is
	procedure push(Stack: access AbstractStack; Y: ASEPtr) is
		Pt: ASEPtr;
	begin
		Y.Next := Stack.Top;
		Stack.Top := Y;
		Stack.Count := Stack.Count + 1;
	end push;
	
	function pop(Stack: access AbstractStack) return ASEPtr is
		Pt: ASEPtr;
	begin
		if Stack.Top = null then
			return null;
		end if;
		Stack.Count := Stack.Count - 1;
		Pt := Stack.Top;
		Stack.Top := Stack.Top.Next;
		return Pt;
	end pop;
	
	function StackSize(Stack: AbstractStack) return integer is
	begin
		return Stack.Count;
	end StackSize;
end Parent;