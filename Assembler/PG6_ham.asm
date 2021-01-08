TITLE Hamming Code Analyzer -->hamm.asm
;Arlyn Harris
;April 7, 2020
;Program will receive up to 32 bit hex value as a data bit.
;the value will be checked to analyze what bit is in error.
;Once bit is found the location of bit will be outputted and
;the corrected data will also be outputted. 

INCLUDE irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
msg BYTE "CPSC 232 - Hamming Code Analyzer", 0

inputMsg BYTE "Input the parity type (0-even, *-odd) >> ", 0
parityInput DWORD ?				;Variable for parity value		

inputWord BYTE "Input the recieved word (8 hex digits) >> ", 0
inputValue DWORD 0
bitErrorMsg BYTE "The bit in error is: ", 0
bitError BYTE 0

correctMsg BYTE "The corrected word is: ", 0
powerValues WORD 6 DUP(0)
powerNumbers WORD 1, 2, 4, 8, 16, 32

.code
main PROC
        mov edx, offset msg         ;Output message
        call WriteString
        call CRLF
        call CRLF

        mov edx, offset inputMsg    ;Input message
        call WriteString
        call ReadDec
        mov parityInput, eax            ;Holds parity value
        call CRLF

        mov edx, offset inputWord   ;Data bit input
        call WriteString
        call ReadHex                            ;Hex value stored in EAX
	  push eax
	  mov inputValue, eax
	  pop eax
        
	  call POWEROFTWO			    ;Find the value of the power of two's in the data
	  call CHECKPARITY			    ;Locate the bit in error
	  mov bitError, dl
	  mov eax, inputValue
	  push edx
	  
	 mov edx, offset bitErrorMsg
	 call WriteString
	 pop edx
	 mov eax, edx
	 call WriteDec
	 call CRLF

	 call CORRECTBIT
	  
	 mov edx, offset correctMsg
	 call WriteString
	 call WriteHex
	 call crlf

        Invoke ExitProcess, 0
main ENDP
RESETREG PROC;___________________________
;Set all registers to 0
;Recieves: EAX, EBX, ECX, EDX, ESI, EDI
;Returns: EAX, EBX, ECX, EDX, ESI, EDI_________
    mov eax, 0
    mov ebx, 0
    mov edx, 0
    mov ecx, 0
    mov esi, 0
    mov edi, 0
    ret
RESETREG ENDP

POWEROFTWO PROC;_______________________________________
;Calculates the power of twos and outputs the statements
;the values are stored in the 16 bit version of each 32 bit register
;Recieves: EAX - hexadecimal values
;Returns: EAX EBX EDX _______________________________________
	mov ecx, 0					;setting up the ecx register
	mov ecx, 32				;setting ecx register to loop 32 times
	mov bl, 0					;setting up dl register to hold index valu	
checker:	
	inc edx
	inc bl						    ;incrementing dl, to hold as an index, so it starts at 1 instead of 0
	shr eax, 1				    ;shifting the bit once to the right
	jc partTwo				    ;jc to partTwo if bit is set
		startAgain:
	loop checker
	jmp bottom
partTwo:						;checks the bit index for any of the immediate values of power of 2
	push EBX					;preserved the content of the index (EBX) onto stack
	cmp bl, 32
	 jc level16
	 inc [powerValues+10]
	 sub bl, 32
			   level16 :					;Subtraction decrement for finding the power of 2's
				   cmp bl, 16			;Uses the carry flag to determine whether it falls through or gets subtracted
				    jc level8
				    inc [powerValues+8]
				    sub bl, 16
						    level8:
						    cmp bl, 8
						    jc level4
						    inc [powerValues+6]
						    sub bl, 8
						               level4:
								    cmp bl, 4
								    jc level2
								    inc [powerValues+4]
								    sub bl, 4
										    level2:
											  cmp bl, 2
											  jc level1
											  inc [powerValues+2]
											  sub bl, 2
													  level1:
														 cmp bl, 1
														 jc loopRestart
														  inc [powerValues+0]
														 sub bl, 1
														 jmp loopRestart
loopRestart:				;Restart loop
	pop EBX
	jmp startAgain
Bottom:
	 call RESETREG
	ret
POWEROFTWO ENDP

CHECKPARITY PROC;____________________________________
;Check the parity value inputted and determine parity format
;Recieves:  parityInput, powerValues, powerNumbers 
;Returns: EDX____________________________________________
	  mov ecx, 5
	  mov eax, parityInput						
	  cmp eax, 0
	  JNZ oddLane

    evenLane:											      ;If our parity is an even value we are going this route
			mov ax , [powerValues + edi]			;move the value of an power of 2 into the ax register
		      mov bl, 2
		      div bl
			cmp ah, 0
			JZ evenParity									;If we get 0, skip 
		      mov si, [powerNumbers + edi]		
		      add dx, [powerNumbers+edi]
                 mov ah, 0
                 add edi, 2
     L2:
			loop evenLane
			JMP endPart
    evenParity:
			add edi, 2
			mov ah, 0
			JMP L2

    oddLane:
	  		mov ax , [powerValues + edi]
                  mov bl, 2
			div bl
			cmp ah, 0
			JZ oddParity			    ;If we get 0 then we need to force odd parity
			add edi, 2
			mov ah, 0
    L3:
			loop oddLane
			JMP endPart
    oddParity:
			add dx, [powerNumbers + edi]
			mov ah, 0
			add edi, 2
			JMP L3
    endPart:
		    ret
CHECKPARITY ENDP

CORRECTBIT PROC;__________________
;Uses error bit to fix the data
;Recieves: bitError and inputValue
;Returns: EAX________________________

    call RESETREG
    mov eax, inputValue		  ;Inputs data into EAX 
    mov cl, bitError			  ;Inputs location of bit error into CL
    RCR eax, cl					  ;rotates EAX by CL 
    JC ZERO						  ;If carry set we are going to clear it
    STC
return:
    RCL eax, cl
    JMP leFin		;Transfer the fixed data into the eax register to print out
ZERO:
    CLC
    JMP return
leFin:
    ret
CORRECTBIT ENDP
END main