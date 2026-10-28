#include <stdio.h>
#include <stdbool.h>
int main()
{ int x1, x2, x3;
  x1 = 10;
  x2 = x1 - 25;
  x3 = x1 * x2 && 15 / x2 || false;
  printf("x1 = %d x2 = %d x3 = %d \n", x1, x2, x3);
  return 0;
}
