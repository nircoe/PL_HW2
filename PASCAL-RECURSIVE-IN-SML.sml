(*
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il
Itay Lasch 318507712 itay.lasch@campus.technion.ac.il
*)

(*------------------draw.sml------------------*)
local
  local
    fun re x = Int.toString (30 * x)
    fun line (x1, y1, x2, y2) =
        String.concat ["<line ",
          "x1=\"", re x1, "\" ",
          "y1=\"", re y1, "\" ",
          "x2=\"", re x2, "\" ",
          "y2=\"", re y2, "\" ",
          "style=\"stroke:rgb(255,0,0);stroke-width:3\" />"
        ]
    val turn = fn
      "R" => (1, 0)
      | "L" => (~1, 0)
      | "U" => (0, ~1)
      | "D" => (0, 1)
    fun step d (x1, y1) = let
          val (dx, dy) = turn d
        in
          (x1 + dx, y1 + dy)
        end
    fun aux (d, (cs, (x1, y1))) = let
          val (x2, y2) = step d (x1, y1)
        in
          ((x1, y1, x2, y2)::cs, (x2, y2))
        end
  in
    fun draw_all steps = let
          val (edges, _) = foldl aux ([], (0, 0)) steps
          val max_x = foldl (fn ((x1, y1, x2, y2), acc) => Int.max (acc, Int.max (x1, x2))) 0 edges
          val max_y = foldl (fn ((x1, y1, x2, y2), acc) => Int.max (acc, Int.max (y1, y2))) 0 edges
          val out = TextIO.openOut "hilbert.html"
        in
          TextIO.output (out, "<html><svg width='" ^ re max_x ^ "' height='" ^ re max_y ^"'>");
          TextIO.output (out,
            String.concat (map line edges)
            );
          TextIO.output (out, "</svg></html>");
          TextIO.closeOut out
        end
  end
in
  fun main1 hilbert n = let
        val steps = ref []
        fun draw (_, _, s) = steps := s::(!steps)
      in
        hilbert n draw;
        draw_all (!steps)
      end
  fun main2 hilbert n = let
        val steps = ref []
        fun draw s = steps := s::(!steps)
      in
        hilbert n draw;
        draw_all (!steps)
      end
end;

(*
usage: after you wrote your hilbert function, to check yourself use either:
main1 hilbert n;
to get a file for hilbert or depth n, using draw which takes ONLY DIRECTION or:
main2 hilbert n;
to get a file for hilbert or depth n, using draw which takes POINT AND DIRECTION.

DONT FORGET TO ADD THE MATCHING COMMENT TO YOUR FILE AS REQUESTED IN THE HW FILE.
example:

fun hilbert 1 = (draw "D"; draw "R"; draw "U");

use "draw.sml";
main2 hilbert 1;
*)

(*------------------hilbert------------------*)

fun hilbert n draw =
let
    fun hilbertDLU 0 = ()
      | hilbertDLU n =
            if n mod 2 = 1
            then
                ( hilbertDLU(n-1); draw("D"); hilbertLDR(n-1); draw("L"); hilbertLDR(n-1); draw("U"); hilbertURD(n-1); () )
            else
                ( hilbertDLU(n-1); draw("L"); hilbertLDR(n-1); draw("D"); hilbertLDR(n-1); draw("R"); hilbertURD(n-1); () )
    and hilbertLDR 0 = ()
      | hilbertLDR n =
            if n mod 2 = 1
            then
                ( hilbertLDR(n-1); draw("L"); hilbertDLU(n-1); draw("D"); hilbertDLU(n-1); draw("R"); hilbertRUL(n-1); () )
            else
                ( hilbertLDR(n-1); draw("D"); hilbertDLU(n-1); draw("L"); hilbertDLU(n-1); draw("U"); hilbertRUL(n-1); () )
    and hilbertRUL 0 = ()
      | hilbertRUL n =
            if n mod 2 = 1
            then
                ( hilbertRUL(n-1); draw("R"); hilbertURD(n-1); draw("U"); hilbertURD(n-1); draw("L"); hilbertLDR(n-1); () )
            else
                ( hilbertRUL(n-1); draw("U"); hilbertURD(n-1); draw("R"); hilbertURD(n-1); draw("D"); hilbertLDR(n-1); () )
    and hilbertURD 0 = ()
      | hilbertURD n =
            if n mod 2 = 1
            then
                ( hilbertURD(n-1); draw("U"); hilbertRUL(n-1); draw("R"); hilbertRUL(n-1); draw("D"); hilbertDLU(n-1); () )
            else
                ( hilbertURD(n-1); draw("R"); hilbertRUL(n-1); draw("U"); hilbertRUL(n-1); draw("L"); hilbertDLU(n-1); () );
in
    if n mod 2 = 1 
    then hilbertURD(n)
    else hilbertRUL(n)
end;

use "draw.sml";
main2 hilbert 3;