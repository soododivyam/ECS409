.data
A: .asciiz "Amrit"
B: .asciiz "Bobby"
C: .asciiz "Chudan"
D: .asciiz "Devar"
E: .asciiz "Eashna"
F: .asciiz "Fathima"
names: .word A B C D E F
marks: .word 1, 2, 3, 4, 
11, 12, 13, 14, 
21, 22, 23, 24,
31, 32, 33, 34, 
41, 42, 43, 44,
51, 52, 53, 54

input_prompt: .asciiz "Enter Student Name:"
no_love: .asciiz "Student name is not matched"
marks_is: .asciiz "The marks of student is as follows:"
phy: .asciiz "Physics: "
chm: .asciiz "Chemistry: "
mth: .asciiz "Mathematics: "
bio: .asciiz "Biology: "


.globl _start
.text
_start:
main:
li $v0, 4
la $a0, prompt
syscall





