;Write an ALP to perform string manipulation. the string to be accepted from the user is to be stored in the data segment of the program 1 and write far procedures in code segement program 2 for the following operations on the string (Capital letters state the option being performed)
;A concatenation of 2 strings
;b number of occurrences of a substring in the given string
;c number of spaces in the given string



section .data
	msg: db "micro"
	len: equ $-msg
	msg1: db "processor"
	len1: equ $-msg1
	msg2 db '',10
	len2: equ $-msg2
	
section .bss
	concat resb 20
	
section .text
	global _start
_start:

	mov esi,msg
	mov edi,concat
	mov ecx,len
	
	again:
		mov al,[esi]
		mov [edi],al
		inc esi
		inc edi
		loop again
		
		
		mov ecx,len1
		mov esi,msg1
		
		
	againn:
		mov al,[esi] 
		mov [edi],al
		inc esi
		inc edi
		loop againn
		
			
	mov eax,4
	mov ebx,1
	mov ecx,concat
	mov edx, 20
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,len2
	int 80h	
		
	mov eax, 1
	mov ebx, 0
	int 80h
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
