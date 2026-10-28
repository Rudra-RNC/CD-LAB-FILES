%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>

int p_no = 0;
const char *f(int x)
{
    if (x < 56)
        return "VL";
    else if (x < 66)
        return "L";
    else if (x <= 116)
        return "N";
    else if (x <= 132)
        return "H";
    else
        return "VH";
}

const char *pp(int x)
{
    if (x < 56)
        return "VL";
    else if (x < 67)
        return "L";
    else if (x <= 147)
        return "N";
    else if (x <= 168)
        return "H";
    else
        return "VH";
}

const char *hba1c(double x)
{
    if (x < 3.2)
        return "VL";
    else if (x < 3.8)
        return "L";
    else if (x <= 6.3)
        return "N";
    else if (x <= 7.2)
        return "H";
    else
        return "VH";
}
%}

DATE    ([0][1-9]|[1-2][0-9]|[3][0-1])\-([0][1-9]|[1][0-2])\-([0][0-9][0-9][1-9]|[1-2][0-9]{3})
NAME    [A-Z][a-z]+
INT     [0-9]+
REAL    [0-9]+\.[0-9]+

%%

{DATE}[ \t]+{NAME}[ \t]+BS\(F\)[ \t]+{INT}[ \t]+BS\(PP\)[ \t]+{INT}[ \t]+HBA1C[ \t]+{REAL} {
    char date[20], name[50];
    int fasting, pop;
    double hb1c;
    sscanf(yytext,"%19s %49s BS(F) %d BS(PP) %d HBA1C %lf", date, name, &fasting, &pop, &hb1c);
    p_no++;
    printf("Patient No.%d: %s %s BS(F) %d BS(PP) %d HBA1C %.1f",p_no, date, name, fasting, pop, hb1c);

    printf(" || F:%s; PP:%s; HBA1C:%s\n",
    f(fasting),
    pp(pop),
    hba1c(hb1c));
}

[ \t\r\n]+       ;
.                 ;

%%

int main()
{
    yylex();
    return 0;
}

