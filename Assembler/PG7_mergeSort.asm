TITLE Merge IN MASM --> MERGESORT.asm
;Arlyn Harris
;April 27, 2020
;aharris26@live.esu.edu
INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: DWORD

;Function/Module Prototype
SORT PROTO arrayName:DWORD, last:DWORD, mid:DWORD, first:DWORD
PRINTDOUBLE PROTO arrayName:DWORD, pfirst:DWORD, plast:DWORD
MERGE PROTO arrayName:DWORD, pfirst:DWORD, plast:DWORD

.data
msg BYTE "CPSC 232 - MERGE SORT RECURSION", 0
unsortedMsg BYTE "The unsorted list it: ", 0
sortedMsg BYTE "The sorted list is: ", 0
space BYTE " ", 0

A DWORD 1000, 501, 100, 51, 0, 1, 1, 0, 50, 101, 500, 1001		;Original array
aSize = ($ - A) / 4					           ;Size of array

aFirst DWORD 0						      ;Original array first index
aLast DWORD (aSize - 1)				;Original array last index

tempLeft DWORD asize DUP(?)
tempRight DWORD asize DUP(?)

temp DWORD 100 DUP(?)
sizeC DWORD 0

four DWORD 4						;DWORD value

.code
MAIN PROC

    mov edx, offset msg
    call WriteString
    call CRLF
    call CRLF

    mov edx, offset unsortedMsg
    call WriteString
    mov eax, asize
    Invoke PRINTDOUBLE, offset A, afirst, eax			   ;Print onto console items in array  

    Invoke MERGE, offset A, aFirst, aLast					   ;Call Merge to divide array into subarrays

    mov edx, offset sortedMsg
    call WriteString
    mov eax, asize
    Invoke PRINTDOUBLE, offset A, 0, eax
	

	Invoke ExitProcess, 0
MAIN ENDP

;+++++++++++++++++++++++++++++++++
RESET PROC
;------------------------------------------------------------------
;Purpose: Clears all registers
;Recieves: EAX, EBX, ECX, EDX, ESI, EDI
;Returns: EAX, EBX, ECX, EDX, ESI, EDI
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	mov esi, 0
	mov edi, 0
	ret
RESET ENDP

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
PRINTDOUBLE PROC, arrayName:DWORD, pfirst:DWORD, plast:DWORD
;--------------------------------------------------------------------------------------------------------------------
;Purpose: Outputs double word array onto console
;Recieves: offset A: Array name, first: First index, last: last index + 1 
;Returns: Output of array items
	mov EBX, arrayName
	
	mov eax, pfirst		  	;Set pointer for first index
	mul four
	movzx esi, al

	mov eax, plast		      ;Set pointer for last index
	mul four
	movzx ecx, al
PRINT:						      ;loop to print items in array
	cmp esi, ecx
	JGE DONE
	mov eax, [EBX + esi]
	call WriteDec
	
	mov edx, offset space
	call WriteString
	
	add esi, 4
	JMP PRINT
DONE:
	call CRLF
	call CRLF
	ret
PRINTDOUBLE ENDP

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
MERGE PROC, arrayName:DWORD, pfirst:DWORD, plast:DWORD
	LOCAL mid: DWORD
	LOCAL midPlus: DWORD
;------------------------------------------------------------------------------------------------------------------------------------------------------------
;Purpose: Divides the array into subarrays until it reaches a single element
;Recieves: arrayName: Array to be divided, pfirst: First index of the array, plast: Last index of array
;Returns: A subarray of original array

	mov eax, pfirst
	mov ebx, plast
	cmp eax, ebx
	JGE NEXT
	
	mov eax, plast
	add eax, pfirst
	mov bl, 2
	div bl

	movzx ebx, al	;Midpoint stored in EBX
	mov mid, ebx
	add ebx, 1
	mov midPlus, ebx

	Invoke MERGE, arrayName, pfirst, mid
	Invoke MERGE, arrayName, midplus, plast

	Invoke sort, arrayName, plast, mid, pfirst			  ;Calls the sort module
NEXT:	
	ret
