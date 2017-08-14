// where_are_the_bits.c ... determine bit-field order
// COMP1521 Lab 03 Exercise
// Written by ...

#include <stdio.h>
#include <stdlib.h>

struct _bit_fields {
   unsigned int a : 4,
                b : 8,
                c : 20;
};
union float_field {
    struct _bit_fields bits;
    unsigned int this;
};



int main(void)
{
    struct _bit_fields x;

    printf("%ul\n",sizeof(x));
    union float_field y;
    y.bits.c =2;
    y.bits.a =0;
    y.bits.b =0;
    printf("%u\n",y.this);

    y.bits.c =0;
    y.bits.a =2;
    y.bits.b =0;
    printf("%u\n",y.this);

    return 0;
}
