/*Itay Lasch 318507712 itay.lasch@campus.technion.ac.il 
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il */
open class Expr(){}

class IntExpr(number:Int):Expr(){
    var i:Int
    init{
        i= number
    } 
}

class NegExpr(exp :Expr):Expr(){
    var e: Expr
    init{
        e= exp
    }
}

class AddExpr(exp1:Expr ,exp2:Expr):Expr(){
    var e1:Expr
    var e2:Expr
    
    init{
        this.e1 = exp1
        this.e2 = exp2
    }
}

class MulExpr(exp1:Expr ,exp2:Expr):Expr(){
    var e1:Expr
    var e2:Expr

    init{
        this.e1 = exp1
        this.e2 = exp2
    }
}

fun eval(n:Expr):Int
{
    if(n is IntExpr)
        return n.i
    if(n is NegExpr)
        return -eval(n.e)
    if(n is AddExpr)
        return eval(n.e1) + eval(n.e2)
    if(n is MulExpr)
        return eval(n.e1) * eval(n.e2)
   
   
   throw new IllegalStateException()
}

fun main() {
    
}
    