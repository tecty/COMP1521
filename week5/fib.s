# MIPS assembler to compute Fibonacci numbers

   .data
msg1:
   .asciiz "n = "
msg2:
   .asciiz "fib(n) = "
msg3:
    # error message
    .asciiz "n must be > 0\n"
nl:
    #print the new line
    .asciiz "\n"
fibarr:
    .word 4


   .text

# int main(void)
# {
#    int n;
#    printf("n = ");
#    scanf("%d", &n);
#    if (n >= 1)
#       printf("fib(n) = %d\n", fib(n));
#    else {
#       printf("n must be > 0\n");
#       exit(1);
#    }
#    return 0;
# }

   .globl main
main:
   # prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   move $fp, $sp
   addi $sp, $sp, -4
   sw   $ra, ($sp)

   # function body
   la   $a0, msg1       # printf("n = ");
   li   $v0, 4
   syscall

   li   $v0, 5          # scanf("%d", &n);
   syscall
   move $a0, $v0

   # ... add code to check (n >= 1)
   # ... print an error message, if needed
   # ... and return a suitable value from main()


    bgtz $a0, enderr


    #print out the error message
    la $a0, msg3
    li $v0, 4
    syscall


    # end with error
    j endmain
enderr:
    #jump point if the input is valid
    
    #allocate the array to buffer the fib result
    # tmp store the a0
    move $t1, $a0


    #find the size should be allocate to buffer
    mul  $a0, $a0, 4
    
    #calling malloc
    li $v0, 9
    syscall
    # save this address into a global variable
    sw $v0, fibarr
    
    #get back the a0 to input in fib
    move $a0, $t1

   jal  fib             # $s0 = fib(n);
   nop
   move $s0, $v0

   la   $a0, msg2       # printf((fib(n) = ");
   li   $v0, 4
   syscall

   move $a0, $s0        # printf("%d", $s0);
   li   $v0, 1
   syscall

   la   $a0, nl        # printf("\n");
   li   $v0, 4
   syscall


endmain:
   # epilogue
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   jr   $ra



fib:
   # prologue
    sw $fp, -4($sp)
    sw $ra, -8($sp)
    sw $a0, -12($sp)
    la $fp, -4($sp)
    addi $sp, $sp, -16

    #main part of the function
    li $t0, 1
    #if input > 1, go to valid input
    bgt $a0,$t0 , bigone 
    
    # if input != 0 not goto zero, return 1
    bne $a0, $t0, zero
    #return 1
    li $v0, 1
    j endfib
    
zero:
    #return 0 if n <0
    addi $v0, $0, 0

    j endfib



bigone:

    # append for algroithm modify 
    
    # calculate the offset of the array
    mul $t0, $a0, 4
    la $t1, fibarr
    add $t0, $t0, $t1
    
    # pre-load up the value in the big buffer
    lw $v0, ($t0)
    # if the v0 is no equal to 0, tells that the number have been calculated
    # hence end the program by the buffer v0
    bne $v0, $0, endfib



    # ... add a suitable prologue
    # function body
    move $v0, $0
    #calculate the fib(n-1)
    addi $a0, $a0, -1
    jal fib

    #save the return at stack
    sw $v0, -12($fp)
    #addi $t0, $v0, 0

    #clear v0
    move $v0, $0
    #calculate the fib(n-2)
    addi $a0, $a0, -1
    jal fib
    addi $t1, $v0, 0


    # get the fib(n-1) from stack
    lw $t0, -12($fp)

    #add fib(n-1) fib(n-2) together
    add $v0, $t0, $t1
    #end of this fib


endfib:
    # write the result into buffer
    lw $a0, -8($fp)
    mul $t0, $a0, 4
    la $t1, fibarr
    add $t0, $t0, $t1
    #save the result into buffer
    sw $v0, ($t0)



    # epilogue
    lw $ra, -4($fp)
    lw $a0, -8($fp)
    la $sp, 4($fp)
    lw $fp, ($fp)

   # ... add a suitable epilogue
   jr   $ra
