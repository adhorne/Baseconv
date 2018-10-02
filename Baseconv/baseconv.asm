;---------------------------------------------------------
; FILE: baseconv.asm
; BY: Horne, A.
; ORG: CDA 3104, 201808, 80585
; DESC: Building a assembly language project that will convent different number bases.
;---------------------------------------------------------
.386
.model flat, stdcall
.stack 128
ExitProcess PROTO, dwExitCode:DWORD

.code
main proc

mov ebx, 10               ; base
mov ecx, 5                ; position 
call basePosVal




INVOKE ExitProcess, 0     ; exit the program
main endp

;---------------------------------------------------------
basePosVal proc
; calculate value of a base for its position in a number
; by raising the base to its position (first position is 0)
; (can support up to base-16 position-7)
; 
; params:
;	ebx base
;	ecx position 
; uses:
;	edx high-accumulator (not used but will be cleared)
; returns:
;	eax positional value of base
;---------------------------------------------------------
mov eax, 1               ; power 0 is 1 

test ecx, ecx            ; if position == zero 
jz pow_ret               ;	then just return

mov eax, ebx

; we only need to go through positions 2 and higher
; and position is > 0, so subtract 1 so if 
; position=2, we will only loop once
dec ecx                  ; power - 1 (skip zero power)
pow_loop:
	test ecx, ecx       ; while (power > 0)
	jz pow_ret
	mul ebx             ; multiply by base
	dec ecx             ; power--
	jmp pow_loop        ; loop again 

pow_ret:
ret                      ; result in eax

basePosVal endp

end