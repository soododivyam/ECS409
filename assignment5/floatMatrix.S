.data
instruction: .asciiz "Welcome to matrix multiplication. Please note that everything will be done in row major form."
matA: .asciiz "Please enter the 9 numbers of first matrix:"
matB: .asciiz "Please enter the 9 numbers of second matrix:"
matC: .asciiz "The output matrix is: "

.align 3
A:  .space 72

.align 3
B:  .space 72

.align 3
C:  .space 72


.globl _start
.text
_start:
main:
li $v0, 4
la $a0, instruction
syscall
li $v0, 4
la $a0, matA
syscall
la $s0, A
li $s1, 0
li $s2, 9 #How many values we reading.
jal read_matrix
#matrix A read, now B
li $v0, 4
la $a0, matB
syscall
la $s0, B
li $s1, 0
jal read_matrix
li $v0, 10
syscall

read_matrix:
li $v0, 7
syscall
sdcl $f12, 0($s0)
addi $s0, $s0, 8
blt $s1, $s2, read_matrix
jr $ra


