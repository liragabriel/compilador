%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "func.h"
extern int yylex(void);
extern char *yytext;
extern int nlines;
extern FILE *yyin;
void yyerror(char *s);
%}

%verbose
%union
{
    float real;
}

%start Calculadora

%token <real> TKN_NUM
%token TKN_ATRIBUICAO
%token TKN_PONTOEVIRGULA
%token TKN_MULTIPLICACAO
%token TKN_DIVISAO
%token TKN_ADICAO
%token TKN_SUBTRACAO
%token TKN_PAA
%token TKN_PAF
%token TKN_COS
%token TKN_SEN
%token TKN_POTENCIA
%token TKN_RAIZ
%token TKN_FATORIAL
%token <real> TKN_ID

%type <real> Calculadora
%type <real> Expressao

%left TKN_MAS TKN_MENOS
%left TKN_MULT TKN_DIV

%%
Calculadora :   TKN_ID {printf("Valor de %s:", yytext);} 
                TKN_ATRIBUICAO Expressao TKN_PONTOEVIRGULA {printf("%5.2f\n", $4);} ; |
                Calculadora Calculadora {$2;} ;

Expressao :     TKN_NUM {$$=$1;}|
                Expressao TKN_ADICAO Expressao {$$=$1+$3;}| 
                Expressao TKN_SUBTRACAO Expressao {$$=$1-$3;}|
                Expressao TKN_MULTIPLICACAO Expressao {$$=$1*$3;}|  
                Expressao TKN_DIVISAO Expressao {$$=$1/$3;} |
                Expressao TKN_POTENCIA Expressao {$$=pow($1,$3);} |
                Expressao TKN_FATORIAL {$$=factorial($1);} |
                TKN_PAA Expressao TKN_PAF  {$$=$2;}|
                TKN_RAIZ TKN_PAA Expressao TKN_PAF {$$=sqrt($3);} |
                TKN_COS TKN_PAA Expressao TKN_PAF {$$=cos($3);}| 
                TKN_SEN TKN_PAA Expressao TKN_PAF {$$=sin($3);} ;
%%

void yyerror(char *s)
{
    printf("Error %s",s);
}

int main(int argc,char **argv)
    {
    if (argc>1)
        yyin=fopen(argv[1],"rt");
    else
        yyin=stdin;

    yyparse();

    printf("\nLinhas analisadas: %d\n", nlines);

    return 0;
}
