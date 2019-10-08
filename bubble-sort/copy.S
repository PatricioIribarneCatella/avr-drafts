#include "defs.h"

.global copy
copy:
	ldi r19, SIZE

loop:	ld r18, X+
	st Y+, r18
	dec r19
	brne loop

	ret

