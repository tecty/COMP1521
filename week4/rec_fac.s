.data
x: .word 4

.text
main:



# call to read an interger to a0
li $v0, 5
syscall

addi $sp, $sp, -4 #increament the stack
sw $ra, 0($sp)    #set the return pointer into stack

#calling fac(v0)
addi $a0, $v0,0
jal fac

lw $ra, 0($sp)   # load the return pointer of main
addi $sp, $sp, 4 # clean the stack


#store a new a0 and try to output
addi $a0, $v0, 0
li $v0, 1
syscall


jr $ra



fac:
addi $sp, $sp, -8 #increament the stack
sw $ra, 0($sp)    #set the return pointer into stack
sw $a0, 4($sp)    #set the input a0 into stack
#recursive calling fac

#if statement
#if a0!=0 ,calling fac, return a0*fac(a0-1), if a0==0, else-> return 1
beq $a0, 0, fac_else



# calling fac(a0-1)
addi $a0, $a0, -1
jal fac




lw $a0, 4($sp)    #get the a0 from stack, multi it in return value


mul $v0, $a0, $v0 # return a0*fac(a0-1)

# if is ended
j fac_endif

fac_else:
# the smallest situation, start to reutrn. (end of calling)
# becuse reach the basic situation that a0 == 1, therefore, return 1
addi $v0, $0, 1

fac_endif:



#return;
lw $ra, 0($sp)    #get the return pointer from stack
addi $sp, $sp, 8  #clean the stack of this function
jr $ra
