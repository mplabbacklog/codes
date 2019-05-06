section .data
menumsg db 10,10,'Menu for overlapped data transfer',10
      db 10,' 1.The content of the source and dest before transfer is:'
      db 10,' 2.The content of the  source and dest after transfer  without string is:'
        db 10,' 3.The content of the  source and dest after transfer  with string is:'
          db 10,' 4.exit',10   
menumsglen :equ $-menumsg
msg db 10,'Enter the choice',10
msglen :equ $-msg
   
    dstmsg  db 10,'source contents before tranfer:-',10
    dstmsglen :equ $-dstmsg   

    srcmsg  db 10,'destblock contents before tranfer:-',10
    srcmsglen :equ $-srcmsg
   
srcmsg1  db 10,'source contents after tranfer:-',10
    srcmsglen1 :equ $-srcmsg1
    dstmsg1 db 10,'destination contents after tranfer:-',10
    dstmsglen1 :equ $-dstmsg1
        spacechar db 20h
       
       
    src db 01H,02H,03H,04H,05H
    destblk times 3 db 0   
    src1 db 01H,02H,03H,04H,05H
        destblk1 times 3 db 0
   
    cnt equ 05h

section .bss
   
    option resb 02
    dispbuff resb 02
        ;ch1 resb 2

%macro dispmsg 2
    mov rax,01
    mov rdi,01
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

%macro accept 2
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
mov al,[option]
cmp al,31h
je input
cmp al,32h
je d2
cmp al,33h
je d3
cmp al,34h
je exit


input:
;dispmsg msg,msglen
dispmsg dstmsg,dstmsglen

mov rsi,src
xor rcx,rcx

call d_proc

dispmsg srcmsg,srcmsglen

mov rsi,destblk-2
xor rcx,rcx
call d_proc
jmp lll


; without string
d2:mov rsi,src1+4
mov rdi,destblk1+2

mov rcx,05h
d22:mov al,[rsi]
mov [rdi],al
dec rsi
dec rdi
dec rcx
jnz d22
dispmsg srcmsg1,srcmsglen1
mov rsi,src1
xor rcx,rcx
call d_proc
dispmsg dstmsg1,dstmsglen1

mov rsi,destblk1-2
xor rcx,rcx
call d_proc
jmp lll

d3:mov rsi,src+04
mov rdi,destblk-2
add rdi,04H
mov rcx,05h
std

rep movsb
dispmsg srcmsg1,srcmsglen1
mov rsi,src
xor rcx,rcx
call d_proc
dispmsg dstmsg1,dstmsglen1

mov rsi,destblk-2
xor rcx,rcx
call d_proc
jmp lll

exit:
  mov rax,60
  mov rsi,00
  syscall

d_proc:
 mov rcx,cnt

d12:
 push rcx
 mov bl,[rsi]
 push rsi
 call display
 dispmsg spacechar,1
 pop rsi
 inc rsi

pop rcx

loop d12
ret

display:
    mov rcx,2
    mov rdi,dispbuff
   
dup1:
    rol bl,4
    mov al,bl
    and al,0fh
    cmp al,09
    jbe dskip
    add al,07h
dskip:    add al,30h
    mov [rdi],al
    inc rdi
    loop dup1
dispmsg dispbuff,03
    ret


