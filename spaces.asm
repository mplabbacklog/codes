;Write an ALP to perform string manipulation. the string to be accepted from the user is to be
;stored in the data segment of the program 1 and write far procedures in code segement program 
;2 for the following operations on the string (Capital letters state the option being performed)
;a concatenation of 2 strings
;b number of occurrences of a substring in the given string
;C number of spaces in the given string



section .data
	msg: db "micro processor"
	len: equ $-msg
	msg1: db "No spaces available"
	len2: equ $-msg1
	
	
section .bss
	spaces resb 1
	
section .text
	global _start
_start:

	mov ecx,len
	mov esi,[msg]
	xor ebx, ebx
	
	
	again:
		mov al, [esi]
		cmp al,32
		je a
		jne b
		
		
	a:
		inc esi
		inc ebx
		dec ecx
		jnz again
		jz print

	b:
		inc esi
		dec ecx
		jnz again
		jz ms
		
	
	
	mov [spaces], ebx
	
	print:
		mov eax, 4
		mov ebx, 1
		mov ecx, spaces
		mov edx, 1
		int 80h
		jmp exit
		
		
		
	ms:
		mov eax, 4
		mov ebx, 1
		mov ecx, msg1
		mov edx, len2
		int 80h
		jmp exit
		
		
	exit:
		mov eax, 1
		mov ebx, 0
		int 80h
		
