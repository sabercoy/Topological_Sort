with gTopoSort;
with Ada.Text_IO; use Ada.Text_IO;
with Parent; use Parent;
with MakeInteger; use MakeInteger;
with MakeName; use MakeName;
with MakeCar; use MakeCar;
with MakeFood; use MakeFood;
with MakePerson; use MakePerson;

procedure usegTopoSort is

	subtype str1 is String(1..1);
	subtype str8 is String(1..8);
	subtype str5 is String(1..5);
	subtype str17 is String(1..17);
	
	procedure IntegerPut(x: str1) is
		Output: File_Type;
	begin
		Open(Output, Append_File, "Temp_Output.txt");
		Ada.Text_IO.Put(Output, x);
		Close(Output);
	end;
	
	procedure NamePut(x: str5) is
		Output: File_Type;
	begin
		Open(Output, Append_File, "Temp_Output.txt");
		Ada.Text_IO.Put(Output, x);
		Close(Output);
	end;
	
	procedure OtherPut(x: str17) is
		Output: File_Type;
	begin
		Open(Output, Append_File, "Temp_Output.txt");
		Ada.Text_IO.Put(Output, "(");
		Ada.Text_IO.Put(Output, x);
		Ada.Text_IO.Put(Output, ")");
		Close(Output);
	end;
	
	function getIntegerInfo(X: ASEPtr) return str1 is
		s: String := getInteger(IntegerType'Class(X.all))'Image;
		s1: str1;
	begin
		s1(1) := s(2);
		return s1;
	end getIntegerInfo;
	
	function getNameInfo(X: ASEPtr) return str5 is
	begin
		return getName(NameType'Class(X.all));
	end getNameInfo;
	
	function getOtherInfo(X: ASEPtr) return str17 is
		OFields: str17 := "        ,        ";
	begin
		if X.all in Car then
			declare
				OField1: str5 := getCarType(Car'Class(X.all));
				OField2: str1;
				s: String := getCarDoors(Car'Class(X.all))'Image;
			begin
				OField2(1) := s(2);
				for n in 1..5 loop
					OFields(n) := OField1(n);
				end loop;
				OFields(10) := OField2(1);
			end;
		elsif X.all in Food then
			declare
				OField1: str8 := getFoodType(Food'Class(X.all));
				OField2: str5 := "     ";
				s: String := getCalories(Food'Class(X.all))'Image;
			begin
				for i in 1..4 loop
					OField2(i) := s(i + 1);
				end loop;
				OField2(2) := OField2(3); OField2(3) := '.';
				for n in 1..8 loop
					OFields(n) := OField1(n);
				end loop;
				for n in 1..5 loop
					OFields(n + 9) := OField2(n);
				end loop;
				end;
		elsif X.all in Person then
			declare
				OField1: str8 := getPersonType(Person'Class(X.all));
				OField2: str8 := getPersonClass(Person'Class(X.all));
			begin
				for n in 1..8 loop
					OFields(n) := OField1(n);
					OFields(n + 9) := OField2(n);
				end loop;
			end;
		end if;		
		return OFields;
	end getOtherInfo;

	package DataSet1 is new gTopoSort(str1, "D1 Input.txt", "D1 Output.txt", getIntegerInfo, IntegerPut);
	use DataSet1;
	
	package DataSet2 is new gTopoSort(str1, "D2 Input.txt", "D2 Output.txt", getIntegerInfo, IntegerPut);
	use DataSet2;
	
	package DataSet3 is new gTopoSort(str5, "B1 Input.txt", "B1 Output.txt", getNameInfo, NamePut);
	use DataSet3;
	
	package DataSet4 is new gTopoSort(str5, "B2 Input.txt", "B2 Output.txt", getNameInfo, NamePut);
	use DataSet4;
	
	package DataSet5 is new gTopoSort(str17, "B3 Input.txt", "B3 Output.txt", getOtherInfo, OtherPut);
	use DataSet5;

	package DataSet6 is new gTopoSort(str17, "B4 Input.txt", "B4 Output.txt", getOtherInfo, OtherPut);
	use DataSet6;
	
begin
	null;
end usegTopoSort;