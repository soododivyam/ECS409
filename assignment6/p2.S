# Use .set noreorder to prevent the assembler from filling branch
# delay slots, if you want to fill delay slots manually.
# .set noreorder


.data
string1: .asciiz "Enter the first string: "
string2: .asciiz "Enter the second string: "
character: .asciiz "Enter the character you want to check for: "
c1: .asciiz "Length of first string: "
c2: .asciiz "Length of second string: "
s1: .space 9
s2: .space 9

p1: .asciiz "Input character is "
p2a: .asciiz "present "
p2b: .asciiz "not present "
p3: .asciiz "in the "
p4a: .asciiz "first string."
p4b: .asciiz "second string."

f1: .asciiz "First concatenated string: "
f2: .asciiz "Second concatenated string: "



.text
_start:
main:
li $v0, 4
la $a0, string1
syscall
li $a1, 8
li $v0, 8
la $a0, s1
syscall

li $v0, 4
la $a0, string2
syscall
li $a1, 8
li $v0, 8
la $a0, s2
syscall

li $v0, 4
la $a0, character
syscall
li $v0, 12
syscall
move $s0, $v0
li $v0,11
li $a0, 10
syscall #newline

#We now have all user input
#now to remove the enter character (ASCII 10) from input
la $a0, s1
li $a1, 10
jal remove_newline

la $a0, s2
li $a1, 10
jal remove_newline

la $a0, s1
jal compute_length #v1 stores count
li $v0, 4
la $a0, c1
syscall
move $a0, $v1
li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall #newline

la $a0, s2
jal compute_length #v1 stores count
li $v0, 4
la $a0, c2
syscall
move $a0, $v1
li $v0, 1
syscall
li $v0, 11
li $a0, 10
syscall #newline

#now we search
la $a0, s1
la $a3, p4a #first
move $a1, $s0
jal search_character

la $a0, s2
la $a3, p4b #first
move $a1, $s0
jal search_character

la $a1, s1
la $a2, s2
la $a3, f1
jal concat_string

la $a1, s2
la $a2, s1
la $a3, f2
jal concat_string


##EXIT
li $v0, 10
syscall


remove_newline:
	move $t0, $a0
	contt:		
		lb $t6, 0($t0)
		beq $t6, $a1, exitt
		addi $t0, $t0, 1	
		j contt
	exitt:
		sb $0, 0($t0)
		jr $ra

compute_length:
	li $t0, 0
	move $t1, $a0
	cont:
		lb $t3, 0($t1)
		beq $t3, $0, exit
		addi $t1, $t1, 1
		addi $t0, $t0, 1 #increment counter
		j cont
	exit:
		move $v1, $t0
		jr $ra
	

search_character:
	move $t0, $a0
	li $v0, 4
	la $a0, p1
	syscall
	conts:
		lb $t3, 0($t0)
		beq $t3, $a1, found
		addi $t0, $t0, 1
		beq $t3, $0, not_found
		j conts
	found:
		li $v1, 1
		li $v0, 4
		la $a0, p2a
		syscall
		li $v0, 4
		la $a0, p3
		syscall
		li $v0, 4
		move $a0, $a3
		syscall
		li $v0, 11
		li $a0, 10
		syscall
		jr $ra
	not_found:
		li $v1, 0
		li $v0, 4
		la $a0, p2b
		syscall
		li $v0, 4
		la $a0, p3
		syscall
		li $v0, 4
		move $a0, $a3
		syscall
		li $v0, 11
		li $a0, 10
		syscall
		jr $ra

concat_string:
	li $v0, 4
	move $a0, $a3
	syscall	
	li $v0, 4
	move $a0, $a1
	syscall
	li $v0, 4
	move $a0, $a2
	syscall
	li $v0, 11
	li $a0, 10
	syscall
	jr $ra
	
