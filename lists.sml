(*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il *)

fun valat l x = if x = 0 then hd(l) else (valat (tl(l)) (x-1));
 
(*===========================================================================*)

fun removeDupes [] = []
| removeDupes (x::xs) = x::removeDupes(List.filter (fn y => y<> x) xs);

(*===========================================================================*)

fun histogram [] = []
|histogram (x::xs) = 
let
 fun counter (z ,[] ,n) = n
 | counter (z ,list ,n) = if hd(list) = z then counter (z ,tl(list) ,(n+1))
 else counter (z ,tl(list) ,n)
 
in
(x,counter (x, x::xs ,0)) :: histogram(List.filter (fn y => y<> x) xs)

end;
