#include "avrx.h"
#include "defs.h"

DSEG
VEC: BYTE SIZE
VEC_ORD: BYTE SIZE

CSEG
ORG 0x0
	rjmp main

ORG _VECTORS_SIZE
.global main
main:
	; initialize the stack
	; pointer to RAMEND
	ldi r16, HIGH(RAMEND)
	out _SFR_IO_ADDR(SPH), r16
	ldi r16, LOW(RAMEND)
	out _SFR_IO_ADDR(SPL), r16
	
	ldi XH, HIGH(VEC)
	ldi XL, LOW(VEC)

	; load some testing
	; numbers
	call load

	ldi XH, HIGH(VEC)
	ldi XL, LOW(VEC)
	ldi YH, HIGH(VEC_ORD)
	ldi YL, LOW(VEC_ORD)

	; copies all the numbers
	; into the new vector
	; because the sorting method
	; is "in place"
	call copy

	call sort

	ldi YH, HIGH(VEC_ORD)
	ldi YL, LOW(VEC_ORD)

	call inspect

here: rjmp here

;--------------------------
;       BUBBLE-SORT
;--------------------------
.global sort
sort:

	clr r0
	clr I
	clr AUX
	clr A_J
	clr A_J_ONE

outter_loop:

	ldi YH, HIGH(VEC_ORD)
	ldi YL, LOW(VEC_ORD)

	clr J

inner_loop:

	ld A_J, Y+
	ld A_J_ONE, Y

	cp A_J, A_J_ONE

	brlo finish_inner_loop

	rcall swap

finish_inner_loop:

	inc J
	cpi J, MAX_J
	brlo inner_loop

	inc I
	cpi I, MAX_I
	brlo outter_loop

	ret

;--------------------------
;          SWAP
;--------------------------
.global swap
swap:
	sbiw Y, 1
	st Y+, A_J_ONE
	st Y, A_J

	ret

