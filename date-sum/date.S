#include "avrx.h"
#include "defs.h"

CSEG

TABLA_DIAS: DB 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

.global date_add
date_add:

	ldi ZH, HIGH(TABLA_DIAS)
	ldi ZL, LOW(TABLA_DIAS)

	; copy all the values
	; into the new ones
	; so as to have them
	; in case no changes are
	; required
	mov NF_DIAS, F_DIAS
	mov NF_MES, F_MES
	mov NF_ANIO, F_ANIO

	; add DIAS to NF_DIAS
	add NF_DIAS, DIAS

	; test if the new days
	; are grater than the
	; days in the current month
	add ZL, NF_MES
	clr r0
	adc ZH, r0
	sbiw Z, 1
	lpm r23, Z

	cp NF_DIAS, r23
	brlo finish
	breq finish

	; substract moth's days
	; to the current days
	; to obtain the extra days
	; Theese ones will be the
	; new days
	sub NF_DIAS, r23

	; in this case add 1
	; to the new month
	inc NF_MES

	; test if NF_MES is grater
	; than 12
	cpi NF_MES, 12
	brlo finish
	breq finish

	; in this case add 1
	; to NF_ANIO and load
	; into NF_MES the first month
	ldi NF_MES, 1
	inc NF_ANIO

finish:
	ret

