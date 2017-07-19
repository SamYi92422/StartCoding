	.data
num:       
	.asciiz   "zero ","First ","Second ","Thrid ","Fourth ","Fifth ","Sixth ","Seventh ","Eighth ","Ninth "
n_offset:  
	.word     0, 6, 13, 21, 28, 36, 43, 50, 59, 67
cap_al:    
	.asciiz   "Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ","Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ","Mary ","November ","Oscar ","Paper ", "Quebec ","Research ","Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ","Yankee ","Zulu "
low_al:    
	.asciiz   "alpha ","bravo ","china ","delta ","echo ","foxtrot ","golf ","hotel ","india ","juliet ","kilo ","lima ","mary ","november ","oscar ","paper ", "quebec ","research ","sierra ","tango ","uniform ","victor ","whisky ","x-ray ","yankee ","zulu "
al_offset: 
	.word     0, 7, 14, 21, 28, 34, 43, 49, 56, 63, 71, 77, 83, 89, 99, 106, 113, 121, 131, 139, 146, 155, 163, 171, 178, 186
star:   .asciiz   "* "


	.text
input:
	# get the input character
	li $v0, 12
	syscall
	# compare ascii value, and find out the tyep of the input character
	# if $v0<48, jump to label 'other'
	slti $s0, $v0, 48    
	bnez $s0, other      
	# if $v0<58, jump to label 'number'
	slti $s0, $v0, 58    
	bnez $s0, number    
	# if $v0=63("?"), jump to label 'quit'
	add  $s0, $0, 63
	beq  $s0, $v0, quit     
	# if $v0<65 , jump to label 'other'
	slti $s0, $v0, 65    
	bnez $s0, other      
	# if $v0<91 , jump to label 'cap_case'
	slti $s0, $v0, 91   
	bnez $s0, cap_case  
	# if $v0<97 , jump to label 'other'
	slti $s0, $v0, 97   
	bnez $s0, other      
	# if $v0<123 , jump to label 'low_case'
	slti $s0, $v0, 123    
	bnez $s0, low_case  
	# other cases, go to label 'other'

other:
	# print '*'
	la $a0, star
	li $v0, 4
	syscall
	j input

number:
	# get the offset value of the number
	subi $t0, $v0, 48
	sll $t0, $t0, 2
	la $t1, n_offset
	add $t1, $t1, $t0
	lw $s1, ($t1)
	# $s1 = the offset value of the word
	la $a0, num
	add $a0, $a0, $s1
	# $a0 = the address of the word to be printed
	li $v0, 4
	syscall
	j input

cap_case:
	# get the offset value of the character
	subi $t0, $v0, 65
	sll $t0, $t0, 2
	la $t1, al_offset
	add $t1, $t1, $t0
	lw $s1, ($t1)
	# $s1 = the offset value of the word
	la $a0, cap_al
	add $a0, $a0, $s1
	# $a0 = the address of the word to be printed
	li $v0, 4
	syscall
	j input

low_case:
	# get the offset value of the character
	subi $t0, $v0, 97
	sll $t0, $t0, 2
	la $t1, al_offset
	add $t1, $t1, $t0
	lw $s1, ($t1)
	# $s1 = the offset value of the word
	la $a0, low_al
	add $a0, $a0, $s1
	# $a0 = the address of the word to be printed
	li $v0, 4
	syscall
	j input

quit:
	li $v0, 10
	syscall
