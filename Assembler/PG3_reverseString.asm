TITLE Reversing a String --> reverseString.asm
;ArlynHarris 
;Feburary 20, 2020
;Program will reciever a string of atmost 20 characters, it will then reverse it
;and the string will be stored in memory and printed out. The second part of this 
;will be to check whether or not the string is a palindrome. 

include C:\irvine\irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

msg BYTE "CPSC 232 - Program #3", 0				;Program message header
inputMsg BYTE "Input a string(50 chars max)>>", 0		;Input message
reverseMsg BYTE "The reverse of the string is: ", 0		
palin BYTE "The string is a palindrome", 0			;Message for palindrome
palinNot BYTE "The string is not a palindrome", 0		;Message not a palindrome
error BYTE "Error - Empty String Entered", 0			;Erro message for no string


inputWord BYTE 51 DUP(?)							;Variable for user string
inputCount BYTE ?								;Variable to hold string size
x BYTE 0										;Variable counter
							

.code
main PROC

	mov edx, offset msg				;prints CPSC message
	call WriteString		
	call CRLF
	call CRLF

	mov edx, offset inputMsg			;prints input message
	call WriteString

	mov edx, offset inputWord		;puts string in edx register
	mov ecx, sizeof inputWord		;sets limit for characters
	call ReadString

	mov inputCount, al				;moves character count into inputCount
	movzx ecx, inputCount			;moves inputCount into ecx register for loop
	mov esi, 0					;esi = 0, for index pointer
	cmp ecx, 0					;compares ecx with 0 to see if string was entered
	jz errorMsg					;if zero flag set jumps to error message
	jmp storeStart					;if not set jumps to storeStart

errorMsg:

	mov edx, offset error			;prints error message
	call WriteString
	call CRLF
	jmp fin

storeStart:
	
	movzx eax, inputWord[esi]		;moves 1 character into eax register
	push eax						;pushes the character into the stack
	inc esi						;increments the esi index	
	loop storeStart				;continues the loop
	jmp reset						;Once loop done jumps to reset

reset:
	
	movzx ecx, inputCount			;moves string size into ecx register
	mov esi, 0					;sets esi to 0
	jmp reverseStart				

reverseStart:

	pop eax						;pop off the eax register
	;call dumpRegs
	mov inputWord[esi], al			;moves the byte from al register into the string at index esi(0)
	inc esi						;increments esi index
	loop reverseStart
	jmp printWord

printWord:

	call CRLF
	mov edx, offset reverseMsg		;prints reverse message
	call WriteString
	mov edx, offset inputWord		;prints the reverse string
	call WriteString
	call CRLF
	jmp resetPali					;jumps to resetPali to reset the values for finding palindrome

resetPali:
	
	mov eax, 0
	movzx eax, inputCount
	push eax						;preserve the content of eax register 
	movzx ax, al					;inputs the value of eax into ax register
	mov bl, 2						;inputs 2 into bl register
	div bl						;divides the ax by the bl register to we can split the string in half
	movzx ecx, al					;moves the quotient value into ecx register to act as a counter 

	pop eax						;pop of the value of eax that we preserved earlier
	sub eax, 1					;subtract 1, so we can get the index of the string correct
	mov edi, eax						
	mov esi, 0
	mov ebx, 0					;clear ebx register
	mov eax, 0					;clear eax register
	;call dumpregs
	push ecx						;preserve content of ecx register
	jmp checkPal

checkPal:
	
	mov bl, inputWord[edi]			;move edi(last character index) into bl register
	mov al, inputWord[esi]			;move esi(first character index) into al register
	inc esi						;increment esi
	dec edi						;decrement esi
	cmp al, bl					;compare the values in the al and bl register
	jnz notPal					;if zero flag not set we jump to notPal
	inc x						;if flag is set we increment x 

	;call dumpregs
	loop checkPal
	pop ecx						;When loop is done we pop of ecx register
	cmp ecx, offset x				;we compare the ecx and x, to check for palindrome
	jz palindrome					;if zero flag is set we jump to palindrome

palindrome:

	mov edx, offset palin			;print out palindrome message
	call WriteString
	call CRLF
	jmp fin						;jump to the end

notPal:

	mov edx, offset palinNot			;print out not a palindrome message
	call WriteString
	call CRLF
	jmp fin						;jump to the end

fin:
	call CRLF

	



	Invoke ExitProcess, 0
main endp
end main
