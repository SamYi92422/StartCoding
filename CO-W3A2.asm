	.data
string: .space    50
text1:  .asciiz   "Success! Location: "
text2:  .asciiz   "Fail! \n"
return: .asciiz   "\n"
qst:    .asciiz   "?"

	.text
getString:
	li $v0, 8
	la $a0, string
	li $a1, 50
	move $t8, $a0
	syscall
	# $t8 = address of the string
	# $a1 = maximum number of string

getChar:
	li $v0, 12
	syscall
	move $t0, $v0
	# $t0 = character to be matched
	
	#print "\n"
	li $v0, 4
	la $a0, return
	syscall
	
	# if enter "?", quit
	li $t1, 63
	beq $t1, $t0, quit
	
	
	# initialize $k0 to 0
	move $a2, $t8
	li $k0, 0
	
compare:
	# get one character of the string, once at a time
	lb $s0, ($a2)
	addi $a2, $a2, 1
	addi $k0, $k0, 1
	
	# if it is the end of the string, fail
	li $t1, 10
	beq $t1, $s0, fail
	
	# compare the input character and the current character of the string
	beq $s0, $t0, success
	j compare
	
fail:
	# print the text "Fail! \n"
	li $v0, 4
	la $a0, text2
	syscall
	j getChar

success:
	# print the text "Success! Location: "
	li $v0, 4
	la $a0, text1
	syscall
	# print the location
	li $v0, 1
	move $a0, $k0
	syscall
	# print the "\n"
	li $v0, 4
	la $a0, return
	syscall
	j getChar
	
quit:
	li $v0, 10
	syscall