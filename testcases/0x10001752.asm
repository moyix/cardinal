section .data
	value1: dq 0h
section .text
global main
main:
	call setupstack
	mov esp, 012ff8ch
	int3			; store states for vertical comparison


	;; populate user registers
	mov ah, 46h
	sahf
	mov eax, 0000001bh
	mov ebx, 00001000h
	mov ecx, 00000010h
	mov edx, 0000001ah
	mov esi, 00403000h
	mov edi, 00403020h

	;; populate memory with pre-defined values
	;; double-precision
	MOV EAX, 00403080H        ;; + INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 7FF00000H
	MOV EAX, 00403090H	;; largest +normal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FEFFFFFH
	MOV EAX, 004030A0H	;; close to largest +normal
	MOV DWORD [EAX], 0FFFFFFFEH
	MOV DWORD [EAX+4], 7FEFFFFFH
	MOV EAX, 004030B0H	;; close to smallest +normal
	MOV DWORD [EAX], 2H
	MOV DWORD [EAX+4], 00100000H
	MOV EAX, 004030C0H	;; smallest +normal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 00100000H
	MOV EAX, 004030D0H	;; largest +denormal
	MOV DWORD [EAX], 0FFFFFFFCH
	MOV DWORD [EAX+4], 000FFFFFH
	MOV EAX, 004030E0H	;; smallest +denormal
	MOV DWORD [EAX], 0BH
	MOV DWORD [EAX+4], 0H
	MOV EAX, 004030F0H	;; + 0
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV EAX, 00403100H	;; - 0
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV EAX, 00403110H	;; largest -denormal
	MOV DWORD [EAX], 0AH
	MOV DWORD [EAX+4], 80000000H
	MOV EAX, 00403120H	;; smallest -denormal
	MOV DWORD [EAX], 0FFFFFFFBH
	MOV DWORD [EAX+4], 800FFFFFH
	MOV EAX, 00403130H	;; largest -normal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80100000H
	MOV EAX, 00403140H	;; close to larget -normal
	MOV DWORD [EAX], 3H
	MOV DWORD [EAX+4], 80100000H
	MOV EAX, 00403150H	;; close to smallest -normal
	MOV DWORD [EAX], 0FFFFFFFCH
	MOV DWORD [EAX+4], 0FFEFFFFFH
	MOV EAX, 00403160H	;; smallest -normal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 0FFEFFFFFH
	MOV EAX, 00403170H	;; -INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0FFF00000H
	MOV EAX, 00403180H	;; SNaN
	MOV DWORD [EAX], 12345678H
	MOV DWORD [EAX+4], 07FF00000H
	MOV EAX, 00403190H	;; QNaN
	MOV DWORD [EAX], 12345678H
	MOV DWORD [EAX+4], 07FF80000H
	MOV EAX, 004031A0H	;; QNaN FP indeinite
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0FFF80000H
	;; single-precision
	MOV EAX, 0040308CH	;; +INFI
	MOV DWORD [EAX], 7F800000H
	MOV EAX, 0040309CH	;; largest +normal
	MOV DWORD [EAX], 7F7FFFFFH
	MOV EAX, 004030ACH	;; largets +normal -2
	MOV DWORD [EAX], 7F7FFFFEH
	MOV EAX, 004030BCH	;; smallest +normal +3
	MOV DWORD [EAX], 00800003H
	MOV EAX, 004030CCH	;; smallest +normal
	MOV DWORD [EAX], 00800000H
	MOV EAX, 004030DCH	;; +Denormal
	MOV DWORD [EAX], 007FFFFFH
	MOV EAX, 004030ECH	; +Denormal
	MOV DWORD [EAX], 1H
	MOV EAX, 004030FCH	; +0
	MOV DWORD [EAX], 0H
	MOV EAX, 0040310CH	; -0
	MOV DWORD [EAX], 80000000H
	MOV EAX, 0040311CH	; -Denormal
	MOV DWORD [EAX], 80000001H
	MOV EAX, 0040312CH	; -Denormal
	MOV DWORD [EAX], 807FFFFFH
	MOV EAX, 0040313CH	; -Normal
	MOV DWORD [EAX], 80800000H
	MOV EAX, 0040314CH	; -Normal ++
	MOV DWORD [EAX], 80800005H
	MOV EAX, 0040315CH	; -Normal --
	MOV DWORD [EAX], 0FF7FFFFCH
	MOV EAX, 0040316CH	; -Normal
	MOV DWORD [EAX], 0FF7FFFFFH
	MOV EAX, 0040317CH	; -INFI
	MOV DWORD [EAX], 0FF800000H
	MOV EAX, 0040318CH	; SNaN
	MOV DWORD [EAX], 0FF801234H
	MOV EAX, 0040319CH	; QNaN
	MOV DWORD [EAX], 0FFC00000H
	MOV EAX, 004031ACH	; QNaN FP Indef
	MOV DWORD [EAX], 0FFC00000H
	;; double-extened precision
	MOV EAX, 004031B0H	; +INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 004031C0H	; +Normal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 7FFEH
	MOV EAX, 004031D0H	; +Normal--
	MOV DWORD [EAX], 0FFFFFFFAH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 7FFEH
	MOV EAX, 004031E0H	; +Normal++
	MOV DWORD [EAX], 02H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 0001H
	MOV EAX, 004031F0H	; +Normal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 0001H
	MOV EAX, 00403200H	; +Denormal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FFFFFFFH
	MOV WORD [EAX+8], 0000H
	MOV EAX, 00403210H	; +Denromal
	MOV DWORD [EAX], 1H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 0H
	MOV EAX, 00403220H	; +0
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 0H
	MOV EAX, 00403230H	; -0
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 8000H
	MOV EAX, 00403240H	; -Denormal
	MOV DWORD [EAX], 1H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 8000H
	MOV EAX, 00403250H	; -Denormal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FFFFFFFH
	MOV WORD [EAX+8], 8000H
	MOV EAX, 00403260H	; -Normal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 8001H
	MOV EAX, 00403270H	; -Normal--
	MOV DWORD [EAX], 3H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 8001H
	MOV EAX, 00403280H	; -Normal++
	MOV DWORD [EAX], 0FFFFFFFDH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 0FFFEH
	MOV EAX, 00403290H	; -Normal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 0FFFEH
	MOV EAX, 004032A0H	; -INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 0FFFFH
	MOV EAX, 004032B0H	; SNaN
	MOV DWORD [EAX], 12345678H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 004032C0H	; QNaN
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 004032D0H	; QNaN FP Indef
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0C0000000H
	MOV WORD [EAX+8], 0FFFFH
	;; unsupported double-extended precision
	MOV EAX, 004032E0H	; +QNaN
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FFFFFFFH
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 004032F0H	; +QNaN
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 40000000H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 00403300H	; +SNaN
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 3FFFFFFFH
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 00403310H	; +SNaN
	MOV DWORD [EAX], 1H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 00403320H	; +INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 7FFFH
	MOV EAX, 00403330H	; +unnormal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FFFFFFFH
	MOV WORD [EAX+8], 7FFEH
	MOV EAX, 00403340H	; +unnormal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 1H
	MOV EAX, 00403350H	; +denormal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 0H
	MOV EAX, 00403360H	; +denormal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 0H
	MOV EAX, 00403370H	; -denormal
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 0FFFFFFFFH
	MOV WORD [EAX+8], 8000H
	MOV EAX, 00403380H	; -denormal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 80000000H
	MOV WORD [EAX+8], 8000H
	MOV EAX, 00403390H	; -unnormal
	MOV EAX, 004033A0H	; -unnormal
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 8001H
	MOV EAX, 004033B0H	; -INFI
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 0FFFFH
	MOV EAX, 004033C0H	; -SNaN
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 3FFFFFFFH
	MOV WORD [EAX+8], 0FFFFH
	MOV EAX, 004033D0H	; -SNaN
	MOV DWORD [EAX], 1H
	MOV DWORD [EAX+4], 0H
	MOV WORD [EAX+8], 0FFFFH
	MOV EAX, 004033E0H	; -QNaN
	MOV DWORD [EAX], 0FFFFFFFFH
	MOV DWORD [EAX+4], 7FFFFFFFH
	MOV WORD [EAX+8], 0FFFFH
	MOV EAX, 004033F0H	; -QNaN
	MOV DWORD [EAX], 0H
	MOV DWORD [EAX+4], 40000000H
	MOV WORD [EAX+8], 0FFFFH
	;; x87 FPU Control Word
	MOV EAX, 00403040H
	MOV WORD [EAX], 0040H
	MOV WORD [EAX+2], 0140H
	MOV WORD [EAX+4], 0240H
	MOV WORD [EAX+6], 0340H	
	MOV WORD [EAX+8], 0440H
	MOV WORD [EAX+0AH], 0540H
	MOV WORD [EAX+0CH], 0640H
	MOV WORD [EAX+0EH], 0F40H

	;; initialize floating point registers
	FINIT
        mov eax, 00403000h
	movdqu xmm0, oword [eax]
	movdqu xmm1, oword [eax]
	movdqu xmm2, oword [eax]
	movdqu xmm3, oword [eax]
	movdqu xmm4, oword [eax]
	movdqu xmm5, oword [eax]
	movdqu xmm6, oword [eax]
	movdqu xmm7, oword [eax]
	fld qword [eax] ;st(0)
	fld qword [eax]
	fld qword [eax]
	fld qword [eax]
	fld qword [eax]
	fld qword [eax]
	fld qword [eax]
	fld qword [eax] ;st(7)
	
	;; initialization
	MOV EAX, 00403000h
  MOV DWORD [EAX], 40h
  LDMXCSR DWORD [EAX]
  MOV DWORD [EAX], 807fffffh
  MOVDQU XMM1, [EAX]
  MOVDQU XMM2, [EAX]
 int3
  VHADDPS XMM0, XMM1, XMM2

	;; store states and exit
	int3
	call myexit
HANDLER:
	;; push detailed information onto stack
	mov edx, [esp + 4]		; pointer to EXCEPTION_RECORD
	mov ebx, [esp + 0ch]		; pointer to CONTEXT
	push 0ffffffffh
	push dword [edx] 		; excr.ExceptionCode
	push dword [edx + 4h] 	; excr.ExceptionFlags
	push dword [edx + 0ch] 	; excr.ExceptionAddress
	push 0ffffffffh
	int3
	mov EAX, 1h
	call myexit

myexit:
    mov eax, 1h
    mov ebx, 0h
    int 80h

setupstack:
    mov eax, 0c0h           ; mmap_pgoff
    mov ebx, 012e000h       ; addr
    mov ecx, 2000h          ; size
    mov edx, 03h            ; prot = PROT_READ|PROT_WRITE
    mov esi, 32h            ; flags = MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS
    mov edi, 0ffffffffh     ; fd = -1
    mov ebp, 0              ; offset
    int 80h
    ret
