# nodes.s ... linked list testing

   .data
N:
   .word 100
heap:
   .space 800    # 100 Node slots
free:
   .space 100    # assume all set to zero

   .text
   .globl main
main:
   # prologue
   add  $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   add  $sp, $sp, -4
   sw   $ra, ($sp)
   add  $sp, $sp, -4
   sw   $s0, ($sp)
   # function body
   move $s0, $0        # Node *L = NULL
   li   $a1, 1
   jal  append
   move $s0, $v0      # L = append(L, 1)
   move $a0, $s0
   li   $a1, 3
   jal  showList
   jal  append
   move $s0, $v0      # L = append(L, 3)
   move $a0, $s0
   li   $a1, 5
   jal  showList
   jal  append
   move $s0, $v0      # L = append(L, 5)
   move $a0, $s0
   li   $a1, 7
   jal  showList
   jal  append
   move $s0, $v0      # L = append(L, 7)
   move $a0, $s0
#   jal  showList
   # epilogue
   lw   $s0, ($sp)
   add  $sp, $sp, 4
   lw   $ra, ($sp)
   add  $sp, $sp, 4
   lw   $fp, ($sp)
   add  $sp, $sp, 4
   jr   $ra

append:
    # prologue
    add  $sp, $sp, -4
    sw   $fp, ($sp)
    la   $fp, ($sp)
    add  $sp , $sp, -4
    sw   $a0, ($sp)
    
    add  $sp, $sp, -4
    sw   $ra, ($sp)
    # ... add more if needed
    # function body
    
    # allocate a new node for this value 
    jal newNode
    
    # get the a0 for this function 
    la $t0, ($fp)
    addi $t0, $t0, -4
    lw $t0, ($t0)
    
    # node now have the input value
    sw $t0, ($v0)
    
    # push the node into list
    bne $s0,$0,searchEnd
    move $s0, $t0
    j endSearchEnd 
searchEnd:
    # try to search the end of the link list
    move  $t1, $s0
searchEndLoop:
    addi $t2, $t1, 4
    lw $t2, ($t2)
    beq $t2, $0, endSearchEndLoop
    # didn't find the loop, $t1 = $t1->next
    move $t1, $t2 
    j searchEndLoop
endSearchEndLoop:
    # $t1 now is the address of the tail node 
    addi $t2, $t1, 4
    sw $v0, ($t2)
    
    

endSearchEnd:

    move $v0,$s0

    # epilogue
    # ... add more if needed
    lw   $ra, ($sp)
    add  $sp, $sp, 8
    lw   $fp, ($sp)
    add  $sp, $sp, 4
    jr   $ra

showList:
   # prologue
   add  $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   add  $sp, $sp, -4
   sw   $ra, ($sp)
   # ... add more if needed
   # function body
   
   # go for the whole list
   

    
    move  $t1, $s0
    lw $t1, ($t1)
printListLoop:
    addi $t2, $t1, 4
    lw $t2, ($t2)
    beq $t2, $0, endPrintListLoop
    # print all the value in the list

    lw $a0, ($t1)
    li $v0, 1
    syscall
    
    # here is not the end of the loop
    move $t1, $t2 
    j printListLoop
endPrintListLoop:
   
   
   # epilogue
   # ... add more if needed
   lw   $ra, ($sp)
   add  $sp, $sp, 4
   lw   $fp, ($sp)
   add  $sp, $sp, 4
   jr   $ra

newNode:
    # prologue
    add  $sp, $sp, -4
    sw   $fp, ($sp)
    la   $fp, ($sp)
    add  $sp, $sp, -4
    sw   $ra, ($sp)
    # ... add more if needed
    # function body
    
    # i =0 
    li $t0, -1 
    lw $t1, N
findSpaceLoop:
    # start the for loop to find an empty space
    bgt $t0, $t1 ,  endFindSpaceLoop
    addi $t0, $t0, 1
    
    # main contex of the loop 
    lb $t2, free($t0)
    # check whether that space is empty
    bne $t2,$0, endFindSpaceLoop 
    # not the tail, continue the loop
    j findSpaceLoop

endFindSpaceLoop:
    blt $t0, $t1, foundEmpty    
    # not have empty space
    move $v0, $0
    j endFoundEmpty
foundEmpty:
    # found the empty space
    # set this space is not empty
    move $t2, $0
    sb $t2, free($0)
    # return this addr 
    mul $t0, $t0, 8
    la $t1, heap
    add $v0, $t0, $t1
    

endFoundEmpty:
    # epilogue
    # ... add more if needed
    lw   $ra, ($sp)
    add  $sp, $sp, 4
    lw   $fp, ($sp)
    add  $sp, $sp, 4
    jr   $ra

freeNode:
    # prologue
    add  $sp, $sp, -4
    sw   $fp, ($sp)
    la   $fp, ($sp)
    add  $sp, $sp, -4
    sw   $ra, ($sp)
    # ... add more if needed
    # function body

    # search the heap 
    li $t0, -1
searchHeapLoop:
    addi $t0, $t0, 1
    lw $t1, N
    bgt $t0, $t1, endSearchHeapLoop
    # load the addr of heap
    la $t1, heap
    mul $t3, $t0, 8
    # cal culate the addr for the heap[i]
    add $t1 $t1, $t3
    
    
    
    beq $a0, $t1, endSearchHeapLoop
    j searchHeapLoop
endSearchHeapLoop:
    # determine wheter it is the addr 
    bgt $t0, $t1, notFind
    # delete that node
    sb $0, free($t0)
    
notFind:


    # epilogue
    # ... add more if needed
    lw   $ra, ($sp)
    add  $sp, $sp, 4
    lw   $fp, ($sp)
    add  $sp, $sp, 4
    jr   $ra
