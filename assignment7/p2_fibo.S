.data
welcome: .asciiz "Welcome to fibonnaci with stack! \n"
out: .asciiz " element in fibonnaci series is "
overflow: .asciiz " element in fibonnaci series cannot be generated, Overflow condition occurs in this case."
input: .asciiz "Enter N:"

.text
main:
li $v0, 4
la $a0, welcome
syscall

li $v0, 4
la $a0, input
syscall

li $v0, 5
syscall

addi $sp, $sp, -4
sw $v0, 0($sp)

move $a0, $v0
li $v0, 1
syscall

jal fibo #now we have answer on top of stack
lw $t0, 0($sp)
ble $t0, $0, overflow_condt
li $v0, 4
la $a0, out
syscall
li $v0, 1
move $a0, $t0
syscall
j end



overflow_condt:
	li $v0, 4
	la $a0, overflow
	syscall
	j end





fibo:
	lw $t0, 0($sp)
	li $t1, 60
	bgt $t0, $t1, flow
	li $t3, 0 #initial
	li $t4, 1 #initial
	addi $t0, $t0, -2 #first 2 numbers are already defined inital conditions
	loop_start:
		ble $t0, $0, loop_over
		add $t5, $t3, $t4
		move $t3, $t4
		move $t4, $t5
		addi $t0, $t0, -1
		j loop_start
	
loop_over:
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	jr $ra
	
flow: #We have to return a value instead of this
	addi $sp, $sp, -4
	li $t0, -1
	sw $t0, 0($sp)
	jr $ra
	
end:
	li $v0, 11
	li $a0, 10
	syscall
	li $v0, 10
	syscall
	