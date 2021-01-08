TITLE Name & Age -->nameAge.asm
;Program that will read name and age and output it on console
;Arlyn Harris
;February 7, 2020

INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data

msg BYTE "CPSC 232: Program #1", 0			;Opening statment
nameMsg BYTE "Enter your name >> ", 0		;Prompt for name
ageMsg BYTE "Enter your age >> ", 0		;Prompt for age

finalName BYTE "Your name is: ", 0			;output prompt ->name
finalAge BYTE "Your age is: ", 0			;output prompt ->age

nameInput BYTE 10 DUP(0)			;variable for name input
nameCount DWORD ?

ageInput BYTE 2				;variable for age input

.code
main PROC

	mov edx, offset msg			;prints prompt
	call WriteString
	call CRLF
	call CRLF

	mov edx, offset nameMsg		;prints name prompt
	call WriteString
	
	
	mov edx, offset nameInput	;input for name prompt
	mov ecx, SIZEOF nameInput
	call ReadString
	mov nameCount, eax
	
	

	mov edx, offset ageMsg		;prints age prompt
	call WriteString
     call ReadInt				;input for age prompt
	mov ageInput, al
	
	call CRLF					;SPACE

	;TIME TO OUTPUT DATA
	mov edx, offset finalName
	call WriteString

	mov edx, offset nameInput			;name in EAX register
	call WriteString

	call CRLF					;SPACE

	mov edx, offset finalAge
	call WriteString
	mov al, ageInput			;age in AL register
	call WriteDec

	call CRLF					;SPACE

	;call DumpRegs  ;Display register

	Invoke ExitProcess, 0
main endp
end main



