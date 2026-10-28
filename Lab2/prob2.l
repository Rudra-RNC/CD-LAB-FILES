%option noyywrap
%%
a+b*  {printf("Token 1 found \n");}
a*c*  {printf("Token 2 found \n");}
%%
int main() { yylex();}

