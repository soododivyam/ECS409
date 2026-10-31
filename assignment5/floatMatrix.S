.data
instruction: .asciiz "Welcome to matrix multiplication. Please note that everything will be done in row major form."
matA: .asciiz "Please enter the 9 numbers of first matrix:"
matB: .asciiz "Please enter the 9 numbers of second matrix:"
matC: .asciiz "The output matrix is: "
pro1: .asciiz "Starting with the multiplication"

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
#read both matrix
li $v0, 4
la $a0, pro1
syscall
#In a3, starting index of a matrix
#In a1, starting index of B matrix
#in a2, index of C matrix element
la $a3, A
la $a1, B
la $a2, C
jal calc

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc

addi $a3, $a3, 24
addi $a1, $a1, -16
addi $a2, $a2, 8
jal calc #c21

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc #c22

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc #c23

addi $a3, $a3, 24
addi $a1, $a1, -16
addi $a2, $a2, 8
jal calc #c31

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc #c32

addi $a1, $a1, 8
addi $a2, $a2, 8
jal calc #c33

#Calculation is done, now I want to display the content 
#In a3, starting index of A matrix
#In a1, starting index of B matrix
#in a2, index of C matrix element
li $v0, 11
li $a0, 10 #newline
syscall
la $a3, A
la $a1, B
la $a2, C
jal printRow
li $v0, 11
li $a0, 10
syscall

li $t0, 24
add $a3, $a3, $t0
add $a2, $a2, $t0
add $a1, $a1, $t0
jal printRow
li $v0, 11
li $a0, 10
syscall

li $t0, 24
add $a3, $a3, $t0
add $a2, $a2, $t0
add $a1, $a1, $t0
jal printRow

li $v0, 10
syscall

read_matrix:
li $v0, 7
syscall
sdc1 $f0, 0($s0)
addi $s0, $s0, 8
addi $s1, $s1, 1
blt $s1, $s2, read_matrix
jr $ra

calc:
li $t0, 0
ldc1 $f0, 0($a3)
ldc1 $f2, 0($a1)
mul.d $f4, $f0, $f2
ldc1 $f6, 8($a3)
ldc1 $f8, 24($a1)
mul.d $f10, $f6, $f8
add.d $f12, $f4, $f10
ldc1 $f0, 16($a3)
ldc1 $f2, 48($a1)
mul.d $f4, $f0, $f2
add.d $f12, $f4, $f12
sdc1 $f12, 0($a2)
li $v0, 11
li $a0, '.'
syscall
jr $ra

printRow:
li $v0, 11
li $a0, '|'
syscall
li $t0, 3
move $t1, $a3
loop:
li $v0, 3
ldc1 $f12, 0($t1)
syscall
li $v0, 11
li $a0, ' '
syscall
addi $t0, $t0, -1
addi $t1, $t1, 8
bne $t0, $0, loop
li $v0, 11
li $a0, '|'
syscall
li $v0, 11
li $a0, 9 #tab spacing
syscall
li $v0, 11
li $a0, '|'
syscall
li $t0, 3
move $t1, $a1
loop2:
li $v0, 3
ldc1 $f12, 0($t1)
syscall
li $v0, 11
li $a0, ' '
syscall
addi $t0, $t0, -1
addi $t1, $t1, 8
bne $t0, $0, loop2
li $v0, 11
li $a0, '|'
syscall
li $v0, 11
li $a0, 9 #tab spacing
syscall
#starting with c now
li $v0, 11
li $a0, '|'
syscall
li $t0, 3
move $t1, $a2
loop3:
li $v0, 3
ldc1 $f12, 0($t1)
syscall
li $v0, 11
li $a0, ' '
syscall
addi $t0, $t0, -1
addi $t1, $t1, 8
bne $t0, $0, loop3
li $v0, 11
li $a0, '|'
syscall
jr $ra






