.section .exceptions, "ax"
.global _manejador_interrupciones

_manejador_interrupciones:	stw et, 0(sp) /* guardar et en la pila */
							subi sp, sp, 4
							rdctl et, ctl4 /* leer registro de interrupciones pendientes */
							beq et, r0, noINT
							subi ea, ea, 4 /* interrupción activada, se decrementa ea */
							subi sp, sp, 12 /* guardar registros en la pila */
							stw ea, 4(sp)
							stw ra, 8(sp)
							stw r2, 12(sp)
							andi r2, et, 0b10 /* se comprueba si la interrupción botón se ha activado */
							beq r2, r0, FIN /* salta a FIN si no se ha activado interrupción IRQ #1 */
							call PULSACION /* IRQ#1 activada, salta a rutina descrita en la siguiente transparencia */
							
FIN: 						ldw ea, 4(sp) /* recuperar registros de la pila */
							ldw ra, 8(sp)
							ldw r2, 12(sp)
							addi sp, sp, 12
							noINT: addi sp,sp,4 /* recuperar et de la pila */
							ldw et,0(sp)
							eret
							.end