TITLE Decimal Conversion --> decimalConversion.asm
;This program gets a unsigned integer from console, stores, and computes the 1's of the binary value
;Arlyn Harris
;February 10, 2020

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

msg BYTE "CPSC 232 - Program #2", 0
inputMsg BYTE "Input an unsigned decimal number >> ", 0
oneMsg BYTE "Number of ones found = ", 0

numInput DWORD ?		;holds the inputted number

oneFound BYTE 0		;holds the 1's found
		

.code
main PROC

	mov edx, offset msg			;print message
	call WriteString
	call CRLF
     call CRLF
	
	mov edx, offset inputMsg		;prints message
	call WriteString
	jmp storeString
	
	

storeString:

	call ReadDec
	mov numInput, eax			;value in EAX register
	

	mov oneFound, 0
	mov ecx, 32				;set loop 32x times
     jmp countLoop

	

countLoop:
	
	shr eax, 1				;shifts 1 bit to right
	jc tick					;if carry set, jump to tick
	loop countLoop	
	jmp leFin					;loop done jump to leFin

tick:
	
	inc oneFound				;increments one if carry bit is set
	jmp countLoop				;jump backs to the loop

leFin:
	
	mov edx, offset oneMsg
	call WriteString
	movzx eax, oneFound			;passes tick(oneFound) into eax register
	call WriteDec

	;call DumpRegs
	call CRLF
     call CRLF
	Invoke ExitProcess, 0
main ENDP
END main
