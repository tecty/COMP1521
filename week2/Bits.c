// ADT for Bit-strings
// COMP1521 17s2 Week02 Lab Exercise
// Written by John Shepherd, July 2017
// Modified by ...

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "Bits.h"

// assumes that an unsigned int is 32 bits
#define BITS_PER_WORD 32

// A bit-string is an array of unsigned ints (each a 32-bit Word)
// The number of bits (hence Words) is determined at creation time
// Words are indexed from right-to-left
// words[0] contains the most significant bits
// words[nwords-1] contains the least significant bits
// Within each Word, bits are indexed right-to-left
// Bit position 0 in the Word is the least significant bit
// Bit position 31 in the Word is the most significant bit

typedef unsigned int Word;

struct BitsRep {
   int nwords;   // # of Words
   Word *words;  // array of Words
};

// make a new empty Bits with space for at least nbits
// rounds up to nearest multiple of BITS_PER_WORD
Bits makeBits(int nbits)
{
   Bits new;
   new = malloc(sizeof(struct BitsRep));
   assert(new != NULL);
   int  nwords;
   if (nbits%BITS_PER_WORD == 0)
      nwords = nbits/BITS_PER_WORD;
   else
      nwords = 1+nbits/BITS_PER_WORD;
   new->nwords = nwords;
   // calloc sets to all 0's
   new->words = calloc(nwords, sizeof(Word));
   assert(new->words != NULL);
   return new;
}


// calculate the power of 2 by given int
int power2 (int n){

    int answer = 1;
    for (int i = 0; i < n; i++) {
        /* multiply answer by 2 */
        answer *=2;
    }
    //  return it;
    return answer;
}



// release space used by Bits
void  freeBits(Bits b)
{
   assert(b != NULL && b->words != NULL);
   free(b->words);
   free(b);
}

// form bit-wise AND of two Bits a,b
// store result in res Bits
void andBits(Bits a, Bits b, Bits res)
{
   // TODO
}

// form bit-wise OR of two Bits a,b
// store result in res Bits
void orBits(Bits a, Bits b, Bits res)
{
   // TODO
}

// form bit-wise negation of Bits a,b
// store result in res Bits
void invertBits(Bits a, Bits res)
{
   // TODO
}

// left shift Bits
void leftShiftBits(Bits b, int shift, Bits res)
{
   // challenge problem
}

// right shift Bits
void rightShiftBits(Bits b, int shift, Bits res)
{
   // challenge problem
}

// copy value from one Bits object to another
void setBitsFromBits(Bits from, Bits to)
{
   // TODO
}

// assign a bit-string (sequence of 0's and 1's) to Bits
// if the bit-string is longer than the size of Bits, truncate higher-order bits
void setBitsFromString(Bits b, char *bitseq)
{
    // determine the length of input string
    int len= strlen(bitseq);
    // calculate the words should store
    int input_nwords = (len-1)/ BITS_PER_WORD + 1;
    printf("%d\n",input_nwords );
    printf("b->nwords = %d\n",b->nwords );
    if (b->nwords != input_nwords) {
        /* the ADT is not big enough, create a new one */
        Bits old_bit = b;
        b = makeBits(input_nwords);
        printf("imhere\n" );
        // free the unused one;
        freeBits(old_bit);
    }
    printf("b->nwords = %d\n",b->nwords );


    /* convert the sting into int */

    //  index of the string array
    int index = 0;

    // tmp store the converted int in this_word
    int this_word = 0;
    // most distinguish part, i is the power of this char for this word
    for (int i =  (len-1)%BITS_PER_WORD; i >= 0; i--) {
        /* read from the front */
        this_word += power2(i)*(bitseq[index]-'0');
        index ++;
    }
    // store this_word into ADT
    b->words[0] = this_word;

    // general part
    for (int this_word_index = 1; this_word_index < input_nwords; this_word_index++) {
        /* convert the string into int */
        for (int i =  BITS_PER_WORD-1; i >= 0; i--) {
            /* read from the front */
            this_word += power2(i)*(bitseq[index]-'0');
            index ++;
        }

        // store this_word into ADT
        b->words[this_word_index] = this_word;
    }
        printf("b->nwords = %d this_word = %d\n",b->nwords, b->words[0] );
}

// display a Bits value as sequence of 0's and 1's
void showBits(Bits b)
{
    printf(" %d \n", b->nwords);

    printf("%d\n",b->words[0] );
    // for (int i = 0; i < b->nwords; i++) {
    //     /* convert the int into bit and pint out */
    //     for (int p = BITS_PER_WORD-1; p >=0; p--) {
    //         /* translate algo */
    //         printf("%d", b->words[i]/power2(p) );
    //     }
    // }
}
