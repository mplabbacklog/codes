section .data

welmsg db 10,'Multiplication using successive addition',10
welmsg_len equ $-welmsg

nummsg db 10,'Enter two digits of Number::'
nummsg_len equ $-nummsg

resmsg db 10,'Multiplication of elements::'
resmsg_len equ $-resmsg

blankmsg db 10,'',10
blank_len equ $-blankmsg

;**********.bss Section**********************

section .bss

    numascii resb 03
    num1 resb 02
    num2 resb 02
    result resb 01
    dispbuff resb 04

%macro display 2          ;macro for writing operation
    mov rax,01
    mov rdi,01
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro accept 2           ;macro for reading operation
    mov rax,00
    mov rdi,00
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

;**********.text Section**********************
section .text
global _start
_start:

    display welmsg,welmsg_len

    display nummsg,nummsg_len
    accept numascii,3
    call packnum                 ;jump to label packnum
    mov byte[num1],bl

    display nummsg,nummsg_len
    accept numascii,3
    call packnum
    mov byte[num2],bl


    mov cx,[num2]               ;set counter for addition
         mov edx,00h            ;Temporary Addition
    mov eax,[num1]


addup:    add edx,eax
    loop addup

    mov [result],edx

    display resmsg,resmsg_len
    mov ebx,[result]

    call disp16_proc

    display blankmsg,blank_len

exit:    mov rax,60
    mov rbx,00
    syscall

;**********Packnum Procedure**********************
packnum:
    mov bl,0            ;clear contents of bl
    mov ecx,02          ;set counter 2
    mov esi,numascii    ;esi will point to the base location of numascii
    up1:rol bl,04       ;rotate contents of bl by 4 bits, i.e. by 1 digit
    mov al,[esi]
    cmp al,39h
    jbe skip1
    sub al,07h
 skip1: sub al,30h      ;convert the number into hexadecimal form ascii
    add bl,al
    inc esi
    loop up1            ;loop until cx is not 0
    ret                 ;return to the statement from where jumped
;**********Display Procedure**********************
disp16_proc:
    mov ecx,4           ;set counter as 4
    mov edi,dispbuff    ;edi will point to the base address of dispbuff
 dup1:  rol bx,4        ;rotate contents of bx by 4 bits, i.e. by 1 digit
    mov al,bl
    and al,0fh          ;mask the contents of al
    cmp al,09
    jbe dskip
    add al,07h
 dskip: add al,30h
        mov [edi],al
        inc edi
        loop dup1       ;;loop until cx is not 0
        display dispbuff,4
        ret             ;;return to the statement from where jumped
