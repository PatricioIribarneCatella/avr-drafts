#include "avrx.h"

DSEG
V: BYTE SIZE
M: BYTE 1

CSEG
ORG _VECTORS_SIZE
	rjmp main

.global main
main:
	; Write
	;sbi _SFR_IO_ADDR(DDRB), 3
	;cbi _SFR_IO_ADDR(DDRB), 0
	;cbi _SFR_IO_ADDR(DDRB), 1
	; Read
	;cbi _SFR_IO_ADDR(DDRB), 2
	
	; put 0x8 directly into DDRB
	ldi r1, 0x8
	out _SFR_IO_ADDR(DDRB), r1

	; read PORTB
	in r16, _SFR_IO_ADDR(PORTB)
	
loop_one:
	mov r17, r16&0x1
	breq loop_one



	ldi XH, HIGH(V)
	ldi XL, LOW(V)

	call load

	ldi XH, HIGH(V)
	ldi XL, LOW(V)

	call average

	ldi YH, HIGH(M)
	ldi YL, LOW(M)

	st Y, ACUM2

here: rjmp here

