.global ENCIENDE

ENCIENDE:	subi sp, sp, 16 /* guardar registros en la pila */
			stw ra, 4(sp)
			stw r2, 8(sp)
			stw r3, 12(sp)
			stw r4, 16(sp)
			movia r2, 0x10000000 /* inicializar los leds rojos */
			movia r3, 50000 /* inicializar cuenta para el retardo temporal */
RETARDO: 	subi r3,r3,1
			bne r3, r0, RETARDO /* bucle de retardo temporal */
			
			ldwio r3, 0(r2) /* obtener valor actual de los leds */
			ldw r4, DIRECCION(r0) /* obtener la dirección de movimiento */
			bne r4,r0,DER /* salta si DIRECCION=1 , movimiento a derecha */
			slli r3,r3,1 /* desplaza el bit de encendido de los leds a la izquierda */
			movia r4,0x40000
			bne r3,r4,FIN /* comprueba si estaba encendido el led 18 */
			movi r3,1 /* empieza de nuevo con el led menos significativo */
			br FIN /* salto a la parte final de la rutina */
			
DER: 		srli r3,r3,1 /* desplaza el bit de encendido de los led a la derecha */
			bne r3,r0,FIN /* salto si estaba encendido el led 1 */
			movia r3,0x20000 /* empieza de nuevo con el led mas significativo */
			
FIN: 		stwio r3, 0(r2) /* enciende un led y apaga el resto */
			ldw ra, 4(sp) /* se recuperan registros de la pila */
			ldw r2, 8(sp)
			ldw r3, 12(sp)
			ldw r4, 16(sp)
			addi sp, sp, 16
			ret
			.end