#C code copy

.data

.text
main:
li $s0, 1 #J
li $s1, 0 #a

li $t0, 20

while:
bgt $s1, $t0, dowhile
addi $s0, $s0, 1
addi $s1, $s1, 2
j while

dowhile:
li $t0, 100
addi $s0, $s0, 1
bge $s0, $t0, subi
j dowhile

subi:
ble $s1, $0, end
addi $s0, $s0, -1
addi $s1, $s1, -1
j subi

end:
li $v0, 10
syscall

