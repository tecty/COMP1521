# COMP1521 Practice Prac Exam #1
# int everyKth(int *src, int n, int k, int*dest)

   .text
   .globl everyKth

# params: src=$a0, n=$a1, k=$a2, dest=$a3
everyKth:
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

	move $t0, $0
	move $t1, $0

# set the t4 always be 4
	addi $t4, $0, 4

forLoop:
	bge $t0, $a1, endForLoop

	div $t0, $a2
	mfhi $t2
	bnez $t2, endIf
# the i%k == 0
	
# get the location of the src[i]
	mul $t2, $t0, $t4
	add $t2, $t2, $a0
	lw $t2, ($t2)

# get the location of the dest[j]
	mul $t3, $t1, $t4
	add $t3, $t3, $a3
# svae the src[i] to dest[j]
	sw $t2, ($t3)

# increament the j
	addi $t1, $t1,  1

endIf:

	addi $t0, $t0, 1
	j forLoop
endForLoop:

# set the return value
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

