# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.data
int1: .asciiz "Enter the first integer please:"
int2: .asciiz "Enter the second integer please:"
store: .asciiz "The integers are stored at $s0 and $s1. Please see the registers to see them being swapped."
mess: .asciiz "Integers have been swapped, please check."
s0: .asciiz "\n\nRight now, value of $s0 is "
s1: .asciiz "\nRight now, value of $s1 is "

.text
.globl _start
_start:
main:
li $v0, 4
la $a0, int1
syscall
li $v0, 5
syscall
move $s0, $v0

li $v0, 4
la $a0, int2
syscall
li $v0, 5
syscall
move $s1, $v0

jal print

#jal temp
jal print

#jal add_sub
jal print

#jal mul_div
jal print

jal bitwise
jal print

li $v0, 10
syscall

print:
	li $v0, 4
	la $a0, s0
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, s1
	syscall
	li $v0, 1
	move $a0, $s1
	syscall	
	jr $ra

temp:
move $t0, $s0
move $s0, $s1
move $s1, $t0
jr $ra

add_sub:
add $s0, $s0, $s1 #a <- a + b
sub $s1, $s0, $s1 #b <- a+b - b
sub $s0, $s0, $s1 #a <- a+b-a
jr $ra

mul_div:
mult $s0, $s1
mflo $s0 #ab
div $s0, $s1
mflo $s1 #s1 has a $s0 has ab
div $s0, $s1
mflo $s0
jr $ra

bitwise:
xor $s0, $s0, $s1
xor $s1, $s0, $s1
xor $s0, $s0, $s1
jr $ra
