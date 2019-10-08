#include "avrx.h"
#include "defs.h"

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

	; load some numbers for
	; testing
	ldi DIVIDENDO, -20
	ldi DIVISOR, 5

	call divide

here: rjmp here

