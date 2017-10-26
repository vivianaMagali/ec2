.global _start
_start:		movia r6, 0x10000040
			movia r2, 0x10000000
			movia r3, 0x3FFFF
			
bucle:		ldw r5, 0(r6)
			xor r4, r3, r6
			stw r4, 0(r2)
			br bucle