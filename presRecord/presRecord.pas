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

var 
	f : file of char;
	myFile : file of char;
	myArray : ch_array;
	i : integer;
	idCounter : integer;
	fnameCounter : integer;
	lnameCounter : integer;
	myRecord : presidentRecord;
	presArray : array[1..12] of presidentRecord;

procedure getFirstName();
begin

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

	while true do
	begin
		if myArray[i] = ' ' then
		begin
			break;
		end;
		myRecord.p_id[i] := myArray[i];
		i := i + 1;
	end;

	i := i + 1;
	while true do
	begin
		if myArray[i] = ' ' then
		begin
			break;
		end;
		myRecord.p_fname[fnameCounter] := myArray[i];
		i := i + 1;
		fnameCounter := fnameCounter + 1;
	end;

	i := i + 1;
	while true do
	begin
		if myArray[i] = LineEnding then
		begin
			break;
		end;
		myRecord.p_lname[lnameCounter] := myArray[i];
		i := i + 1;
		lnameCounter := lnameCounter + 1;
	end;

	writeln(myRecord.p_lname);

	{
	while not eof(myArray) do
	begin
		write(myArray[i]);
		i := i + 1;
	end;
	}

end.