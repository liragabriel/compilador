%{
#include <stdio.h>
#include <stdlib.h>
#include "sintatico.tab.h"
int nlines=0;
%}

DIGITO [0-9]
ID [a-zA-Z][a-zA-Z0-9_]*

%%
{DIGITO}+("."{DIGITO}+)?    {yylval.real=atof(yytext); return(TKN_NUM);}
"="                         {return(TKN_ATRIBUICAO);}
";"                         {return(TKN_PONTOEVIRGULA);}
"*"                         {return(TKN_MULTIPLICACAO);}
"/"                         {return(TKN_DIVISAO);}
"+"                         {return(TKN_ADICAO);}
"-"                         {return(TKN_SUBTRACAO);}
"("                         {return(TKN_PAA);}
")"                         {return(TKN_PAF);}
"cos"                       {return(TKN_COS);}
"sen"                       {return(TKN_SEN);}
"^"                         {return(TKN_POTENCIA);}
"sqrt"                      {return(TKN_RAIZ);}
"!"                         {return(TKN_FATORIAL);}
{ID}                        {return(TKN_ID);}
"\n"                        {nlines++;}

%%
