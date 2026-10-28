%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token NUM

%left '+'
%left '*'
%%

P:
   P E {printf("Final Value of E : %d\n", $2);}
   |
   ;

E: E '+' E  {$$ = $1 + $3; printf(" Value of %d + %d: %d\n", $1, $3, $$);}
   | E '*' E {$$ = $1 * $3; printf(" Value of  %d * %d : %d\n", $1, $3, $$);}
   | '(' E ')' {$$ = $2; printf(" Value of (E) : %d\n", $$);}
   | NUM {$$ = $1; printf(" NUMBER : %d\n", $1);}
   ;
%%

void yyerror (char* mess)
{ fprintf(stderr, "%s\n", mess); }

int main()
{ yyparse(); return 0; }
