# COMP1521 Lab 04 ... Simple MIPS assembler


### Global data

   .data
msg1:
   .asciiz "n: "
msg2:
   .asciiz "n! = "
eol:
   .asciiz "\n"

### main() function

   .data
   .align 2
main_ret_save:
   .word 4

   .text
   .globl main

main:
   sw   $ra, main_ret_save

#  ... your code for main() goes here

    # call to read an interger to a0
    li $v0, 5
    syscall

    # copy the readed interger into a0
    addi $a0, $v0, 0

    #calling function fac
    jal fac

    #copy output of fac and try to print it
    addi $a0, $v0, 0
    li $v0, 1
    syscall


   lw   $ra, main_ret_save
   jr   $ra           # return

### fac() function

   .data
   .align 2
fac_ret_save:
   .space 4

   .text

fac:
   sw   $ra, fac_ret_save

#  ... your code for fac() goes here

    li $t0, 0
    li $t1, 1

loop:
    #loop to get the factorial
    beq $t0,$a0,exit
    addi $t0,$t0,1
    #t1 would store the factorial output
    mul $t1, $t1, $t0
    j loop
exit:

    #this line is outside the loop
    #store the function output at v0
    addi $v0, $t1, 0

    # end of calculation


   lw   $ra, fac_ret_save
   jr   $ra            # return ($v0)
