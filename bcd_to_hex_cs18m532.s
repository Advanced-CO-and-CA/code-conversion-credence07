/**********************************************************************************
* file: bcd_to_hex_cs18m532.s                                                     *
* Assembly code to convert BCD value to Hex                                       *
***********************************************************************************/

@ bss section
.bss

@ data section
.data
BCDNUM: .word 0x92529679
NUMBER: .word 0

@text section
.text

.globl main

_main:

	ldr	   r0, =BCDNUM		@ load the address of BCDNUM
	ldr    r1, [r0]
	mov    r7, #0			@ initialise with 0
	mov    r2, #8			@ iterator for loop
	mov    r8, #0xF
	
loop:
	subs   r2, #1			@ subtract the iterator
	bmi	   ret_val	
	
	lsl	   r3, r2, #2       @ get the bits to be shifted left
	lsl    r4, r8, r3 	    @ mask to get the value for the current iterator
	
	and    r5, r1, r4		@ and r1 with mask and store in r5
	lsr	   r5, r3 			@ right shift to get the value

	mov    r6, r2			@ holds the current decimal place
mul_loop:
	subs   r6, #1
	bmi    break_mul_loop
	mov    r3, #10
	mul    r5, r5, r3		@ multiply by 10 for the given decimal places
	b      mul_loop
	
break_mul_loop:
    add   r7, r5			@ add for all the nibble in process
	b 	  loop

ret_val:
	ldr   r0, =NUMBER		@ load the address for the result
	str   r7, [r0]			@ store the result

exit:   
   .end
