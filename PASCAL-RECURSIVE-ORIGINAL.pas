(*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il *)

program Hilbert
(*The start of the program therefore an interesting place*)
type Direction = (D, R, L, U);
	 DrawFunc = procedure(d: Direction);

procedure hilbert(n:integer;draw:DrawFunc);
procedure hilbertDLU(n:integer);forward;
procedure hilbertLDR(n:integer);forward;
procedure hilbertRUL(n:integer);forward;
procedure hilbertURD(n:integer);forward;

procedure hilbertDLU(n:integer);
(*interesting place*)
begin
    if n = 0 then exit
    else if n mod 2 = 1 then
    begin
        hilbertDLU(n-1);
        draw(D);
        hilbertLDR(n-1);
        draw(L);
        hilbertLDR(n-1);
        draw(U);
        hilbertURD(n-1);
    end
    else
    begin 
        hilbertDLU(n-1);
        draw(L);
        hilbertLDR(n-1);
        draw(D);
        hilbertLDR(n-1);
        draw(R);
        hilbertURD(n-1);
    end;
end;

procedure hilbertLDR(n:integer);
(*interesting place*)
begin
    if n = 0 then exit
    else if n mod 2 = 1 then 
    begin 
        hilbertLDR(n-1);
        draw(L);
        hilbertDLU(n-1);
        draw(D);
        hilbertDLU(n-1);
        draw(R);
        hilbertRUL(n-1);
    end
    else 
    begin
        hilbertLDR(n-1);
        draw(D);
        hilbertDLU(n-1);
        draw(L);
        hilbertDLU(n-1);
        draw(U);
        hilbertRUL(n-1);
    end;
end;

procedure hilbertRUL(n:integer);
(*interesting place*)
begin 
 if n = 0 then exit
    else if n mod 2 = 1 then 
    begin 
        hilbertRUL(n-1);
        draw(R);
        hilbertURD(n-1);
        draw(U);
        hilbertURD(n-1);
        draw(L);
        hilbertLDR(n-1);
    end
    else
    begin
        hilbertRUL(n-1);
        draw(U);
        hilbertURD(n-1);
        draw(R);
        hilbertURD(n-1);
        draw(D);
        hilbertLDR(n-1);
    end;
end;

procedure hilbertURD(n:integer);
(*interesting place*)
begin 
 if n = 0 then exit
    else if n mod 2 = 1 then 
    begin 
        hilbertURD(n-1);
        draw(U);
        hilbertRUL(n-1);
        draw(R);
        hilbertRUL(n-1);
        draw(D);
        hilbertDLU(n-1);
    end
    else
    begin
        hilbertURD(n-1);
        draw(R);
        hilbertRUL(n-1);
        draw(U);
        hilbertRUL(n-1);
        draw(L);
        hilbertDLU(n-1);
    end;
end;

begin
if n mod 2 = 1 then
        hilbertURD(n);
    else
        hilbertRUL(n);
end;


var order:integer;
begin
    writeln('Please Enter the Hilbert order');
    readLn(order);
end.