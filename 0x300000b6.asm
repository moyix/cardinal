section .data
	value1: dq 0h
section .text
main:
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
	mov eax, 00403000h
  mov dword ptr[eax], 0ffffffffh
  mov dword ptr[eax+4], 0ffffffffh
  mov dword ptr[eax+8], 0ffffffffh
  mov dword ptr[eax+0ch], 0ffffffffh
  movdqu xmm1, oword [eax]
  mov ebx, 00403020h
  mov dword ptr[ebx], 0ffffffffh
  mov dword ptr[ebx+4], 0ffffffffh
  mov dword ptr[ebx+8], 0ffffffffh
  mov dword ptr[ebx+0ch], 0ffffffffh
  movdqu xmm2, oword [ebx]
 int3
  minps xmm1, xmm2

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
	push dword [edx + 8h] 	; excr.pExceptionRecord
	push dword [edx + 0ch] 	; excr.ExceptionAddress
	push dword [edx + 10h] 	; excr.NumberParameters
	push dword [edx + 14h] 	; excr.ExceptionInformation
	push dword [edx + 18h] 	; excr.ExceptionInformation
	push 0ffffffffh
	mov edx, ebx
        push dword [edx] 		; cont.ContextFlags
        push dword [edx + 4h] 	; cont.iDr0
        push dword [edx + 8h] 	; cont.iDr1
        push dword [edx + 0ch] 	; cont.iDr2
        push dword [edx + 10h] 	; cont.iDr3
        push dword [edx + 14h] 	; cont.iDr6
        push dword [edx + 18h] 	; cont.iDr7
        push dword [edx + 1ch] 	; cont.FloatSave.ControlWord
        push dword [edx + 20h] 	; cont.FloatSave.StatusWord
        push dword [edx + 24h] 	; cont.FloatSave.TagWord
        push dword [edx + 28h] 	; cont.FloatSave.ErrorOffset
        push dword [edx + 2ch] 	; cont.FloatSave.ErrorSelector
        push dword [edx + 30h] 	; cont.FloatSave.DataOffset
        push dword [edx + 34h] 	; cont.FloatSave.DataSelector
        push dword [edx + 38h] 	; FP registers (80 bytes)
        push dword [edx + 3ch]
        push dword [edx + 40h]
        push dword [edx + 44h]
        push dword [edx + 48h]
        push dword [edx + 4ch]
        push dword [edx + 50h]
        push dword [edx + 54h]
        push dword [edx + 58h]
        push dword [edx + 5ch]
        push dword [edx + 60h]
        push dword [edx + 64h]
        push dword [edx + 68h]
        push dword [edx + 6ch]
        push dword [edx + 70h]
        push dword [edx + 74h]
        push dword [edx + 78h]
        push dword [edx + 7ch]
        push dword [edx + 80h]
        push dword [edx + 84h]
        push dword [edx + 88h] 	; Cr0NpxState
        push dword [edx + 8ch] 	; GS
        push dword [edx + 90h] 	; FS
        push dword [edx + 94h] 	; ES
        push dword [edx + 98h] 	; DS
        push dword [edx + 9ch] 	; edi
        push dword [edx + 0a0h] 	; esi
        push dword [edx + 0a4h] 	; ebx
        push dword [edx + 0a8h] 	; edx
        push dword [edx + 0ach] 	; ecx
        push dword [edx + 0b0h] 	; ebx
        push dword [edx + 0b4h] 	; ebp
        push dword [edx + 0b8h]	; eip
        push dword [edx + 0bch] 	; cs
        push dword [edx + 0c0h] 	; eflags
        push dword [edx + 0c4h] 	; esp
        push dword [edx + 0c8h] 	; ss
        push 0ffffffffh
	int3
	mov EAX, 1h
	call myexit
