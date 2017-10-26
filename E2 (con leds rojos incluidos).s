.global _start

_start:
		movia r14, 0x10000000 
		movia r17, 0x10000010
		movia r15, 0x15555	
		movia r16, 0x2AAAA
		movia r18, 0b01010101
		movia r19, 0b10101010	
loop:
		movia r3, 1000000
		stwio r15, 0(r14)
		stwio r18, 0(r17)
		call Retardo
		movia r3, 1000000
		stwio r16, 0(r14)
		stwio r19, 0(r17)
		call Retardo
		br loop


Retardo: subi r3,r3,1
		bne r3, r0, Retardo
		ret