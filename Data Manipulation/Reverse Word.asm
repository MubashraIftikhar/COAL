.model small
.stack 100h
.data
str0 db "Enter a string:$"
str3 db 10,13,"Reverse is:$"

str1 db 50 dup('$')
str2 db 50 dup('$')


len dw 0
.code
main proc
	
	mov ax,@data
	mov ds,ax
	
	mov si,offset str1
	
	mov dx,offset str0
	mov ah,09h
	int 21h

here:	
	mov cx,0
ag:	
	mov ah,01h       ; Read a character
	int 21h
	
	cmp al,' '
	je rev
	
	cmp al,13        
	je exit
	
	mov [si],al      
	inc si
	inc cx           
	jmp ag


rev:
	mov len,cx
	dec cx ;hello cx=5 sub si,5 will go beyoud so we will subtract 4
	mov si,offset str1
	mov di,offset str2
	add si,cx
aga:	
	mov al,[si]
	mov [di],al
	inc di
	dec si
	dec cx
	jnz aga
	
	jmp here

exit:
	
	mov len,cx
	dec cx ;hello cx=5 sub si,5 will go beyoud so we will subtract 4
	add si,cx
aga:	
	mov al,[si]
	mov [di],al
	inc di
	dec si
	dec cx
	jnz aga
	
	mov dx,offset str2
	mov ah,09
	int 21h
	
	mov si,offset str1 
	mov dl,[si]
	mov ah,02
	int 21h
	
	mov ah,4ch
	int 21h
	
main endp
end main