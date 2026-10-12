%option noyywrap
%{
#include<stdio.h>

int t1 = 0, t2 = 0, err = 0;
%}

%%

a+b* { t1++; printf("T1 found : count = %d Lexeme : %s\n", t1, yytext); }
a*c* { t2++; printf("T2 found : count = %d Lexeme : %s\n", t2, yytext); }

[ \t\n]+    ; 
.       {
            err++;
            printf("Character %s is either not a lexeme or not in Alphabet : count = %d\n", yytext, err);
        }
%%

int main()
{
    yylex();
    printf("\nStatistics of tokens in input :\n");
    printf("|Token1| = %d; |Token2| = %d; |All Tokens| = %d\n",
            t1, t2, t1 + t2);
    printf("Number of Characters in Input either not a lexeme or outside Alphabet : %d\n",
            err);
    return 0;
}
