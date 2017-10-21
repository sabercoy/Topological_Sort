with Ada.Text_IO; use Ada.Text_io;
with Parent; use Parent; 
with MakeInteger, MakeName; use MakeInteger, MakeName;

procedure Main is

	type Stack_Ptr is access AbstractStack;
	GenericStack: Stack_Ptr := new AbstractStack;
	
	NewInteger, NewName, GenericPt: AbstractStackElementPtr;
	
	A: array(1..3) of Stack_Ptr := (others => null);
	
begin
	A(1) := GenericStack;
	A(2) := GenericStack;

	NewInteger := new IntegerType'(AbstractStackElement with 5);
	push(A(1), NewInteger);
	
	NewInteger := new IntegerType'(AbstractStackElement with 7);
	push(A(1), NewInteger);
	
	NewName := new NameType'(AbstractStackElement with "Betty");
	push(A(1), NewName);
	
	for i in 1..StackSize(GenericStack.all) loop
		GenericPt := pop(GenericStack);
		if GenericPt.all in IntegerType then
			print(IntegerType'Class(GenericPt.all));
		elsif GenericPt.all in NameType then
			print(NameType'Class(GenericPt.all));
		end if;
		new_line;
	end loop;
end Main;