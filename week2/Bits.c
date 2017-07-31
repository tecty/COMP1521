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
unsigned int power2 (int n){

    unsigned int answer = 1;
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
    for(int n = 0; n < b->nwords; n++){
        // calculate word by word
        res->words[n]= a->words[n]& b->words[n];
        
    }
}

// form bit-wise OR of two Bits a,b
// store result in res Bits
void orBits(Bits a, Bits b, Bits res)
{
    for(int n = 0; n < b->nwords; n++){
        // calculate word by word
        res->words[n]= a->words[n] | b->words[n];
        
    }
}

// form bit-wise negation of Bits a,b
// store result in res Bits
void invertBits(Bits a, Bits res)
{
    for(int n = 0; n < a->nwords; n++){
        // calculate word by word
        res->words[n]= ~ a->words[n];
        
    }
}

// left shift Bits
void leftShiftBits(Bits b, int shift, Bits res)
{
    // ignator of the loop
    res->words[0] =b-> words[0] << shift;

    for(int n = 1; n < b->nwords; n++){
        // shift at the words
        res->words[n] =b-> words[n] << shift;
        // calculate the overflow part
        unsigned int remain = b->words[n];
        for (int p = 0; p < shift; p++) {
            /* translate algo */
            res->words[n-1]+=remain/power2(BITS_PER_WORD-p-1)*power2(shift-p-1);
            // reset the remain
            remain = remain % power2(BITS_PER_WORD-p-1);
        }
        
    }
}

// right shift Bits
void rightShiftBits(Bits b, int shift, Bits res)
{
    // ignator of the loop
    res->words[res->nwords-1] =b-> words[b->nwords-1] >> shift;

    for(int n = b->nwords -2; n >=0; n--){
        // shift at the words
        res->words[n] =b-> words[n] >> shift;
        // calculate the overflow part
        unsigned int remain = b->words[n]%power2(shift);
        for (int p = 0; p < shift; p++) {
            /* translate algo */
            res->words[n+1]+=remain/power2(shift-p-1)*power2(BITS_PER_WORD-p-1);
            // reset the remain
            remain = remain % power2(shift-p-1);
        }
        
    }
}

// copy value from one Bits object to another
void setBitsFromBits(Bits from, Bits to)
{
    for(int n = 0; n < from->nwords; n++){
        // copy from source to destination
        to->words[n]=from->words[n];
    }
}

// assign a bit-string (sequence of 0's and 1's) to Bits
// if the bit-string is longer than the size of Bits, truncate higher-order bits
void setBitsFromString(Bits b, char *bitseq)
{
    // determine the length of input string
    int len= strlen(bitseq);
    // calculate the words should store
    //int input_nwords = (len-1)/ BITS_PER_WORD + 1;
    //printf("%d\n",input_nwords );
    //printf("b->nwords = %d\n",b->nwords );



    /* convert the sting into int */

    //  index of the string array
    int index = len - 1;


    // scan the char and store it into bits
    for (int i= b->nwords - 1; i >= 0; i --){
        // tmp store the converted int in this_word
        unsigned int this_word = 0;
        
        // start translating
        for (int power = 0; power < BITS_PER_WORD; power ++){
            if (index - power >= 0){
                // valid access to the char array
                this_word += power2(power)*(bitseq[index - power]-'0');
                
            }
            else {
                // invalid access, break the loop
                break;
            }
        
        }
        // store this word into the bits
        b->words[i] = this_word;
        
        // decreament of the index;
        index -= BITS_PER_WORD;
    
    
    
    }

    //printf("b->nwords = %d this_word = %d\n",b->nwords, b->words[1] );
}

// display a Bits value as sequence of 0's and 1's
void showBits(Bits b)
{
    //printf(" %d \n", b->nwords);

    //printf("b->words[0] = %d\nb->words[1] = %d\n",b->words[0],b->words[1] );
    for (int i = 0; i < b->nwords; i++) {
        /* convert the int into bit and pint out */
        
        
        unsigned int remain = b->words[i];
        
        for (int p = BITS_PER_WORD-1; p >=0; p--) {
            /* translate algo */
            printf("%d", remain/power2(p) );
            // reset the remain
            remain = remain % power2(p);
        }
    }
}
