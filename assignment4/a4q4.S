#Triangle

.data
ent: .asciiz "Please enter the k:"

.text
main:
li $v0, 4
la $a0, ent
syscall
li $v0, 5
syscall

move $s0, $v0 #k
addi $s1, $s0, -1 #k-1
li $s7, 0 #counter of how many lines, will go till k

#3 loops: one to print spaces, one to print ascending number, one to print descending number. whole thing wrapped in a bigger loop.

big:
bge $s7, $s0, exit
sub $t0, $s0, $s1 #the maximum number (numerically) in the line

li $t1, 1
spaces:
beq $s1, $0, after_spaces
li $v0, 11
li $a0, ' '
syscall
addi $t1, $t1, 1
ble $t1, $s1, spaces


after_spaces:
li $t1, 1
asc:
li $v0, 1
move $a0, $t1
syscall
addi $t1, $t1, 1
ble $t1, $t0, asc

addi $t1, $t1, -2 #we have to start printing the descending numbers from here
dsc:
ble $t1, $0, blu
li $v0, 1
move $a0, $t1
syscall
addi $t1, $t1, -1
j dsc


blu:
#big loop updation (blu)
li $v0, 11
li $a0, 10 #ASCII for newline character
syscall
addi $s7, $s7, 1
addi $s1, $s1, -1
j big


exit:
li $v0, 10
syscall
