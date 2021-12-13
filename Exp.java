/*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il */
class Expr {
    }

class IntExpr extends Expr {
    int i;

    public IntExpr(int number) {
        i = number;
    }

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }
}

class NegExpr extends Expr {
    Expr e;

    public NegExpr(Expr e){
        this.e = e;
    }
}


class AddExpr extends Expr {
    Expr e1, e2;

    public AddExpr(Expr e1, Expr e2)  {
        this.e1 = e1;
        this.e2 = e2;
    }
}

class MulExpr extends Expr {
    Expr e1, e2;

    public MulExpr(Expr e1, Expr e2)  {
        this.e1 = e1;
        this.e2 = e2;
    }
}

public class Exp{
    private static int eval(Expr n)
    {
        if(n instanceof IntExpr)
            return ((IntExpr)n).i;
        if(n instanceof NegExpr)
            return -eval(((NegExpr)n).e);
        if(n instanceof AddExpr)
            return eval(((AddExpr)n).e1) + eval(((AddExpr)n).e2);
        if(n instanceof MulExpr)
            return eval(((MulExpr)n).e1) * eval(((MulExpr)n).e2); 

        throw new IllegalStateException();
    }


    public static void main(String[] args)
    {

    }
}

