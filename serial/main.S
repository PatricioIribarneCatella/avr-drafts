#include "avrx.h"
#include "serial.h"

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

	call serial_init

loop:
	ldi r16, 'a'
	call serial_transmit	

	rcall delay_1

	rjmp loop


.global delay_1
delay_1:

        ldi r16, 60
startLoop3:
        ldi r17, 255
startLoop2:
        ldi r18, 255
startLoop1:
        dec r18
        brne startLoop1
outWhile1:        
        dec r17
        brne startLoop2
outWhile2:
        dec r16
        brne startLoop3
outWhile3:
        ret

