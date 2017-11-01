# COMP1521 Practice Prac Exam #1
# int lowerfy(char *src, char *dest)

   .text
   .globl lowerfy

# params: src=$a0, dest=$a1
lowerfy:
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

# i = $t0, n = $t1
	move $t0, $0
	move $t1, $0

forLoop:
	# get this char
	add $t2, $t0, $a0 
	lb $t2, ($t2)

# end the loop when \0
	beqz $t2, endForLoop

	blt $t2, 65 , endIf
	bgt $t2, 90 , endIf

# this char is a UPPERCASE
# change this char to lowercase
	addi $t2, $t2, 32

# increament the n 
	addi $t1, $t1, 1
endIf:

# save the letter to dest
	add $t3, $t0, $a1 
	sb $t2, ($t3)

	addi $t0, $t0, 1
	j forLoop
endForLoop:
# set \0 at the end of str
	add $t3, $t0, $a1 
	sb $0, ($t3)
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

