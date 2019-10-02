#include "avrx.h"
#include "defs.h"

DSEG
V: BYTE SIZE
M: BYTE 1

CSEG
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
	
	; config external interrupt 0
	in r16, EICRA
	andi r16, ~((1<<ISC01)|(1<<ISC00))
	ori r16, (1<<ISC01)|(0<<ISC00)
	out EICRA, r16
	
	; enable external interrupt 0
	in r16, _SFR_IO_ADDR(EIMSK)
	ori r16, (1<<INT0)
	out _SFR_IO_ADDR(EIMSK), r16

	; enable global interruption
	sei

	; do main routine

here: rjmp here

.global INT0_vect
INT0_vect:
	; do interrupt handler
	reti

