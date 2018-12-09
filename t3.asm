; Main.asm
; Name:Lian Fang Liu 
; UTEid: LL33978
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
	
	LD  R6, stackinitial

; set up the keyboard interrupt vector table entry

	LD   R0, isrstart	;r0 = x0180
	STI  R0, ivt		;stores x2600 at start of ivt

; enable keyboard interrupts

	LD   R0, stackinitial	;r0=x4000
	STI  R0, KBSR		;puts x4000 in KBSR (sets interrupt bit (14th bit) to 1)
; start of actual program

	AND  R1, R1, #0
	STI  R1, Buffer

startover	AND  R3, R3, #0
stopover	ADD  R5, R3, #0

loop	LDI  R0, Buffer
	BRz  loop
	TRAP x21
	AND  R1, R1, #0
	STI  R1, Buffer		;you have input in R0 still, but #0 is put back in x4600

	ADD R4, R3, #-1
	BRz checkstart2 

	ADD R4, R3, #-2
	BRz checkstart3

	ADD R4,R5,#-3
	BRz checkstop1

	ADD R4,R5,#-4
	BRz checkstop2
	
	ADD R4,R5,#-5
	BRz checkstop3

	ADD R4,R5,#-6
	BRz checkstoplast


	LD   R2, Aasciicomp
	ADD  R2, R2, R0
	BRnp loop
	ADD  R3, R3, #1
	BRnzp loop
	


stackinitial	.FILL	x4000
isrstart	.FILL	x2600
ivt		.FILL	x0180
KBSR		.FILL	xFE00
Buffer		.FILL	x4600
Aasciicomp	.FILL	x-41
Uasciicomp	.FILL	x-55
Gasciicomp	.FILL	x-47
pipe		.FILL	x7C
		

	.END