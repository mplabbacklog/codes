section .data

    msg db 10,'*********MENU************'
    msg_len equ $-msg

    m1 db 10,'1.HEX to BCD:'
    m1_len equ $-m1

    m2 db 10,'2.BCD to HEX:'
    m2_len equ $-m2

    m3 db 10,'3.EXIT'
    m3_len equ $-m3

    m4 db 10,'Enter your choice:'
    m4_len equ $-m4

    hexmsg db 10,'Enter 4 digit Hex number:'
    hexmsg_len equ $-hexmsg

    bcd_conv db 10,'Equivalent BCD conv. is:'
    bcd_conv_len equ $-bcd_conv

    bcdmsg db 10,'Enter 5 digit BCD number:'
    bcdmsg_len equ $-bcdmsg

    hexconv db 10,'Equivalent HEX conv. is:'
    hexconv_len equ $-hexconv



section .bss

    choice resb 02
    numascii resb 06
    dispbuff resb 08
        dispbuff1 resb 08


%macro dispmsg 2        ;macro for writing operation
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro accept 2         ;macro for reading operation
mov rax,00
mov rdi,00
mov rsi,%1
mov rdx,%2
syscall
%endmacro


section .text
global _start
_start:

menu:    dispmsg msg,msg_len
    dispmsg m1,m1_len
    dispmsg m2,m2_len
    dispmsg m3,m3_len
    dispmsg m4,m4_len

    accept choice,02
    cmp byte [choice],'1'       ;compare value of choice with 1
    je H2B

    cmp byte [choice],'2'       ;compare value of choice with 2
    je B2H
cmp byte [choice],'3'           ;compare value of choice with 3
je exit

exit:
mov rax,60
mov rbx,00
syscall




H2B: call HEX2BCD_proc
    jmp menu

B2H: call BCD2HEX_proc
    jmp menu



HEX2BCD_proc:

    dispmsg hexmsg,hexmsg_len

    accept numascii,06
    call read
    mov ax,bx
    mov bx,10             				;set value of bx as 10
    mov rcx,0            			 	;set value of cx as 0
back:    mov dx,0
    div bx                				;divide ax by bx
    push rdx              				;push value of dx register onto the stack
    inc rcx               				;increment counter by 1
    cmp ax,0              				;compare value of ax with 0
    jne back
    mov rdi,dispbuff1

    x1: pop rdx           				;pop value of dx from the stack
     add dl,30h           				;convert the number into ascii for display operation
    mov [rdi],dl
    inc rdi               				;point to next location of rdi
    loop x1               				;loop until cx is not 0
dispmsg bcd_conv,bcd_conv_len
    dispmsg dispbuff1,5
        jmp menu
ret                       				;return to the statement from where jumped


BCD2HEX_proc:
    dispmsg bcdmsg,bcdmsg_len
    accept numascii,6

dispmsg hexconv,hexconv_len

    mov rsi,numascii          			;rsi will point to the base address of numascii
    mov rcx,05                			;set counter as 5
    mov rax,0
    mov ebx,0ah               			;set value of bx as 0a
    xy:    mov rdx,0
    mul ebx                   			;multiply ax with bx
    mov dl,[rsi]
    sub dl,30h                			;convert the number into hexadecimal
    add rax,rdx               			;combine multiplication result if any of rdx and rax into rax
    inc rsi                   			;point to next location of rsi
    loop xy                   ;loop until cx is not 0
    mov ebx,eax
    call display
    jmp menu
    ret                       ;return to the statement from where jumped



read: mov ecx,4               ;set counter as 4
       mov ebx,0
       mov esi,numascii       ;esi will point to the base address of numascii

back1:  rol ebx,4             ;rotate contents of bx by 4 bits, i.e. by 1 digit
       mov al,[esi]
       cmp al,39h
       jbe y1
       cmp al,'a'
       jb y2
       sub al,57h
       jmp y3

y1: sub al,30h                ;code for converting number into hexadecimal
     jmp y3
y2: sub al,37h

y3: add bl,al
    inc esi                   ;point to next location of esi
    loop back1                ;loop until cx is not 0
    ret                       ;return to the statement from where jumped


display:
mov ecx,8                     ;set counter as 8
mov edi,dispbuff              ;edi will point to the base address of dispbuff
again: rol ebx,4              ;rotate contents of bx by 4 bits, i.e. by 1 digit
       mov al,bl
       and al,0Fh             ;mask contents of al
       cmp al,9
       jbe l1
       cmp al,'a'
       jb l2
       add al,57h
       jmp l3
l1:    add al,30h
       jmp l3
l2:    add al,37h
l3:    mov [edi],al
       inc edi                  ;point to next location of edi
       loop again               ;loop until cx is not 0
       dispmsg dispbuff,8
           ret                  ;return to the statement from where jumped
