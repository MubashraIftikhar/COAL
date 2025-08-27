.model small
.stack 100h

.data
	str0 db "Enter a String: $"
	str1 db 10,13,"The Reverse of a String is: $"
	output db 50 dup ("$")
	input db 50 dup ("$")
	
.code
main proc
	mov ax,@data
	mov ds,ax
	
	lea dx,str0
	mov ah,09
	int 21h
	
	lea si, input
	lea di, output
	
	
again:
	mov cx,0
aa:	
	mov ah,01
	int 21h
	
	cmp al,13
	je reverse
	
	cmp al,' '
	je reverse
	
	mov [si],al
	inc si
	inc cx
	jmp aa
	
reverse:
	dec si
	
again1:
	mov bl,[si]
	mov [di],bl
	
	inc di 
	dec si
	dec cx
	jnz again1
	
	
	cmp al,13
	je exit 
	
	mov bl,' '
	mov [di],bl
	inc di
	jmp again

exit:
	lea dx,str1
	mov ah,09
	int 21h
	
	lea dx,output
	mov ah,09
	int 21h
	
	mov ah,4ch
	int 21h
	
main endp
end main
	
	