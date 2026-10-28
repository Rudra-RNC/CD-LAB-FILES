#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static short num = 1; // first temp variable is t1
static short labno = 10; // label number to start intermediate code
char intcode[40], temp[10], label[10], lhs[10], opr[5], opd1[10],
       opd2[10];

char *gentemp()
{ char *newtemp= (char*)malloc(sizeof(char[10]));
  sprintf(newtemp, "%d", num);
  char *prefix = "t", *temp;
  temp = (char*) malloc(strlen(prefix)+strlen(newtemp) +1);
  strcpy(temp,prefix); strcat(temp,newtemp); strcpy(newtemp,temp); 
  num++; return newtemp;
}

char* genlabel()
{ char *newlab= (char*)malloc(sizeof(char[10]));
  sprintf(newlab, "%d", labno);
  char* lbl = (char*) malloc(strlen(newlab)+2);
  strcpy(lbl, newlab); strcat(lbl, ": "); strcpy(newlab, lbl);
  labno++; return newlab;
}

char* gencode(char* lhs, char* opd1, char* opr, char* opd2)  
{char label[10], tmp[10], *asgn = " := ";
 strcpy(label, genlabel());
 char* tac = (char*) malloc(sizeof(char[40])); 
 int codelen = strlen(label)+strlen (lhs)+ 14 
              + strlen(opd1)+strlen(opr)+ strlen(opd2);
 char *code = (char*) malloc(codelen); 
 strcpy(code, label); strcat(code, lhs); strcat(code, asgn); 
 strcat(code, opd1); strcat(code, opr); ;strcat(code, opd2);
 strcpy(tac, code);
 return tac;
}
