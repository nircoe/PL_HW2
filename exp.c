/*
Nir Cohen Hershkovitz 318227642 nir-nisim-co@campus.technion.ac.il
Itay Lasch 318507712 itay.lasch@campus.technion.ac.il
*/

#include <stdio.h> // for printf if you want to test it and print the result
#include <stdlib.h> // for malloc if you want to test it and create an Expr variable

typedef struct expr_s *Expr;

int main();
void DeleteIntExpr(Expr expr);
void DeleteNegExpr(Expr expr);
void DeleteAddExpr(Expr expr);
void DeleteMulExpr(Expr expr);

typedef enum expr_type // enum for classify the union
{
    TypeIntExpr,
    TypeNegExpr,
    TypeAddExpr,
    TypeMulExpr
} ExprType;

typedef struct int_expr { int i; } * IntExpr;
typedef struct neg_expr { Expr n; } * NegExpr;
typedef struct add_expr { Expr left; Expr right; } * AddExpr;
typedef struct mul_expr { Expr left; Expr right; } * MulExpr;

typedef union expr_data
{
    IntExpr intExpr;
    NegExpr negExpr;
    AddExpr addExpr;
    MulExpr mulExpr;
} * ExprData;

struct expr_s
{
    ExprType type;
    ExprData data;
};

int eval(Expr n)
{
    switch (n->type)
    {
    case TypeIntExpr:
        return n->data->intExpr->i;
    case TypeNegExpr:
        return -(eval(n->data->negExpr->n));
    case TypeAddExpr:
        return eval(n->data->addExpr->left) + eval(n->data->addExpr->right);
    case TypeMulExpr:
        return eval(n->data->mulExpr->left) * eval(n->data->mulExpr->right);
    default:
        main(); // instead of exception
        break;
    }
    return -1; // only in the case of 'default', instead of exception, doesn't gonna happend, main() will stuck the program
}

/*
*********** Create and Delete functions for the Expr struct ***********
 
Expr CreateIntExpr (int i)
{
    ExprData exprdata = malloc(sizeof(*exprdata));
    if(!exprdata)
        return NULL;
    IntExpr data = malloc(sizeof(*data));
    if(!data)
        return NULL;
    data->i = i;
    exprdata->intExpr = data;
    Expr expr = malloc(sizeof(*expr));
    if(!expr)
        return NULL;
    expr->data = exprdata;
    expr->type = TypeIntExpr;
    return expr;
}

Expr CreateNegExpr(Expr n)
{
    ExprData exprdata = malloc(sizeof(*exprdata));
    if (!exprdata)
        return NULL;
    NegExpr data = malloc(sizeof(*data));
    if (!data)
        return NULL;
    data->n = n;
    exprdata->negExpr = data;
    Expr expr = malloc(sizeof(*expr));
    if (!expr)
        return NULL;
    expr->data = exprdata;
    expr->type = TypeNegExpr;
    return expr;
}

Expr CreateAddExpr(Expr left, Expr right)
{
    ExprData exprdata = malloc(sizeof(*exprdata));
    if (!exprdata)
        return NULL;
    AddExpr data = malloc(sizeof(*data));
    if (!data)
        return NULL;
    data->left = left;
    data->right = right;
    exprdata->addExpr = data;
    Expr expr = malloc(sizeof(*expr));
    if (!expr)
        return NULL;
    expr->data = exprdata;
    expr->type = TypeAddExpr;
    return expr;
}

Expr CreateMulExpr(Expr left, Expr right)
{
    ExprData exprdata = malloc(sizeof(*exprdata));
    if (!exprdata)
        return NULL;
    MulExpr data = malloc(sizeof(*data));
    if (!data)
        return NULL;
    data->left = left;
    data->right = right;
    exprdata->mulExpr = data;
    Expr expr = malloc(sizeof(*expr));
    if (!expr)
        return NULL;
    expr->data = exprdata;
    expr->type = TypeMulExpr;
    return expr;
}

void DeleteIntExpr(Expr expr)
{
    free(expr->data->intExpr);
    free(expr->data);
    free(expr);
}

void DeleteNegExpr(Expr expr)
{
    switch (expr->data->negExpr->n->type)
    {
    case TypeIntExpr:
        DeleteIntExpr(expr->data->negExpr->n);
        break;
    case TypeNegExpr:
        DeleteNegExpr(expr->data->negExpr->n);
        break;
    case TypeAddExpr:
        DeleteAddExpr(expr->data->negExpr->n);
        break;
    case TypeMulExpr:
        DeleteMulExpr(expr->data->negExpr->n);
        break;
    default:
        break;
    }
    free(expr->data->negExpr);
    free(expr->data);
    free(expr);
}

void DeleteAddExpr(Expr expr)
{
    switch (expr->data->addExpr->left->type)
    {
    case TypeIntExpr:
        DeleteIntExpr(expr->data->addExpr->left);
        break;
    case TypeNegExpr:
        DeleteNegExpr(expr->data->addExpr->left);
        break;
    case TypeAddExpr:
        DeleteAddExpr(expr->data->addExpr->left);
        break;
    case TypeMulExpr:
        DeleteMulExpr(expr->data->addExpr->left);
        break;
    default:
        break;
    }
    switch (expr->data->addExpr->right->type)
    {
    case TypeIntExpr:
        DeleteIntExpr(expr->data->addExpr->right);
        break;
    case TypeNegExpr:
        DeleteNegExpr(expr->data->addExpr->right);
        break;
    case TypeAddExpr:
        DeleteAddExpr(expr->data->addExpr->right);
        break;
    case TypeMulExpr:
        DeleteMulExpr(expr->data->addExpr->right);
        break;
    default:
        break;
    }
    free(expr->data->addExpr);
    free(expr->data);
    free(expr);
}

void DeleteMulExpr(Expr expr)
{
    switch (expr->data->mulExpr->left->type)
    {
    case TypeIntExpr:
        DeleteIntExpr(expr->data->mulExpr->left);
        break;
    case TypeNegExpr:
        DeleteNegExpr(expr->data->mulExpr->left);
        break;
    case TypeAddExpr:
        DeleteAddExpr(expr->data->mulExpr->left);
        break;
    case TypeMulExpr:
        DeleteMulExpr(expr->data->mulExpr->left);
        break;
    default:
        break;
    }
    switch (expr->data->mulExpr->right->type)
    {
    case TypeIntExpr:
        DeleteIntExpr(expr->data->mulExpr->right);
        break;
    case TypeNegExpr:
        DeleteNegExpr(expr->data->mulExpr->right);
        break;
    case TypeAddExpr:
        DeleteAddExpr(expr->data->mulExpr->right);
        break;
    case TypeMulExpr:
        DeleteMulExpr(expr->data->mulExpr->right);
        break;
    default:
        break;
    }
    free(expr->data->mulExpr);
    free(expr->data);
    free(expr);
}

***************** main function for testing *****************

int main()
{
    Expr e = CreateAddExpr(
                CreateNegExpr(
                    CreateMulExpr(
                        CreateNegExpr(
                            CreateIntExpr(5)), 
                            CreateIntExpr(4))), 
                CreateIntExpr(9));
    printf("eval result : %d", eval(e)); // print "eval result : 29"
    DeleteAddExpr(e);
    return 0;
}

*/
