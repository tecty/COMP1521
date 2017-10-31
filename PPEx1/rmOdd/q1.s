# COMP1521 Practice Prac Exam #1
# int rmOdd(int *src, int n, int*dest)

   .text
   .globl rmOdd

# params: src=$a0, n=$a1, dest=$a2
rmOdd:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)
   addi $sp, $sp, -4
   sw   $s0, ($sp)
   addi $sp, $sp, -4
   sw   $s1, ($sp)
   # if you need to save more $s? registers
   # add the code to save them here

# function body
# locals: ...

    # add code for your rmOdd function here
    # set up the i = 0 j = 0
    move $t0, $0
    move $t1, $0

    # set up t2 = 2
    addi $t2, $0, 2 
    # set up the return value
    move $t6, $0

forLoop:
    # set up the for loop
    bge $t0, $a1, forLoopEnd

    # calculate the location of the array
    mul $t3, $t0, 4
    add $t3, $t3, $a0

    # get the number in t3,
    lw $t3, ($t3)

    # get the mod of t3
    div $t3, $t2
    mfhi $t4

    # if it isn't odd, continue
    bnez $t4, ifEnd
    
    # t3 is odd 
    
    # calculate the location of the array
    mul $t4, $t1, 4
    add $t4, $t4, $a2

    # save the thing in the array
    sw $t3, ($t4)

    # increament of j
    addi $t1, $t1, 1

ifEnd:



    addi $t0, $t0, 1
    j forLoop
forLoopEnd:

    # set up the return value
    move $v0, $t1




# epilogue
   # if you saved more than two $s? registers
   # add the code to restore them here
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra

