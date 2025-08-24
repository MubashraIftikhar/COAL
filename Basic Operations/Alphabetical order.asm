.model small
.stack 100h
.data
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dl,'?'
	mov ah,02h
	int 21h
	
	mov ah,01h;read 1st char
	int 21h
	mov bl,al
	
	mov ah,01h ;read 2nd char
	int 21h
	mov bh,al
	
	mov dl,10
	mov ah,2
	int 21h
	
	mov dl,13
	mov ah,2
	int 21h
	
	CMP bh,bl
	JA  aa
	
	xchg bl,bh
	
		
	aa:mov dl,bl ;display 1st char
	mov ah,02h
	int 21h
	
	mov dl,bh ;display 2nd char
	mov ah,02h
	int 21h

	
	mov ah,4ch
	int 21h

main endp
end main