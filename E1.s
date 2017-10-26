.global _start

_start:
		movia r14, 0x10000000 
		movia r15, 0x15555	
		movia r16, 0x2AAAA	
loop:
		movia r3, 50000 
		stwio r15, 0(r14)
		call Retardo
		movia r3, 50000 
		stwio r16, 0(r14)
		call Retardo
		br loop


Retardo: subi r3,r3,1
		bne r3, r0, Retardo
		ret