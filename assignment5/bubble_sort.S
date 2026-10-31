# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.data
prompt: .asciiz "Please enter your number, this is number "
colon: .asciiz ": "
before: .asciiz "Before Bubble Sort: "
after: .asciiz "After Bubble Sort: "
during: .asciiz "Iteration "
numbers: .word 505:10


.globl _start
.text
_start:
main:
la $s0, numbers
li $s1, 0
li $s2, 10 #how many numbers there are ##CHANGE

loop:
bge $s1, $s2, numbers_read
li $v0, 4
la $a0, prompt
syscall
li $v0, 1
addi $t0, $s1, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, colon
syscall

li $v0, 5
syscall
sw $v0, 0($s0)
addi $s0, $s0, 4
addi $s1, $s1, 1
j loop

numbers_read:
#if we have reached here, we have read all numbers
#now we print before iteration in the same way
li $v0, 4
la $a0, before
syscall
jal number_printing
li $v0, 11
li $a0, '\n'
syscall
#Now we start with the iterations
#s7 will store number of iterations.
li $s7, 1
loop4:
jal iteration_loop
#printing value after iteration
li $v0, 4
la $a0, during
syscall
li $v0, 1
move $a0, $s7
syscall
li $v0, 4
la $a0, colon
syscall
jal number_printing
li $v0, 11
li $a0, '\n'
syscall
#end of print
addi $s7, $s7, 1
li $t6, 800
bgt $s7, $t6, end #worst case of bubble sort is n2, so can't be more that this
j loop4



number_printing:
la $t0, numbers
li $t1, 1
li $t2, 10 #how many numbers there are ##CHANGE
loop2:
li $v0, 1
lw $a0, 0($t0)
syscall
beq $t1, $t2, np_break #last number so no comma
li $v0, 11
li $a0, ','
syscall
li $v0, 11
li $a0, ' '
syscall
addi $t0, $t0, 4
addi $t1, $t1, 1
ble $t1, $t2, loop2
jr $ra

np_break:
jr $ra

iteration_loop:
la $t0, numbers
li $s6, 1 #It's a flag if we have changed anything this time 0 means nothing changed.
li $t2, 9 #We will have to perform 9 comparisons ##CHANGE
loop3:
lw $t6, 0($t0)
#addi $t5, $t0, 4
lw $t7, 4($t0) #next element
bgt $t6, $t7, swap
here:
addi $t0, $t0, 4
addi $t2, $t2, -1
beq $0, $t2, iteration_finish
j loop3 #if the loop did not finish, do it again.

swap:
sw $t7, 0($t0)
sw $t6, 4($t0)
li $s6, 0
j here

iteration_finish:
blt $0, $s6, end #if s6 is 1, no swap performed hence this branch should be taken
jr $ra

end:
li $v0, 4
la $a0, after
syscall
jal number_printing
li $v0, 11
li $a0, '\n'
syscall
li $v0, 10
syscall




	
