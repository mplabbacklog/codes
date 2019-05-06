 section .data
    menumsg db 10,10,'Menu for non-overlapped data transfer',10
          db 10,' 1.The content of the source and dest before transfer is:'
          db 10,' 2.The content of the  source and dest after transfer  without string is:'
            db 10,' 3.The content of the  source and dest after transfer  with string is:'
          db 10,' 4.exit',10
    menumsglen :equ $-menumsg
    msg db 10,'Enter the choice',10
    msglen :equ $-msg

        srcmsg  db 10,'block contents before tranfer:-',10
        srcmsglen :equ $-srcmsg
        dstmsg  db 10,'destblock contents before tranfer:-',10
        dstmsglen :equ $-dstmsg
    srcmsg1  db 10,'block contents after tranfer:-',10
        srcmsglen1 :equ $-srcmsg1
        dstmsg1 db 10,'block contents after tranfer:-',10
        dstmsglen1 :equ $-dstmsg1
        spacechar db 20h


        src db 01H,02H,03H,04H,05H       ;initialize value of src
        destblk times 5 db 0             ;initialize value of destblk to 00000
        cnt equ 05h                      ;set counter as 5

    section .bss

        option resb 02
        dispbuff resb 02
        ch1 resb 2

    %macro dispmsg 2                    ;macro for writing operation
        mov rax,01
        mov rdi,01
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro

    %macro accept 2                     ;macro for reading operation
        mov rax,0
        mov rdi,0
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro

section .code
global _start
_start:

lll:dispmsg menumsg,menumsglen
    dispmsg msg,msglen


    accept option,2
    mov al,[option]               ;compare value of the options
    cmp al,31h
    je input
    cmp al,32h
    je d2
    cmp al,33h
    je d3
    cmp al,34h
    je exit


input:    ;dispmsg msg,msglen
    dispmsg dstmsg,dstmsglen

    mov rsi,src                 ;rsi will point to the base address of src
    xor rcx,rcx                 ;clear counter register cx

    call d_proc


    dispmsg srcmsg,srcmsglen

    mov rsi,destblk
    xor rcx,rcx
    call d_proc
    jmp lll


    ; without string
d2:mov rsi,src                  ;rsi will point to the base address of src
    mov rdi,destblk             ;rdi will point to the base address of destblk
    mov rcx,05h                 ;set counter as 5
d22:mov al,[rsi]                ;get contents from rsi and store them in al temporarily
    mov [rdi],al                ;store the temporary data collected from rsi into al in the contents of rdi
    inc rsi
    inc rdi
    dec rcx
    jnz d22
    dispmsg srcmsg1,srcmsglen1
    mov rsi,src
    xor rcx,rcx                 ;clear the counter register
    call d_proc
    dispmsg dstmsg1,dstmsglen1

    mov rsi,destblk
    xor rcx,rcx
    call d_proc
    jmp lll

d3:mov rsi,src
    mov rdi,destblk
    mov rcx,05h
    cld
    rep movsb
    dispmsg srcmsg1,srcmsglen1
    mov rsi,src
    xor rcx,rcx
    call d_proc
    dispmsg dstmsg1,dstmsglen1

    mov rsi,destblk
    xor rcx,rcx
    call d_proc
    jmp lll

exit:
      mov rax,60
      mov rsi,00
      syscall

d_proc:     mov rcx,cnt           ;move value of counter into cx register
d12:     push rcx                 ;push value of cx register onto the stack
     mov bl,[rsi]
     push rsi                     ;push value of rsi register onto the stack
     call display
     dispmsg spacechar,1          ;display a space by spacebar declared in the .data section
     pop rsi                      ;pop value of rsi from the stack
     inc rsi                      ;increment value of rsi
    pop rcx                       ;pop value of rcx from the stack
    loop d12                      ;loop until cx is not 0
    ret                           ;return to the statement from where jumped

display:    mov rcx,2           ;set counter as 2
        mov rdi,dispbuff        ;rdi will point to the base address of dispbuff

    dup1:    rol bl,4           ;rotate contents of bl by 4 bits, i.e. by 1 digit
        mov al,bl
        and al,0fh              ;mask contents of al
        cmp al,09
        jbe dskip
        add al,07h
    dskip:    add al,30h
        mov [rdi],al
        inc rdi
        loop dup1
    dispmsg dispbuff,03
        ret                      ;return to the statement from where jumped
