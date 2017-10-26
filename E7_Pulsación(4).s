.global PULSACION

PULSACION:	subi sp, sp, 16 /* guardar registros en la pila */
			stw ra, 4(sp)
			stw r2, 8(sp)
			stw r3, 12(sp)
			stw r4, 16(sp)
			movia r2, 0x10000050 /* cargar la dirección base de los botones */
			ldwio r3, 0xC(r2) /* lee registro puerto y analiza qué boton generó interrupcion */
			stwio r0, 0xC(r2) /* reiniciar a 0 el registro de captura de interrupciones */
			andi r4,r3,0x2 /* comprobar botón KEY1 */
			beq r4,r0,BOTON2
			movi r4, 1
			stw r4, DIRECCION(r0)
			br FIN
			
BOTON2: 	andi r4,r3,0x4 /* comprobar botón KEY2 */
			beq r4,r0,FIN
			stw r0, DIRECCION(r0)
			
FIN: 		ldw ra, 4(sp) /* recuperar registros de la pila */
			ldw r2, 8(sp)
			ldw r3, 12(sp)
			ldw r4, 16(sp)
			addi sp, sp, 16
			ret
			.end