#include "defs.h"

.global inspect
inspect:

	ldi r16, SIZE

loop:
	ld r18, Y+
	dec r16
	brne loop

	ret

