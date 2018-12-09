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
;loop	BRnzp loop




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