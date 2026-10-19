#Countdown

.data
ent: .asciiz "Please enter the start of the Countdown:"

.text
main:
li $v0, 4
la $a0, ent
syscall

li $v0, 5
syscall

move $s0, $v0

loop:
li $v0, 1
move $a0, $s0
syscall
li $v0, 11
li $a0, 10
syscall
addi $s0, $s0, -1
bne $s0, $0, loop
li $v0, 10
syscall
