#include "avrx.h"
#include "ff.h"

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
	
	clr r17

	; set the first value for Q
	ldi QVALUE, 0x1

	; obtain what it is already
	; in DDRB register for
	; previous configuration
	in r16, _SFR_IO_ADDR(DDRB)

	; put 1 in Q position
	ldi r17, (1<<Q)
	ori r16, (1<<Q)

	; put 0 in J|K|CLK positions
	andi r16, ~(((1<<CLK)|(1<<K)|(1<<J)))

	; store the new configuration
	; in  DDRB
	out _SFR_IO_ADDR(DDRB), r16

high:
	; tests for high input in
	; PINB[0] register
	sbic _SFR_IO_ADDR(PINB), CLK
	rjmp high

low:
	; tests for low input in
	; PINB[0] register
	; and when it changes
	; low -> high, it calls
	; the Flip-Flop algorithm
	sbis _SFR_IO_ADDR(PINB), CLK
	rjmp low
	call ffjk
	rjmp high

