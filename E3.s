.global _start

_start:		addi r5, r0, 3
			movia r2, 0x10000020
			addi r3, r0, 0x3F
			stw r3, 0, r2
			
Bucle:		slli r3, r3, 8
			stw r3, 0(r2)
			subi r5, r5, 1
			subi sp, sp, 4
			stw ra, 0(sp)
			movia r4, 1000000
			call retraso
			ldw ra, 0(sp)
			addi sp, sp, 4
			bne r5, r0, bucle
			br _start
			
retraso:	subi r4, r4, 1
			bne r4, r0, retraso
			ret