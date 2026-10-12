%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token NUM

%%

P:
   P E {printf("Final Value of E : %d\n", $2);}
   |
   ;

E: E '+' T  {$$ = $1 + $3; printf(" Value of %d + %d: %d\n", $1, $3, $$);}
   | T  {$$ = $1; printf(" Value of E : %d\n", $$);}
   ;
T: T '*' F {$$ = $1 * $3; printf(" Value of  %d * %d : %d\n", $1, $3, $$);}
   |F {$$ = $1; printf(" Value of T : %d\n", $1);}
;
F  : '(' E ')' {$$ = $2; printf(" Value of (E) : %d\n", $$);}
   | NUM {$$ = $1; printf(" NUMBER : %d\n", $1);}
   ;
%%

void yyerror (char* mess)
{ fprintf(stderr, "%s\n", mess); }

int main()
{ yyparse(); return 0; }