MERGE ENDP
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SORT PROC, arrayName:DWORD, last:DWORD, mid:DWORD, first:DWORD
	LOCAL sizeA: DWORD			;i = 0, 1, 2, 3, 4...
	LOCAL sizeB: DWORD
	LOCAL midplus: DWORD			;M + 1
	LOCAL finplus: DWORD			;L + 1
;----------------------------------------------------------------------------------------------------------------------------------------------------------------
;Purpose: Sorts the subarray into ascending order
;Recives: arrayName: Name of array,  last: Last index, mid: Middle index, first: First index
;Returns: Parts of original sorted until it is fully sorted
	call RESET

	;Set index values
	mov eax, last		  ;Last index 
	mul four
	movzx eax, al
	mov last, eax
	
	mov eax, last			;Last + 1 - FINPLUS
	add eax, 4
	mov finplus, eax

	mov eax, mid			;Mid index - MID
	mul four
	movzx eax, al
	mov mid, eax

	mov eax, mid			;Mid + 1 - MIDPLUS	
	add eax, 4
	mov midplus, eax	

	mov eax, first			;First index
	mul four
	movzx eax, al	
	mov first, eax
;_________________________________________________________	
	mov edx, arrayName
	LEFT:	
	;MIDPLUS = COUNTER JGE / UNO = FIRST INDEX
	mov esi, first
	mov ecx, midplus
	mov ebx, 0							   ;Tally for TEMPLEFT ARRAY
MOVELEFT:
	cmp esi, ecx
	JGE RIGHT
	mov eax, [edx + esi]
	mov [tempLeft + edi], eax
	inc ebx
	add edi, 4
	add esi, 4
	JMP MOVELEFT
RIGHT:
	;FIN = COUNTER JGE / MIDPLUS = START INDEX
	mov SIZEA, ebx
	mov ecx, finplus					    ; COUNTER = FINPLUS
	mov esi, midplus					    ;POINTER = MIDPLUS
	mov edi, 0
	mov ebx, 0							    ;TALLY for TEMPRIGHT ARRAY
MOVERIGHT:	
	cmp esi, ecx
	JGE NEXT
	mov eax, [edx + esi]
	mov [tempRight + edi], eax
	inc ebx 
	add esi, 4
	add edi, 4
	JMP MOVERIGHT

NEXT:
	mov eax, 0
	mov SIZEB, ebx
	mov eax, 0
	mov sizeC, 0

	call RESET
	mov eax, sizeA
	mul four
	movzx eax, al
	mov sizeA, eax

	mov eax, sizeB
	mul four	
	movzx eax, al
	mov sizeB, eax

START:
	mov ecx, sizeA
	sub ecx, 4
	cmp ecx, esi
	JGE S2
	JMP OUTFIRST
S2:	
	mov ecx, sizeB	
	sub ecx, 4
	cmp ecx, edi
	JGE S3
	JMP OUTSECOND
S3:
	mov eax, [tempLeft + esi]
	mov ebx, [tempRight + edi]
	cmp eax, ebx
	JG PARTTWO
	mov [temp + edx], eax
	inc sizeC	
	add edx, 4
	add esi, 4
	BACKWARD:
	JMP START
		
PARTTWO:
	mov [temp + edx], ebx
	inc sizeC
	add edx, 4
	add edi, 4
	JMP BACKWARD

OUTFIRST:
	mov ecx, SIZEB
	sub ecx, 4	
	mov ebx, [tempRight + edi]
	mov [temp + edx], ebx
	inc sizeC
	add edx, 4
	add edi, 4
	cmp ecx, edi
	JGE OUTFIRST	
	JMP TRANSFER

OUTSECOND:
	mov ecx, SIZEA
	sub ecx, 4
	mov ebx, [tempLeft + esi]
	mov [temp + edx], ebx
	inc sizeC
	add edx, 4
	add esi, 4
	cmp ecx, esi
	JGE OUTSECOND
	JMP TRANSFER

TRANSFER: 
	call RESET

	mov edi, 0
	mov esi, first
	mov ecx, finplus
	mov edx, arrayName
	
INPUT:
	cmp esi, ecx
	JGE ENDING
	mov eax, [temp + edi]
	mov [edx + esi], eax
	add esi, 4
	add edi, 4
	JMP INPUT	
ENDING:
	ret
SORT ENDP
END MAIN