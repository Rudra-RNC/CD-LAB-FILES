/* lex script to recognize unsigned integers and a few operators  */
%option noyywrap 
%{
#include <stdlib.h>  
void yyerror(char*);
#include "y.tab.h"
%}
ws [ \t\n]+
letter [A-Za-z]
digit  [0-9]
id {letter}({letter}|{digit})*

%%
{ws}        ;
{id}        {yylval.name=(char*)malloc(sizeof(yytext)); 
             strcpy(yylval.name, yytext); return ID;}
";"         {return ';';}
"+"         {return '+';}
"="         {return '=';}
.           {printf("Unrecognized Character : %s \n", yytext);}
%%

