.global _start

_start:		movia r2, 0x10001000 #Dirección base de la JTAG
			movia sp, 0x007FFFFC	#Inicializamos la pila
			movia r6, 0x20		#Caracter para + o - letra
			movia r7, 0x61		#a
			movia r8, 0x7a		#z
			movia r9, 0x41		#A
			movia r10, 0x5a		#Z

Bucle1:		ldwio r4, 0(r2)		#Leo registro de estado de JTAG
			andi r8, r4, 0x8000	#Compruebo si hay datos (RValid = 1)
			beq r8, r0, Bucle1
			
			andi r5, r4, 0xFF	#Leo registro de datos
			call caracter
			br Bucle1
			
caracter:	subi sp, sp, 4
			stw r5, 0(sp)
			blt r5, r7, verificar
			bgt r5, r8, reset	#reset o bucle2??
			sub r5, r5, r6
			br Bucle2
			
			#Si no es minúscula, compruebo si es mayúscula
verificar:	blt r5, r9, reset	#reset o bucle2??
			bgt r5, r10, reset	#reset o bucle2??
			add r5, r5, r6
			
Bucle2:		ldw r4, 4(r2)
			andhi r4, r4, 0xFFFF #Compruebo si queda espacio disponible
			beq r4, r0, Bucle2 #Si r4 = 0, no hay espacio, y no puedo procesar el caracter

reset:		stwio r5, 0(r2)	#Envío el caracter al puerto
			ldw r5, 0(sp)
			addi sp, sp, 4
			ret