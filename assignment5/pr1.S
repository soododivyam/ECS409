.data
A: .asciiz "Amrit"
B: .asciiz "Bobby"
C: .asciiz "Chudan"
D: .asciiz "Devar"
E: .asciiz "Eashna"
F: .asciiz "Fathima"
names: .word A, B, C, D, E, F
marks: .word 1, 2, 3, 4, 
 .word 11, 12, 13, 14, 
 .word 21, 22, 23, 24,
 .word 31, 32, 33, 34, 
 .word 41, 42, 43, 44,
 .word 51, 52, 53, 54

prompt: .asciiz "Enter Student Name:"
no_love: .asciiz "Student name is not matched"
marks_is: .asciiz "The marks of student is as follows:\n"
phy: .asciiz "Physics: "
chm: .asciiz "Chemistry: "
mth: .asciiz "Mathematics: "
bio: .asciiz "Biology: "

input: .space 40

.text
.global _start
_start:
main:
li $v0, 4
la $a0, prompt
syscall

#read name
li $v0, 8
la $a0, input
li $a1, 39
syscall

li $s7, 6 #counter
li $s0, 1 #this is our flag turns to zero if name found
#compare string bitwsie

la $s1, names #the array of names we consider against
nextNameCheck:
beq $s0, $0, printMarks
lw $t2, 0($s1)
la $t3, input
###printing name we are comparing against
#li $v0, 4
#move $a0, $t2
#syscall
###end check
allNameLoop:
lb $t0, 0($t2)
lb $t1, 0($t3)
bne $t0, $t1, nomatch
addi $t2, $t2, 1
addi $t3, $t3, 1
j allNameLoop



nomatch:
#either they are differnt, or one is \0 and other is newline.
li $t5, '\0' #doing something wrong here?
li $t6, '\n'
bne $t0, $0, fock
bne $t1, $t6, fock
#we have found a matching name
j nameMatch

fock:
#we have to check next name now
addi $s7, $s7, -1 #decrement counter
addi $s1, $s1, 4 #jump to next name
bgt $s7, $0, nextNameCheck
j endGame

nameMatch:
move $s0, $0
j nextNameCheck

printMarks:
li $v0, 4
la $a0, marks_is
syscall
li $t0, 6
sub $t0, $t0, $s7 #now t0 has the index of name
sll $t1, $t0, 4
la $t0, marks
add $t0, $t0, $t1 #now t0 has the physics marks

li $v0, 4
la $a0, phy
syscall
li $v0, 1
lw $a0, 0($t0)
syscall
li $v0, 11
li $a0, 10
syscall
addi $t0, $t0, 4

li $v0, 4
la $a0, chm
syscall
li $v0, 1
lw $a0, 0($t0)
syscall
li $v0, 11
li $a0, 10
syscall
addi $t0, $t0, 4

li $v0, 4
la $a0, mth
syscall
li $v0, 1
lw $a0, 0($t0)
syscall
li $v0, 11
li $a0, 10
syscall
addi $t0, $t0, 4

li $v0, 4
la $a0, bio
syscall
li $v0, 1
lw $a0, 0($t0)
syscall
li $v0, 11
li $a0, 10
syscall
addi $t0, $t0, 4

j bye


endGame:
li $v0, 4
la $a0, no_love
syscall
j bye

bye:
li $v0, 10
syscall





