#include "defs.h"

.global divide
divide:

	; clears T flag in SREG
	clt

	; if DIVISOR is equal to zero
	; the division can not
	; be done
	tst DIVISOR
	breq div_by_zero
	brlt divisor_neg

	tst DIVIDENDO
	brlt dividendo_neg

	rcall divide_unsigned

finish:
	ret

div_by_zero:
	
	; set T flag in SREG
	; to show div by "0"
	set
	rjmp finish

divisor_neg:

	; negates DIVISOR
	; and perform the unsigned
	; division
	neg DIVISOR

	rcall divide_unsigned

	neg COCIENTE

	rjmp finish

dividendo_neg:

	; negates DIVIDENDO
	; and perform the unsigned
	; division
	neg DIVIDENDO

	rcall divide_unsigned

	neg COCIENTE

	rjmp finish

divide_unsigned:

	clr COCIENTE

loop:
	inc COCIENTE

	sub DIVIDENDO, DIVISOR
	cp DIVIDENDO, DIVISOR
	
	brge loop

	mov RESTO, DIVIDENDO

	ret

