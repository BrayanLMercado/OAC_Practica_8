; Materia: Organización y Arquitrectura De Computadoras
; Nombre: López Mercado Brayan
; Matrícula: 1280838
; Práctica 8
; Fecha: 25 de abril de 2023

%include "pc_io.inc"
section .bss ;Variables

cad resb 16
cadena resb 32

section .data ; Constantes

NL: db 13,10
NL_L: equ $-NL
ia: db 10,"Inciso A: ",0
ib: db 10,"Inciso B: ",0
ic: db 10,"Inciso C: ",0
id: db 10,"Inciso D: ",0
resultAND: db 10,"Resultado EAX & Cl = ",0
resultOR: db 10,"Resultado EAX u Cl = ",0
resultXOR: db 10,"Resultado EAX(+)Cl = ",0
ie: db 10,"Inciso E: ",0
NH: db 10,"Captura Un Numero Hexadecimal",0
if: db 10,"Inciso F: ",10,0

section .text
global _start:

_start: mov esi,cad

    ; Inciso A
    mov edx,ia
    call puts
    mov esi,cadena
    mov eax,0x12

    ; Inciso B
    mov edx,ib
    call puts
    call revBit

    ; Inciso C
    mov edx,ic
    call puts
    call setBit

    ; Inciso D
    mov edx,id
    call puts
    call clearBit

    ; Inciso E
    mov edx,ie
    call puts
    call NotBit

    ; Inciso F
    mov edx,if
    call puts

    ; Kernel Exit Call
    mov eax,1
    mov ebx,0
    int 0x80

;Inciso A
printBin:
    pushad
.cycle div cl
    mov [cadena],ax
    mov dx,[cadena]
    loop .cycle
    popad
    int 0x80
    ret

;Inciso B
revBit:
    pushad
    mov eax,0x124EFAED
    mov cl,0x12
    shr eax,cl
    lahf
    call printHex
    call salto_linea
    popad
    int 0x80
    ret

;Inciso C
setBit:
    pushad
    ;mov eax,0x567E
    call printHex
    mov cl,0xFA
    or eax,ecx
    mov edx,resultOR
    call puts
    call printHex
    popad
    int 0x80
    ret

; Inciso D
clearBit:
    pushad
    ;mov eax,0x1234567B
    call printHex
    mov cl,0xA1
    and eax,ecx
    mov edx,resultAND
    call puts
    call printHex
    popad
    int 0x80
    ret

;Inciso E
NotBit:
    pushad
    mov eax,0x1234567B
    call printHex
    mov cl,0x81
    xor eax,ecx
    mov edx,resultXOR
    call puts
    call printHex
    popad
    int 0x80
    ret

;Inciso F
testBit:
    pushad
    popad
    int 0x80
    ret

printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    .nxt: shr eax,cl
    .msk: and eax,ebx
    cmp al, 9
    jbe .menor
    add al,7
    .menor:add al,'0'
    mov byte [esi],al
    inc esi
    mov eax, edx
    cmp cl, 0
    je .print
    sub cl, 4
    cmp cl, 0
    ja .nxt
    je .msk
    .print: mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret

salto_linea:
    pushad
    mov eax,4
    mov ebx,1
    mov ecx, NL
    mov edx, NL_L
    int 80h
    popad
    ret