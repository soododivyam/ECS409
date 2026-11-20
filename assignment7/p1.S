.data
input: .asciiz "Please enter your 10 numbers starting now:"
success: .asciiz "We now have the 10 numbers stored: "
reverse: .asciiz "In reverse order: "

.text
#.global _start
_start:
main:
	li $v0, 4
	la $a0, input
	syscall
	li $t1, 0
	li $t3, 10
	move $t0, $sp
	number_get_loop:
		li $v0, 5
		syscall
		sw $v0, 0($sp)
		addiu $sp, $sp, -4
		addi $t1, $t1, 1
		blt $t1, $t3, number_get_loop
	li $v0, 4
	la $a0, success
	syscall
	li $a1, -4 #increasing order
	move $sp, $t0
	jal print
	li $v0, 4
	la $a0, reverse
	syscall
	#Now if I make the stack pointer point to the end, 
	#and then $a1 is 4 I can print in reverse order
	addi $sp, $sp, -36
	li $a1, 4
	jal print
	
	j end

print:
	move $t0, $sp #saving value of $sp
	li $t1, 9
	print_start:
		beq $t1, $0, print_end
		li $v0, 1
		lw $a0, 0($sp)
		syscall
		li $v0, 11
		li $a0, ','
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		addu $sp, $sp, $a1
		addi $t1, $t1, -1
		j print_start
	print_end:
		li $v0, 1
		lw $a0, 0($sp)
		syscall
		li $v0, 11
		li $a0, 10
		syscall
		move $sp, $t0
		jr $ra
		
end:
	li $v0, 11
	li $a0, 10
	syscall
	li $v0, 10
	syscall



	