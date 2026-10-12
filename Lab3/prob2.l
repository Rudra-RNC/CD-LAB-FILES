%option noyywrap
%{
#include <stdio.h>
#include <string.h>

int keywords = 0, identifiers = 0,integers = 0, assign_ops = 0;
int arithmetic_ops = 0, relational_ops = 0, left_par = 0, right_par = 0, delimiters = 0, comments = 0, char_literals = 0, string_literals = 0;

void print_token(const char *token, const char *lexeme)
{
    printf(" (Token, Lexeme) = (%s, '%s')\n", token, lexeme);
}
%}

/* Definitions */

KEYWORD     (int|long|char|for|return|if|else|while|do|float|double|void|break|continue)
IDENTIFIER  [_a-zA-Z][_a-zA-Z0-9]*
INTEGER     [0-9]+
HEX         0[xX][0-9a-fA-F]+
CHARLIT     \'([^\\\n]|\\.)\'
STRING      \"([^\\\n]|\\.)*\"

%%

^[ \t]*#[^\n]* {
    printf("pre-processor directive ignored : %s\n", yytext);
}

"//"[^\n]* {
    printf(" Single Line Comment = \"%s\"\n", yytext);
    comments++;
}

{HEX} {
    print_token("HEXA NUMBER", yytext);
}

{CHARLIT} {
    print_token("CHAR LITERAL", yytext);
    char_literals++;
}

{STRING} {
    print_token("STRING", yytext);
    string_literals++;
}

{KEYWORD} {
    print_token("KEYWORD", yytext);
    keywords++;
}

{IDENTIFIER} {
    print_token("IDENTIFIER", yytext);
    identifiers++;
}

{INTEGER} {
    print_token("INTEGER", yytext);
    integers++;
}

"=" {
    print_token("ASSIGN-OP", yytext);
    assign_ops++;
}

"+"|"-"|"*"|"/"|"%" {
    print_token("ARITH-OP", yytext);
    arithmetic_ops++;
}

"<="|">="|"=="|"!="|"<"|">" {
    print_token("RELOP", yytext);
    relational_ops++;
}

"("|"{"|"[" {
    print_token("LEFTPAR", yytext);
    left_par++;
}

")"|"}"|"]" {
    print_token("RIGHTPAR", yytext);
    right_par++;
}

";"|"," {
    print_token("DELIMITER", yytext);
    delimiters++;
}

[ \t\r\n]+ {}

. {}

%%

int main(int argc, char *argv[])
{
    yylex();

    printf("\n Display Statistics of Tokens in Input\n\n");

    printf(" Number of Keywords : %d\n", keywords);
    printf(" Number of Identifiers : %d\n", identifiers);
    printf(" Number of Integers : %d\n", integers);
    printf(" Number of Assign Operators : %d\n", assign_ops);
    printf(" Number of Arithmetic Operators : %d\n", arithmetic_ops);
    printf(" Number of Relational Operators : %d\n", relational_ops);
    printf(" Number of Left Parentheses : %d\n", left_par);
    printf(" Number of Right Parentheses : %d\n", right_par);
    printf(" Number of Delimiters : %d\n", delimiters);
    printf(" Number of Single Line Comments : %d\n", comments);
    printf(" Number of Character Literals: %d\n", char_literals);
    printf(" Number of String Literals: %d\n", string_literals);

    return 0;
}
