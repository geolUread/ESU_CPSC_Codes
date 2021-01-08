TITLE Array Sorter --> arraySorter.asm
;Arlyn Harris
;March 26 2020
;Program will merge two sorted arrays into one sorted array. 
;Arrays will be hard coded into the program. No information 
;will be inputted by user.

INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword


.data
msg BYTE "CSPC 232 - Merge Sorted Lists", 0		;CPSC msg header
inputMsg BYTE "Input List: ", 0
spaceMsg BYTE " ", 0

listOne DWORD 2, 4, 6, 8, 10, 12, 14			;First hardcoded list
listOneSize = LENGTHOF listOne				;listOne length
listTwo DWORD 1, 3, 5, 7, 9, 11, 13, 15			;Second hardcoded list
listTwoSize = LENGTHOF listTwo				;listTwo length
total = LENGTHOF listOne  + LENGTHOF listTwo 

mergeMsg BYTE "Merged Lists: ", 0				;Merge msg for new list

newList DWORD total DUP(?)					;Variable for new list	

value1 BYTE

.code
main PROC

	mov edx, offset msg
	call WriteString
	call CRLF
	call CRLF
	
	mov edx, offset inputMsg					;Input message
	call WriteString

	mov ecx, 0
	mov esi, 0
	mov ecx, listOneSize					;Setting loop counter to the no. of items in array
	jmp listOnePrint

listOnePrint:								;Loop to print out array
	mov eax, [listOne+esi]
	call WriteDec
	add esi, 4
	mov edx, offset spaceMSG
	call WriteString
	loop listOnePrint
	call CRLF

	

	mov edx, offset inputMsg					;Input message
	call WriteString

	mov ecx, 0
	mov esi, 0
	mov ecx, listTwoSize
	jmp listTwoPrint

listTwoPrint:								;Loop to print out arrayTwo 
	mov eax, [listTwo+esi]
	call WriteDec
	add esi, 4
	mov edx, offset spaceMSG
	call WriteString
	loop listTwoPrint

	call CRLF
	call newSLate
	call dumpregs
	call mergeList

	Invoke ExitProcess, 0
main endp
;-----------------------------------------------------
newSlate PROC
;Set all general purpose register to 0. Push on stack
;------------------------------------------------------
	mov eax, 0
		push eax
	mov ebx, 0
		push ebx
	mov ecx, 0
		push ecx
	mov edx, 0
		push edx
	mov esi, 0
		push esi
	mov edi, 0	
		push edi
	ret
newSlate endp

;__________________________________________________
mergeList PROC
;__________________________________________________
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	mov edi, 0

	mov ecx, total
	jmp testArray

testArray:
	mov eax, [listOne+esi]
	mov ebx, [listTwo+edi]
	cmp eax, ebx
	jg partTwo
	mov [newList+edx], eax
	add edx, 4
	add esi, 4
	backward:
	loop testArray

	mov edx, 0
	mov ecx, 0
	mov ecx, total
	mov esi, 0
	mov edx, offset mergeMSG
	call WriteString
	jmp printArray

partTwo:
	mov [newList+edx], ebx
	add edx, 4
	add edi, 4
	jmp backWard


printArray:
	mov eax, [newList+esi]
	call WriteDec
	add esi, 4
	mov edx, offset spaceMSG
	call WriteString
	loop printArray

	call CRLF
	call CRLF

	ret
mergeList endp

end main


