program sortArray;

type 
	arrayType = array[1..20] of integer;

var
	myArray : arrayType;
	count : integer;

(* var indicates pass by ref *)
procedure printy(var a : arrayType; size : integer);
var
	i : integer;
begin
	for i := 1 to size do
	begin
		write(a[i]);
		write(' ');
	end;
	writeln('');
end;

(* I know bubblesort is 0(n^2) which is super slow...but it works! *)
procedure bubbleSort(var a : arrayType; size : integer);
var 
	i, j, temp: integer;
begin
	for i := size downto 1 do
		for j := 2 to i do
			if (a[j - 1] > a[j]) then
			begin
				temp := a[j - 1];
				a[j - 1] := a[j];
				a[j] := temp;
			end;
end;

begin
	writeln('Please enter integers separated by a space: ');
	writeln('Enter "00" followed by enter if you would like to stop entering numbers');
	for count := 1 to 20 do
		begin
	        read (myArray[count]);
	        if myArray[count] = 00 then
	        	break;
        end;
    writeln('You entered: ');

    (* array size == count - 1 *)
    printy(myArray, count-1);
    bubbleSort(myArray, count-1);
    writeln('After sorting, you get: ');
    printy(myArray, count-1);
end.