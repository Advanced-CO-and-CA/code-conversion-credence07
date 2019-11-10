/**********************************************************************************
* file: ascii_to_hex_cs18m532.s                                                   *
* Assembly code to convert the char of its ascii value to hex                     *
***********************************************************************************/

@ bss section
.bss


@ data section
.data
A_DIGIT:		.word 0x43
H_DIGIT:		.word 0x00

@ text section
.text

.global _main

_main:
    ldr r0, =A_DIGIT		@ load address of A_DIGIT
	ldr r1, [r0]    		@ load value at the address
	
	sub r1, #'0' 			@ subtract with '0'
	cmp r1, #0x0A 			@ compare with 0x0A
	blt	val_return      	@ if the value is less than 10 i.e it is between 0-9 hence return the value
	
	ldr r1, [r0]			@ load value again to check if its Char  
	add r1, #-'A'+0xA       @ subtract value of 'A' to get the hex 
val_return:
	ldr r2, =H_DIGIT		@ load the address of H_DIGIT
	str r1, [r2]			@ store the value on the address
exit:   
   .end