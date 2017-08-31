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
    li $v0, 5
    syscall


    # end with error
    j endmain
enderr:
    #jump point if the input is valid


   jal  fib             # $s0 = fib(n);
   nop
   move $s0, $v0

   la   $a0, msg2       # printf((fib(n) = ");
   li   $v0, 4
   syscall

   move $a0, $s0        # printf("%d", $s0);
   li   $v0, 1
   syscall

   lw   $a0,nl        # printf("\n");
   li   $v0, 11
   syscall


endmain:
   # epilogue
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   jr   $ra


# int fib(int n)
# {
#    if (n < 1)
#       return 0;
#    else if (n == 1)
#       return 1;
#    else
#       return fib(n-1) + fib(n-2);
# }

fib:
   # prologue
    sw $fp, -4($sp)
    sw $ra, -8($sp)
    sw $a0, -12($sp)
    la $fp, -4($sp)
    addi $sp, $sp, -12

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
    # ... add a suitable prologue
    # function body
    move $v0, $0
    #calculate the fib(n-1)
    addi $a0, $a0, -1
    jal fib

    #save the return at t0
    addi $t0, $v0, 0

    #clear v0
    move $v0, $0
    #calculate the fib(n-2)
    addi $a0, $a0, -1
    jal fib
    addi $t1, $v0, 0

    #add fib(n-1) fib(n-2) together
    add $v0, $t0, $t1
    #end of this fib


endfib:
   # epilogue
    lw $ra, -4($fp)
    lw $a0, -8($fp)
    la $sp, 4($fp)
    lw $fp, ($fp)

   # ... add a suitable epilogue
   jr   $ra
