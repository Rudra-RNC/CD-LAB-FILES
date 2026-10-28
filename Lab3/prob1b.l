%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char date[20];
char name[50];
int fasting = 0, pp = 0;
double hba1c = 0.0;
int p_no = 0;
int has_data = 0;

const char *c_f(int x)
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

const char *c_pp(int x)
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

const char *c_hba(double x)
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

void print_patient()
{
    p_no++;

    printf("Patient No.%d: %s %s BS(F) %d BS(PP) %d HBA1C %.1f || F:%s; PP:%s; HBA1C:%s\n",
           p_no, date, name, fasting, pp, hba1c, c_f(fasting), c_pp(pp), c_hba(hba1c));
}

void reset_table()
{
    date[0] = '\0';
    name[0] = '\0';
    fasting = 0;
    pp = 0;
    hba1c = 0.0;
    has_data = 0;
}

%}

DATE    ([0][1-9]|[1-2][0-9]|[3][0-1])\-([0][1-9]|[1][0-2])\-([1-9]|[0-9]{3})
NAME    [A-Z][a-z]+
INT     [0-9]+
REAL    [0-9]+\.[0-9]+

%%

{DATE} {
    strcpy(date, yytext);
    has_data = 1;
}

BS\(F\)[ \t]+{INT} {
    sscanf(yytext, "BS(F) %d", &fasting);
    has_data = 1;
}

BS\(PP\)[ \t]+{INT} {
    sscanf(yytext, "BS(PP) %d", &pp);
    has_data = 1;
}

HBA1C[ \t]+{REAL} {
    sscanf(yytext, "HBA1C %lf", &hba1c);
    has_data = 1;
}

{NAME} {
    strcpy(name, yytext);
    has_data = 1;
}

\n {
    if (has_data)
    {
        print_patient();
        reset_table();
    }
}

[ \t]+  ;

.       ;

%%

int main()
{
    reset_table();

    while (yylex());
    print_patient();

    return 0;
}

