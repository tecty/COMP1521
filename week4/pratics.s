.text
.globl main
main:
	li $t0, 10 #number of iterations
	li $t1, 0  #counter like i 
	li $t2, 17 #holds of value to modify

loop:
	beq $t1, $t0, end  #if t1 == 10 end loop
	add $t2, $t2, $t1  # body of the loop
	addi $t1, $t1, 1   # add 1 to t1
	j loop  #jump back to the top
end: 
	li $v0, 10
	syscall
