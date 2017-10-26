global _start

_start:	movia r2, 0x10000020 /* dir base displays */
		movia r3, 0x10000050 /* dir base botones */
		addi r6, r0, 0x3F /* valor inicial 0 del display */
		
LOOP2: 	stwio r6, 0(r2) /* mostrar en el display */
LOOP: 	ldwio r4, 0(r3) /*leer estado botones */

		addi r5, r0, 2 /* hay botón pulsado ?*/
		beq r4, r5, BOTON_1
		slli r5, r5, 1
		beq r4, r5, BOTON_2
		slli r5, r5, 1
		beq r4, r5, BOTON_3
		br LOOP
		
BOTON_1: addi r6, r0, 0x6 /* r6=valor a mostrar */
		br LOOP2
		
BOTON_2: addi r6, r0, 0x5B
		br LOOP2
		
BOTON_3: addi r6, r0, 0x4F
		br LOOP2
		.end