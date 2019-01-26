program presRecord;

type
	ch_array = array[1..200] of char;

type
	names = array[1..10] of char;

type
	presidentRecord = record
		p_id : names;
		p_fname : names;
		p_lname : names;
	end;
type
	presArray = array[1..12] of presidentRecord;

var 
	f : file of char;
	myFile : file of char;
	myArray : ch_array;
	i : integer;
	idCounter : integer;
	fnameCounter : integer;
	lnameCounter : integer;
	myRecord : presidentRecord;
	myPresArray : presArray;
	


function getId(var a : ch_array; var pa : presidentRecord; i : integer) : integer;
begin
	while a[i] <> ' ' do
	begin
		pa.p_id[i] := a[i];
		i := i + 1;
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
	getlname := i + 1;
end;

procedure fillRecord(var a : ch_array; var pa : presArray);

var
	i : integer;
	paCount : integer;
begin
	i := 1;
	paCount := 1;
	while a[i] <> '-' do
	begin
		i := getId(a, presArray[paCount], i);

		i := getFname(a, presArray[paCount], i);
	
		i := getLname(a, presArray[paCount], i);
		paCount := paCount + 1;
	end;
	writeln(presArray);

end;



begin
	i := 1;
	assign(f, 'record.txt');
	reset(f);
	while not eof(f) do
	begin
		read(f, myArray[i]);
		i := i + 1;
	end;
	close(f);
	
	writeln(myArray);

	i := 1;
	idCounter := 1;
	fnameCounter := 1;
	lnameCounter := 1;
	
	fillRecord(myArray, myPresArray);

	{
	while not eof(myArray) do
	begin
		write(myArray[i]);
		i := i + 1;
	end;
	}

end.