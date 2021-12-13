(*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il *)

fun reverse list = foldl op:: [] list;

(*=====================================================================================================================*)

fun slice xs (start,ending,interval) = 
map (fn (index,x) => x)(
    List.filter (fn (index,x) => (index-start) mod interval = 0 andalso index>=start andalso index<=ending)(
        List.take((foldr (fn (x,list) => [(#1(hd(list))-1,x)]@list) [(length(xs),hd(xs))] (xs)),length(xs))
    )
);

(*=====================================================================================================================*)

fun renumerate xs = (List.take((foldr (fn (x,list) => [(#1(hd(list))+1,x)]@list) [(0,hd(xs))] (xs)),length(xs)));

(*=====================================================================================================================*)

fun allholds_notholds yes no list =

List.filter (fn x => (List.all (fn y => y(x)) (yes)) andalso (List.all (fn z=> not(z(x))) (no))) list;
