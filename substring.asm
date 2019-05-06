;Write an ALP to perform string manipulation. the string to be accepted from the user is to be stored in the data segment of the program 1 and write far procedures in code segement program 2 for the following operations on the string
;a concatenation of 2 strings
;B number of occurrences of a substring in the given string
;c number of spaces in the given string


;Number of occurrences


section .data
	string: db "computer",10
	len: equ $-string
	sbs: db "ter",10
	lenn: equ $-sbs
	msg: db "match"
	ln: equ $-msg
	ms: db "mismatch"
	un: equ $-ms
	msg3 db'',10
	len3: equ $-msg3
	
	
section .text
	global _start
_start:
	mov ecx, len
	mov edx,lenn
	mov esi,string
	mov edi, sbs
	
	
	again:
		mov al,[esi]
		mov bl,[edi]
		cmp al,bl
		jne a
		je b
		
	
	a:
		inc esi
		dec ecx
		jnz again
		jz mss
		
	b:
		inc esi
		inc edi
		dec edx
		jnz again
		jz msgg
		
		
		
	mss:
		mov eax, 4
		mov ebx, 1
		mov ecx, ms
		mov edx, un
		int 80h
		jmp exit
		
	msgg:
		mov eax, 4
		mov ebx,1
		mov ecx,msg
		mov edx,ln
		int 80h
		
		mov eax,4
		mov ebx,1
		mov ecx,msg3
		mov edx,len3
		int 80h
		
	exit:
		mov eax,1
		mov ebx,0
		int 80h
		
		
		


