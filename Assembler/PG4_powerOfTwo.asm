TITLE Power of Two's -->powerOfTwo.asm
;Arlyn Harris
;February 23 2020
;Program will recieve a hexadecimal number. Number will be converted into binary 
;and then we will calculate the power of two's from the bit index used. 
;and output the frequencies of the bit that are located in the power of 2's


INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data

msg BYTE "CPSC 232 - Program #4",0
inputMsg BYTE "Input a 32-bit word (8 hex digits) >>", 0
										
oneFreqMSG BYTE "1's Frequency = ", 0					;Below are messages for the frequency
twoFreqMSG BYTE "2's Frequency = ", 0
fourFreqMSG BYTE "4's Frequency = ", 0
eightFreqMSG BYTE "8's Frequency = ", 0
sixTeenFreqMSG BYTE "16's Frequency = ", 0
threeTwoFreqMSG BYTE "32's Frequency = ", 0

temp DWORD ?

uno WORD ?									;spanish numbers that will hold up 16-bit value of the frequency recorded
dos WORD ?
quatro WORD ?
ocho WORD ?
seis WORD ?
tres WORD ?


.code
main PROC
		
	mov edx, offset msg					;prints message
	call WriteString
	call CRLF

	mov edx, offset inputMsg				;prints input message
	call WriteString
	mov eax, 0						;clearing the EAX register
     call ReadHex						;function to read hexadecimal value into EAX register 

	call CRLF
	call CRLF
	mov ebx, 0						;clearing the EBX register
	mov ecx, 0						;clearing the ECX register
	call powerOfTwo

;___________________________________________________________
powerOfTwo PROC
;Calculates the power of twos and outputs the statements
;the values are stored in the 16 bit version of each 32 bit register
;Recieves: EAX - hexadecimal values
;Returns: EAX EBX EDX 
;
;____________________________________________________________
	
	mov edx, 0
	mov ecx, 0				;setting up the ecx register
	mov ecx, 32				;setting ecx register to loop 32 times
	mov bl, 0					;setting up dl register to hold index valu	
checker:	
	inc edx
	inc bl					;incrementing dl, to hold as an index, so it starts at 1 instead of 0
	shr eax, 1				;shifting the bit once to the right
	jc partTwo				;jc to partTwo if bit is set
     startAgain:
	loop checker

	jmp output

partTwo:						;checks the bit index for any of the immediate values of power of 2
	push EBX					;preserved the content of the index (EBX) onto stack
	cmp bl, 32
	jz thirtyFreq
	cmp bl, 16
	jz sixteenFreq
	cmp bl, 8
	jz eightFreq
	cmp bl, 4
	jz fourFreq
	cmp bl, 2
	jz twoFreq
	cmp bl, 1
	jz oneFreq
partThree:				;subtraction decrement for finding the power of 2's
	cmp bl, 16			;Uses the carry flag to determine whether it falls through or gets subtracted
	jc level8
	inc seis
	sub bl, 16
level8:
	cmp bl, 8
	jc level4
	inc ocho
	sub bl, 8
level4:
	cmp bl, 4
	jc level2
	inc quatro
	sub bl, 4
level2:
	cmp bl, 2
	jc level1
	inc dos
	sub bl, 2
level1:
	cmp bl, 1
	jc loopRestart
	inc uno
	sub bl, 1
	jmp loopRestart
	
oneFreq:
	inc uno
	jmp loopRestart
TwoFreq:
	inc dos
	jmp loopRestart
fourFreq:
	inc quatro
	jmp loopRestart
eightFreq:
	inc ocho
	jmp loopRestart
sixteenFreq:
	inc seis
	jmp loopRestart
thirtyFreq:
	inc tres
	jmp loopRestart

loopRestart:						;everything will jmp here and this will restart the loop
	pop EBX
	jmp startAgain

;--------------------------------------
;Output of the powerOfTwo
;--------------------------------------
output:

	mov edx, offset oneFreqMSG			;prints input message frequencyOne
	call WriteString
	movzx eax, uno
	call WriteDec
	call CRLF

	mov eax, 0
	mov edx, offset twoFreqMSG			;prints input message frequencyTwo
	call WriteString
	movzx eax, dos
	call WriteDec
	call CRLF

	mov eax, 0
	mov edx, offset fourFreqMSG			;prints input message frequencyFour
	call WriteString
	movzx eax, quatro
	call WriteDec
	call CRLF

	mov eax, 0
	mov edx, offset eightFreqMSG			;prints input message frequencyEight
	call WriteString
	movzx eax, ocho
	call WriteDec
	call CRLF

	mov eax, 0
	mov edx, offset sixTeenFreqMSG			;prints input message frequencySixteen
	call WriteString
	movzx eax, seis
	call WriteDec
	call CRLF

	mov eax, 0
	mov edx, offset threeTwoFreqMSG			;prints input message frequencyThreeTwo
	call WriteString
	movzx eax, tres
	call WriteDec
	call CRLF
	jmp leFin

leFin:
powerOfTwo ENDP
	Invoke ExitProcess, 0
main endp
end main