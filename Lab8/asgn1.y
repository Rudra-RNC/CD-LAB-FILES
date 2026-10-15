%{
#include <stdio.h>
#include "tac-functions.c"
int yylex(void);
void yyerror(char *);
char intcode[40], temp[10], label[10], lhs[10], opr[5], opd1[10],
       opd2[10];
short astcnt = 1;
FILE* fileptr; // file in which int code is written
%}
/* YACC Declarations */
%union
{ int intval;
  char* name;
}

%right '='
%left '+' 
%token <name> ID
%type  <name> E
%%
S : S A
    | A
    ;
A: ID '=' E ';' {printf("Assignment statement %d processed ;\n",astcnt);
                 strcpy(intcode, gencode($1, $3, "", ""));
                 fprintf(fileptr, "%s \n",intcode);
                }
   ;
E: E '+' E  {  $$ = (char*)malloc(sizeof(char[10])); strcpy($$, gentemp());
               strcpy(intcode, gencode($$, $1," + ",$3));
               fprintf(fileptr, "%s \n",intcode);
               printf("Rule E -> E + ID used ;\n");
              }
    | ID      { $$ = (char*)malloc(sizeof(char[10])); strcpy($$, gentemp());
                strcpy(intcode, gencode($$, $1, "", ""));
               fprintf(fileptr, "%s \n",intcode);
               printf("Rule E -> ID used ;\n");
              } 
   ;
%%

void yyerror (char* mess) { fprintf(stderr, "%s\n", mess); }

int main()
{ fileptr= fopen("codefile", "w");
  printf(" Give start label number : "); scanf("%hd", &labno);
  printf("\n");
  yyparse(); fclose(fileptr);  
  return 0;
}
