TITLE Roots using Quadratic Formula

INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: DWORD

.data

msg BYTE "Enter for A", 0
msgB BYTE"Enter for B", 0
msgC BYTE "Enter for C", 0





valA REAL4 ?
valB REAL4 ?
valC REAL4 ?

two DWORD 2
 four  DWORD 4
 one real4 ?


root1 REAL4 ?
root2 REAL4 ?

.code
MAIN PROC
        ;Initialize the FPU stack
        finit 

        ;Recieve input from user
        mov edx, offset msg
        call readfloat

        mov edx, offset msgb
        call readfloat

        mov edx, offset msgC
        call readfloat

        fstp valC
        fstp valB
        fstp valA

        call showfpustack
        call beforedv
        call divs

        call crlf

        call writefloat
        fstp st(0)
        call writefloat

        call crlf

    Invoke ExitProcess, 0
MAIN ENDP

BEFOREDV PROC
    
    fld valb
    fmul valb

    fld vala
    fmul valc
    fImul four

    
    call showfpustack


    fsubp st(1), st(0)
    fstp  one

     fld valb
    fchs 

    fld valb
    fchs

    ;Addition

    fadd one

    
    call showfpustack


    ;subtraction
    fld one
    fsubp st(2), st(0)

    call showfpustack

    ret
BEFOREDV ENDP

DIVs PROC
      
      fild two
     fmul vala


      ;call showfpustack

    fdiv st(1), st(0)

    fdivp st(2), st(0)

    call showfpustack 

    ret
DIVs ENDP

END MAIN