(*
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il
Itay Lasch 318507712 itay.lasch@campus.technion.ac.il
*)

exception IllegalStateException;

datatype Expr = 
    IntExpr of int
    | NegExpr of Expr
    | AddExpr of Expr*Expr
    | MulExpr of Expr*Expr
    | default;

fun eval (IntExpr i) = i
  | eval (NegExpr n) = ~(eval(n))
  | eval (AddExpr (left,right)) = eval(left) + eval(right)
  | eval (MulExpr (left,right)) = eval(left) * eval(right)
  | eval _ = raise IllegalStateException;