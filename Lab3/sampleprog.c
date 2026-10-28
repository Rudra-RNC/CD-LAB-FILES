#include <stdio.h>
#define x 10
int main()
{ // sample C program for testing lexical analyser
  int i = 0x40;
  long sum = 999999999999999;
  char _ch_1 = '@'; // inline comment
  char str[20] = "Scanner ";
  sum = i;
  for (int j = 0; j < 10; j++) 
     sum = sum + j;
  printf(" sum = %ld str = %s\n", sum, str);
  printf(" _ch_1 = %c \n", _ch_1);
  return 0;
}
