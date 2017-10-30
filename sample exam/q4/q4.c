#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

int main(int argc, char const* argv[])
{
    int n, a, b, c;
    n = scanf("%d %d %d", &a, &b, &c);
    printf("n = %d , a = %d, b = %d, c = %d", n, a,b,c);
    printf("errno = %d\n",errno);
    perror("Error msg");
    return 0;
}
