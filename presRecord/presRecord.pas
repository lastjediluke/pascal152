program presRecord;

type
	ch_array = array[1..200] of char;

type
	names = array[1..10] of char;

type
	presidentRecord = record
		p_id : integer;
		p_fname : names;
		p_lname : names;
	end;

type
	presArray = array[1..12] of presidentRecord;

type
	searchArray = array[1..5] of integer;

type
	numbers = '0'..'9';
	numbersSet = set of numbers;

var 
	f : file of char;
	myArray : ch_array;
	i : integer;
	myPresArray : presArray;
	paCount : integer;

	
function getId(var a : ch_array; var pa : presidentRecord; i : integer) : integer;
var
	idCount : integer;
begin
	idCount := 1;
	while a[i] <> ' ' do
	begin
		pa.p_id := 10*pa.p_id + (ord(a[i]) - ord('0'));
		i := i + 1;
		idCount := idCount + 1;
	end;
	getId := i + 1;
end;


function getFname(var a : ch_array; var pa : presidentRecord; i : integer) : integer;
var 
	fCount : integer;
begin
	fCount := 1;
	while a[i] <> ' ' do
	begin
		pa.p_fname[fCount] := a[i];
		i := i + 1;
		fCount := fCount + 1;
	end;

	getFname := i + 1;
end;


function getLname(var a : ch_array; var pa : presidentRecord; i : integer) : integer;
var 
	lCount : integer;
begin
	lCount := 1;
	while a[i] <> LineEnding do
	begin
		pa.p_lname[lCount] := a[i];
		i := i + 1;
		lCount := lCount + 1;
	end;
	getLname := i + 1;
end;

{ * ideally, this function should split into 2 different functions * }
function presidentSearch(var a : ch_array; var pa : presArray; i : integer) : boolean;
var
	intToSearch : searchArray;
	intsCount : integer;
	presArrCount : integer;
	myNums : numbersSet;
	c : numbers;
begin
	c := a[i];
	intsCount := 1;
	writeln('Searching...');
	myNums := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

	{ * init the search items array *}
	while intsCount <> 6 do
	begin
		intToSearch[intsCount] := 0;
		intsCount := intsCount + 1;
	end;
	intsCount := 1;

	{ * find search items and store into intToSearch array * }
	while true do
	begin
		c := a[i];
		if c in myNums then
		begin
			intToSearch[intsCount] := (10*intToSearch[intsCount]) + (ord(c) - ord('0'));
			i := i + 1;
		end
		
		else if a[i] = ' ' then
		begin
			i := i + 1;
			intsCount := intsCount + 1;
		end

		else begin
			break
		end;
	end;
	presArrCount := 1;
	intsCount := 1;

	{ * search through my president records to find matches* }
	while intToSearch[intsCount] <> 0 do 
	begin
		while true do
		begin
			if pa[presArrCount].p_id = 0 then
			begin
				writeln('No Match for ', intToSearch[intsCount]);
				break;
			end;

			if pa[presArrCount].p_id = intToSearch[intsCount] then
			begin
				write('Match! ');
				write(pa[presArrCount].p_fname);
				write(' ');
				writeln(pa[presArrCount].p_lname);
				break;
			end;
			presArrCount := presArrCount + 1;
		end;
		intsCount := intsCount + 1;
		presArrCount := 1;
	end;	
	presidentSearch := true;
end;

procedure printPresidents(var pa : presArray);
var
	i : integer;
begin
	i := 1;
	writeln('Printing...');
	while pa[i].p_id <> 0 do
	begin
		write(pa[i].p_id);
		write(' ');
		write(pa[i].p_fname);
		write(' ');
		writeln(pa[i].p_lname);
		i := i + 1;
	end;
end;

{ */// MAIN \\\* }
begin
	i := 1;
	assign(f, 'record.txt');
	reset(f);

	{ * read from a file into a character array * }
	while not eof(f) do
	begin
		read(f, myArray[i]);
		i := i + 1;
	end;
	close(f);
	
	{ * I would have liked to put while loop below into a function, however, I kept getting errors * }
	i := 1;
	paCount := 1;

	{ * fill up the record from myArray * }
	while myArray[i] <> '-' do
	begin
		i := getId(myArray, myPresArray[paCount], i);
		i := getFname(myArray, myPresArray[paCount], i);
		i := getLname(myArray, myPresArray[paCount], i);
		paCount := paCount + 1;
	end;

	{ * i should = - at this point, so I need to add 3 to get it to the search items * }
	i := i + 3;
	presidentSearch(myArray, myPresArray, i);
	printPresidents(myPresArray);	
end.