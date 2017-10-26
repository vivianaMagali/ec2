global _start

_start:	movia sp, 0x007FFFFC /* inicializar pila */
		movia r2, 0x10000050 /* carga base botones (pushbuttons) */
		movi r3, 0b0110 /* habilita que KEY1 y KEY2 interrumpan */
		stwio r3, 8(r2) /* se carga en registro del puerto */
		movi r2, 0b010 /* habilitar interrupción IRQ#1 */
		wrctl ienable, r2 /* se carga en registro de control NIOS II */
		movi r2, 1 /* habilitar sistema interrupciones en procesador */
		wrctl status, r2 /* se carga en registro de control NIOS II */
		movia r2, 0x10000000 /* inicializar los leds rojos */
		addi r3,r0,1
		stwio r3, 0(r2)
		
LED: 	call ENCIENDE
		br LED /* bucle infinito */
		
		.section .reset, "ax"
		movia r2, _start /* regresar al comienzo del programa principal */
		jmp r2
		.end