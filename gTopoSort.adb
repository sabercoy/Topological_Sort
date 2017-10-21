with Parent; use Parent;
with MakeInteger; use MakeInteger;
with MakeName; use MakeName;
with MakeCar; use MakeCar;
with MakeFood; use MakeFood;
with MakePerson; use MakePerson;
with Ada.Text_IO; use Ada.Text_IO;
with Unchecked_Conversion;
with Ada.Unchecked_Deallocation;

package body gTopoSort is

	subtype String1 is String(1..1);
	subtype String5 is String(1..5);
	subtype String8 is String(1..8);
	subtype String17 is String(1..17);

	function Convert is new Unchecked_Conversion(String, SortType);		--conversions to go from txt file to storage
	function StrToStr5 is new Unchecked_Conversion(String, String5);
	function Str5ToSort is new Unchecked_Conversion(String5, SortType);
	function Str1ToSort is new Unchecked_Conversion(String1, SortType);
	function StrToStr8 is new Unchecked_Conversion(String, String8);
	function Str8ToStr5 is new Unchecked_Conversion(String8, String5);
	function Str17ToSort is new Unchecked_Conversion(String17, SortType);
	
	procedure Free is new Ada.Unchecked_Deallocation(ASE'Class, ASEPtr);
	
	type Stack_Ptr is access AbstractStack;
	NewInteger, NewName, NewCar, NewFood, NewPerson, GenericPt: ASEPtr;
	
	function getNumOfJobs return integer is		--reads and returns first line of txt file
		Input: File_Type;
		First_Line: integer;
	begin
		Open(Input, In_File, Input_File);
		
		for i in 1..1 loop
			declare
				Line: String := Get_Line(Input);
			begin
				First_Line := Integer'Value(Line);
			end;
		end loop;
		Close(Input);
		return First_Line;
	end getNumOfJobs;
	
-----------------------------------------------------------------	
	arraySize: integer := getNumOfJobs;
	TotalCount: integer := arraySize;
	JobArray: array(1..arraySize) of SortType;
	CountArray: array(1..arraySize) of integer := (others => 0);
	HeadArray: array(1..arraySize) of Stack_Ptr := (others => new AbstractStack);
	--InverseArray: array(1..arraySize) of Stack_Ptr := (others => new AbstractStack);
	QueueArray: array(0..arraySize) of SortType;
	F: integer := 0;
	R: integer := 0;
	JobType: character := 'O';
	back: integer := 1;
-----------------------------------------------------------------
	
	procedure determineJobType is
		Input: File_Type;
	begin
		Open(Input, In_File, Input_File);
		
		for i in 1..1 loop
			declare
				Skip: String := Get_Line(Input);	--skip first line
				Line2: String := Get_Line(Input);   --get the second line
			begin
				if Line2'length = 1 then		--if 1 then IntegerType
					JobType := 'I';
				elsif Line2'length = 5 then		--if 5 then NameType
					JobType := 'N';
				end if;							--else, stays 'O' for "Other"
			end;
		end loop;
		Close(Input);
	end determineJobType;
	
	
	procedure fillJobArray is			--fills array with unique values
		Input: File_Type;
		match: boolean := false;
	begin
		Open(Input, In_File, Input_File);
		
		for i in 1..1 loop							--skip the first line
			declare
				Skip: String := Get_Line(Input);
			begin
				null;
			end;
		end loop;
		
		while not End_Of_File(Input) loop
			declare
				Line: String := Get_Line(Input);
				FixedLine: SortType := Convert(Line);
			begin
				match := false;
				for i in 1..back loop				--see if already there
					if FixedLine = JobArray(i) then
						match := true;
					end if;
				end loop;
				if match = false then				--put in array if not there
					JobArray(back) := FixedLine;
					if back /= arraySize then
						back := back + 1;			--update pointer
					end if;
				end if;
			end;
		end loop;
		Close(Input);
	end fillJobArray;
	
	procedure topoSortStep1 is			--pushes onto stacks and updates count fields
		Input: File_Type;
	begin
		Open(Input, In_File, Input_File);
	
		for i in 1..1 loop							--skip the first line of txt file
			declare
				Skip: String := Get_Line(Input);
			begin
				null;
			end;
		end loop;
		
		while not End_Of_File(Input) loop
			declare
				Line1: String := Get_Line(Input);	--retrieve relations in pairs
				Line2: String := Get_Line(Input);
				str: String8 := StrToStr8(Line2);
				OType: character;
				OField1: String8;
				OField2: String8;
			begin
				for i in 1..arraySize loop
					if Convert(Line1) = JobArray(i) then		--push onto appropriate stack
						if JobType = 'N' then
							NewName := new NameType'(ASE with StrToStr5(Line2));
							push(HeadArray(i), NewName);
						elsif JobType = 'I' then
							NewInteger := new IntegerType'(ASE with Integer'Value(Line2));
							push(HeadArray(i), NewInteger);
						elsif JobType = 'O' then
							if str = "GMC     " or str = "Chevy   " or str = "Ford    " or
							   str = "Buick   " or str = "Jeep    " or str = "Dodge   " then
								OType := 'C';
							elsif str = "apple   " or str = "banana  " or
								  str = "orange  " or str = "pear    " then
								OType := 'F';
							else
								OType := 'P';
							end if;
							for j in 1..8 loop
								OField1(j) := Line2(j);
								OField2(j) := Line2(j + 9);
							end loop;
							if OType = 'C' then
								NewCar := new Car'(ASE with Str8ToStr5(OField1), Integer'Value(OField2));
								push(HeadArray(i), NewCar);
							elsif OType = 'F' then
								NewFood := new Food'(ASE with OField1, Float'Value(OField2));
								push(HeadArray(i), NewFood);
							elsif OType = 'P' then
								NewPerson := new Person'(ASE with OField1, OField2);
								push(HeadArray(i), NewPerson);
							end if;						
						end if;
					end if;
					if Convert(Line2) = JobArray(i) then		--update appropriate count field
						CountArray(i) := CountArray(i) + 1;
					end if;
				end loop;
			end;
		end loop;
		Close(Input);
	end topoSortStep1;
	
	procedure topoSortStep2 is
		tempPopValue: SortType;
		Output: File_Type;
	begin
		for i in 1..arraySize loop			--find initial 0's
			if CountArray(i) = 0 then
				R := R + 1;
				QueueArray(R) := JobArray(i); 	--put into queue
				TotalCount := TotalCount - 1;
			end if;
		end loop;
		
		while F /= R loop				--Process the queue
			F := F + 1;
			for i in 1..arraySize loop
				if QueueArray(F) = JobArray(i) then
					for k in 1..StackSize(HeadArray(i).all) loop	--loop to pop every element of stack
						GenericPt := pop(HeadArray(i));	--pop top of stack
						if GenericPt.all in IntegerType then
							tempPopValue := Str1ToSort(getInfo(GenericPt)); --identify what was popped
						elsif GenericPt.all in NameType then
							tempPopValue := Str5ToSort(getInfo(GenericPt)); --identify what was popped
						else
							tempPopValue := Str17ToSort(getInfo(GenericPt)); --identify what was popped
						end if;
						for j in 1..arraySize loop
							if tempPopValue = JobArray(j) then
								CountArray(j) := CountArray(j) - 1;			--decrement counter of what was popped
								if CountArray(j) = 0 then					--if now 0, then add to queue
									R := R + 1;
									QueueArray(R) := tempPopValue;
									TotalCount := TotalCount - 1;
								end if;
							end if;
						end loop;
						Free(GenericPt);
					end loop;
				end if;
			end loop;
		end loop;
		Create(Output, Append_File, "Temp_Output.txt");
		if TotalCount = 0 then
			put(Output, "Result of "); put(Output, Input_File); put(Output, ": "); put(Output, "SUCCESS, SOLUTION:");
			Close(Output);
			for i in 1..arraySize loop
				put(QueueArray(i));
			end loop;
		else
			put(Output, "Result of "); put(Output, Input_File); put(Output, ": "); put(Output, "FAILED, LOOP:");
			Close(Output);
			findLoop;
		end if;
		printFinal;
	end topoSortStep2;
	
	procedure findLoop is
		InverseArray: array(1..arraySize) of Stack_Ptr := (others => new AbstractStack);
		currIndex: integer := calcNewIndex;
		sortValue: SortType := JobArray(currIndex);
		loopFound: boolean := false;
	begin
		for j in 1..arraySize loop			--invert the stack into new array
			for i in 1.. StackSize(HeadArray(j).all) loop
				GenericPt := pop(HeadArray(j));
				push(InverseArray(j), GenericPt);
			end loop;
		end loop;
		
		for j in 1..arraySize loop			--make 0 where Heads are null
			if CountArray(j) /= 0 and StackSize(InverseArray(j).all) = 0 then
				CountArray(j) := 0;
			end if;
		end loop;
				
		back := 0;
		while loopFound = false loop				--follow links until loop is detected
			QueueArray(back) := sortValue;
			loopFound := checkNewEntry(sortValue);
			back := back + 1;
			if loopFound = false and StackSize(InverseArray(calcCheckIndex(sortValue)).all) /= 0 then --check see if stack empty
				GenericPt := pop(InverseArray(calcCheckIndex(sortValue)));
				if GenericPt.all in IntegerType then
					sortValue := Str1ToSort(getInfo(GenericPt));
				elsif GenericPt.all in NameType then
					sortValue := Str5ToSort(getInfo(GenericPt));
				else
					sortValue := Str17ToSort(getInfo(GenericPt));
				end if;
				Free(GenericPt);
			end if;
			if loopFound = false and StackSize(InverseArray(calcCheckIndex(sortValue)).all) = 0 then
				QueueArray(back) := sortValue;
				loopFound := checkNewEntry(sortValue);
				loopFound := true;
			end if;
		end loop;
		
	end findLoop;
	
	function calcCheckIndex(sortValue: SortType) return integer is
	begin
		for i in 1..arraySize loop
			if sortValue = JobArray(i) then
				return i;
			end if;
		end loop;
	end calcCheckIndex;
	
	function calcNewIndex return integer is
	begin
		for i in 1..arraySize loop
			if CountArray(i) /= 0 then
				return i;
			end if;
		end loop;
		return -1;
	end calcNewIndex;
	
	function checkNewEntry(checkValue: SortType) return boolean is
		match: boolean := false;
		startPrint: integer;
	begin
		for i in 0..back - 1 loop
			if checkValue = QueueArray(i) then
				match := true;
				startPrint := i;
			end if;
		end loop;
		if match = true then
			for i in startPrint..back loop
				put(QueueArray(i));
			end loop;
		end if;
		return match;
	end checkNewEntry;
	
	procedure printFinal is
		Input, Output: File_Type;
	begin
		Open(Input, In_File, "Temp_Output.txt");
		Create(Output, Out_File, Output_File);
		
		put(Output, Get_Line(Input));
		put_Line(Output, " "); put_Line(Output, "");
		
		while not End_Of_File(Input) loop
			declare
				Line: String := Get_Line(Input);
			begin
				put(Output, Line);
				put_line(Output, "");
			end;
		end loop;
		Close(Output);
		Delete(Input);
	end printFinal;
	
begin
	determineJobType;
	fillJobArray;
	topoSortStep1;
	topoSortStep2;
end gTopoSort;