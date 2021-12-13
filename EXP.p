// Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il
// Itay Lasch 318507712 itay.lasch@campus.technion.ac.il

program EXP;
type   
    expType = (IntExpr, NegExpr, AddExpr, MulExpr);
    Expr = record
        case exp: expType of
            IntExpr: (i:integer);
            NegExpr: (Negn: ^Expr);
            AddExpr: (AddLeft,AddRight: ^Expr);
		    MulExpr: (MulLeft,MulRight: ^Expr);
    end;

    function eval(n:Expr):integer;
    begin 
        case (n.exp) of
            IntExpr:eval := n.i;
            NegExpr:eval := -(eval((n.Negn)^));
            AddExpr:eval := eval((n.AddLeft)^) + eval((n.AddRight)^);
            MulExpr:eval := eval((n.MulLeft)^) * eval((n.MulRight)^);
        else
            goto 999; // instead of exception, like the staff told to do
        end;
    end;

begin
    
end;