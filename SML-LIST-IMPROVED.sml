(*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il *)


fun re x = Int.toString (30 * x);

fun line {s1=(x1, y1), s2=(x2, y2)} =
    String.concat ["<line ",
        "x1=\"", re x1, "\" ",
        "y1=\"", re y1, "\" ",
        "x2=\"", re x2, "\" ",
        "y2=\"", re y2, "\" ",
        "style=\"stroke:rgb(255,0,0);stroke-width:3\" />"
    ]
;

fun draw edges = let
    val out = TextIO.openOut "hilbert.svg"
    val max_x = foldl (fn ({s1=(x1, y1), s2=(x2, y2)}, acc) => Int.max (acc, Int.max (x1, x2))) 0 edges
    val max_y = foldl (fn ({s1=(x1, y1), s2=(x2, y2)}, acc) => Int.max (acc, Int.max (y1, y2))) 0 edges
in
    TextIO.output (out, "<svg width='" ^ re max_x ^ "' height='" ^ re max_y ^"'>");
    TextIO.output (out,
        String.concat (map line edges)
    );
    TextIO.output (out, "</svg>");
    TextIO.closeOut out
end;

Control.Print.printLength := 100;

Control.Print.printLength := 100;



fun hilbert 0 = []
| hilbert x = 
let
    fun length [] = 0
    | length(x::xs) = 1 + length xs;

    fun endtl lis = if(length(lis)=1) then lis else endtl(tl(lis));

    fun last lis = hd(endtl lis);

    fun removelast lis = 
        if length(lis) = 1 then [] 
        else 
        [hd(lis)] @ removelast(tl(lis)); 


    fun pow2 0 =1
    | pow2 x = 2*pow2(x-1);


    (*up =0, right =1 ,down=2, left =3*)


    fun turnright lis= if(length(lis) = 0) then [] 
    else (hd(lis)-1) mod 4 :: turnright(tl(lis));

    fun turnleft lis = if(length(lis) = 0) then [] 
    else (hd(lis)+1) mod 4 :: turnleft(tl(lis));

    fun fliplist [] = []
        | fliplist lis= last(lis):: fliplist(removelast(lis));


    fun convert_to_coor ([],x,y) = []
    | convert_to_coor (dirlis,x,y)= case (hd(dirlis)) of
        0 => {s1=(x,y), s2=(x,y-1)} :: convert_to_coor(tl(dirlis),x,y-1)
        |1 => {s1=(x,y), s2=(x+1,y)} :: convert_to_coor(tl(dirlis),x+1,y)
        |2 => {s1=(x,y), s2=(x,y+1)} :: convert_to_coor(tl(dirlis),x,y+1)
        |3 => {s1=(x,y), s2=(x-1,y)} :: convert_to_coor(tl(dirlis),x-1,y)
        |_ => [];
        

    fun hilrec 1 = [0,1,2]
    | hilrec 0 = []
    | hilrec x = 
        (fliplist(turnright(hilrec(x-1))) 
        @ [0] (*down-right to up-right*)
        @ hilrec(x-1) 
        @ [1] (*up-right to up-left*)
        @ hilrec(x-1) 
        @ [2] (*up-left to down-left*)
        @ fliplist(turnleft(hilrec(x-1))));

in
  convert_to_coor(hilrec(x),1,pow2(x))
end;





    