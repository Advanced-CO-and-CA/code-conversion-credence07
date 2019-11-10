/************************************************************************************
* file: ascii_to_bin_cs18m532.s                                                     *
* Assembly code to convert eight ASCII characters in the variable STRING to 8-bit   *
* binary number in the variable NUMBER                                              *
************************************************************************************/

@ bss section
.bss


@ data section
.data
STRING: .byte '1', '1', '0', '1' , '0', '1', '1', '0'
NUMBER: .word 0x00
ERROR : .word 0xFF

@text section
.text

.globl main

_main:

	ldr r0, =STRING		@ load start address of the string
	mov r1, #8 			@ r1 to hold the count for the loop
	mov r2, #0			@ r2 to hold the bin represetation of the string
loop:
	subs r1, #1			@ reduce the iterator
	bmi  ret_val
	
	ldrb r3, [r0], #1	@ load the bytes to compare
	sub  r3, #'0'       @ get the value after subtracting char 0
	cmp  r3, #1			@ compare to 1 to check if it represents binary
	
	bgt	 set_err
	
	orr  r2, r3, lsl r1	@ or the value with r2 based as the index
	b loop				@ continue till the iterator is done
set_err:
	ldr r4, =NUMBER		@ load the address of number
	mov r5, #0		
	str r5, [r4]		@ clear the data in the address
	b exit
ret_val:
	ldr r4, =ERROR		@ load the address of ERROR
	mov r5, #0			@ Clear the error value
	str r5, [r4]		
	ldr r4, =NUMBER		@ load the address of NUMBER
	str r2, [r4]		@ store the value at the address
exit:   
   .end