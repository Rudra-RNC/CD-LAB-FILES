/* exp6.l
* lex script to extract arithmetic operators and operands from i/p
   and communicate the same to yacc */
%option noyywrap 
%{
#include <stdlib.h>  /*  why ?? */
void yyerror(char*);
#include "y.tab.h"
%}
ws [ \t\n]+
digit  [0-9]
%%
{ws}        ;
{digit}+ { yylval = atoi(yytext); return NUM;}
"+"      {return '+';}
"*"      {return '*';}
"("      {return '(';}
")"      {return ')';}
.        {yyerror("invalid character\n");}
%%
