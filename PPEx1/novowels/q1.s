# COMP1521 Practice Prac Exam #1
# int novowels(char *src, char *dest)

   .text
   .globl novowels

# params: src=$a0, dest=$a1
novowels:
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
	
# set up the i, j, n 
	move $s0, $0
	move $s1, $0
	move $s2, $0

# src = $s3, dest = $s4
	move $s3, $a0
	move $s4, $a1


# function body


forLoop:

# get the char 
	add $t0, $s0, $s3
	lb $t0, ($t0)

# if the char is \0, end the loop
	beqz $t0, endForLoop

	move $a0, $t0 
	jal isvowel


	beqz $v0, else 
# has a vowel
	addi $s2, $s2, 1
	j endIf
else:
# here is not a vowel
# get the char 
	add $t0, $s0, $s3
	lb $t0, ($t0)
	add $t1, $s1, $s4
	sb $t0, ($t1)

	addi $s1, $s1, 1
endIf:



	addi $s0, $s0, 1
	j forLoop
endForLoop:

# save the end of string to \0 
	add $t0, $s1, $s4
	sb $0, ($t0)

# return n 
	move $v0, $s2



	
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

#####

# auxiliary function
# int isvowel(char ch)
isvowel:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)

# function body
   li   $t0, 'a'
   beq  $a0, $t0, match
   li   $t0, 'A'
   beq  $a0, $t0, match
   li   $t0, 'e'
   beq  $a0, $t0, match
   li   $t0, 'E'
   beq  $a0, $t0, match
   li   $t0, 'i'
   beq  $a0, $t0, match
   li   $t0, 'I'
   beq  $a0, $t0, match
   li   $t0, 'o'
   beq  $a0, $t0, match
   li   $t0, 'O'
   beq  $a0, $t0, match
   li   $t0, 'u'
   beq  $a0, $t0, match
   li   $t0, 'U'
   beq  $a0, $t0, match

   li   $v0, 0
   j    end_isvowel
match:
   li   $v0, 1
end_isvowel:

# epilogue
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra
