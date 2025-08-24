.model small
.stack 100h
.data
	str1 db "Enter a number(0-9):$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dx,offset str1 ;print str
	mov ah,09h
	int 21h
	
	mov ah,01h;input
	int 21h
	
	mov bl,al
	sub bl,'0'
	inc bl     ;inclusive
	mov cl,bl  ;counter
	
	mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13 ;carriage return  // to print 0 in newline
	mov ah,02h
	int 21h
	
	mov bh,'0'
	
	aa:mov dl,bh	
	mov ah,2
	int 21h
	
	mov dl,10;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	
	inc bh
	dec cl
	jnz aa
		
	
	mov ah,4ch
	int 21h

main endp
end main