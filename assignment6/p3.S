# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder

.data
n: .asciiz "Enter n:"
r: .asciiz "Enter r:"
invalid: .asciiz "Invalid values for n and r. Please check"


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

factorial: #calculates factorial of number stored in $a0
move $t0, $a0
li $v1, 1
f_loop:
mult $v1, $t0
mflo 
addi $t0, $t0, -1
bgt $t0, $0, f_loop
jr $ra


wrong:
li $v0, 4
la $a0, invalid
syscall
j end

##END
end:
li $v0, 10
syscall
	
