#include "avrx.h"
#include "defs.h"

#define C2 2

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
	; clean previous config in (ISC01 | ISC00)
	; then put ISC01=1 | ISC00=0
	; for falling edge detection
	; use pointer for addressing EICRA
	; because its in the Extended I/O
	; registers
	lds r16, EICRA
	andi r16, ~((1<<ISC01)|(1<<ISC00))
	ori r16, (1<<ISC01)|(0<<ISC00)
	sts EICRA, r16
	
	; enable external interrupt 0
	; by setting bit INT0=1
	in r16, _SFR_IO_ADDR(EIMSK)
	ori r16, (1<<INT0)
	out _SFR_IO_ADDR(EIMSK), r16

	; obtain what it is already
	; in DDRC register for
	; previous configuration
	; and put 1 in C2 position
	; for output
	sbi _SFR_IO_ADDR(DDRC), C2

	; enable global interruption
	sei

here: rjmp here

.global INT0_vect
INT0_vect:

	; save used registers
	; and SREG via in and
	; then push

	in INPUT, _SFR_IO_ADDR(PORTC)
	
	ldi r20, (1<<C2)
	eor INPUT, (1<<C2)

	out _SFR_IO_ADDR(PORTC), INPUT

	reti

