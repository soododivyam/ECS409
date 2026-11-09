# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

#As discussed with sir, proceeding with the assumption that no value overflows. all integers fit into signed 32 bit

.data
n: .asciiz "Enter n:"
r: .asciiz "Enter r:"
invalid: .asciiz "Invalid values for n and r. Please check\n"
p: .asciiz "nPr == "
c: .asciiz "nCr == "


.text
.global _start
_start:
main:
li $v0, 4
la $a0, n
syscall
li $v0, 5
syscall
move $s0, $v0 #n
li $v0, 4
la $a0, r
syscall
li $v0, 5
syscall
move $s1, $v0 #r
bgt $s1, $s0, wrong
#Now we have values of n & r

#print permutations
li $v0, 4
la $a0, p
syscall
move $a1, $s0
move $a2, $s1
jal perms
move $a0, $v1
li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall

#print combinations
li $v0, 4
la $a0, c
syscall
move $a1, $s0
move $a2, $s1
jal combs
move $a0, $v1
li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall

j end

factorial: #calculates factorial of number stored in $a0, returns in $v1
	move $t0, $a0
	li $v1, 1
	beq $a0, $0, special
	f_loop:
		multu $v1, $t0
		mflo $v1
		addi $t0, $t0, -1
		bgt $t0, $0, f_loop
		jr $ra
	special:
		li $v1, 1
		jr $ra
		
perms: #takes n in a1 and r in a2 returns in v1
	move $t9, $ra #save the ra from parent
	move $a0, $a1
	jal factorial
	move $t8, $v1
	sub $a0, $a1, $a2
	jal factorial
	move $t7, $v1
	divu $t8, $t7
	mflo $v1
	jr $t9
	


combs: ##takes n in a1 and r in a2 returns in v1
	move $t9, $ra #save the ra from parent
	move $a0, $a1
	jal factorial
	move $t8, $v1 #n!
	sub $a0, $a1, $a2
	jal factorial
	move $t7, $v1 #n-r!
	move $a0, $a2
	jal factorial
	move $t6, $v1 #r!
	divu $t8, $t7
	mflo $t8
	divu $t8, $t6
	mflo $v1
	jr $t9



wrong:
	li $v0, 4
	la $a0, invalid
	syscall
	j end

##END
end:
	li $v0, 10
	syscall
	
