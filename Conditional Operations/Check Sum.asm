.model small
.stack 100h
.data
	str1 db "Enter 1st digit:$"
	str2 db "Enter 2nd digit:$"
	str3 db "The sum is:$"
	
	
	err1 db "Error! sum is greater than 9$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dx,offset str1 ; 1st digit
	mov ah,09h
	int 21h
	
	mov ah,01h  ;i/p
	int 21h
	
	mov bl,al
	sub bl,'0'
	
	mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	
	mov dx,offset str2 ;2nd digit
	mov ah,09h
	int 21h
	
	mov ah,01h ;i/p
	int 21h
	
	mov bh,al
	sub bh,'0'
	
	
	mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	
	mov dh,'9' 
	sub dh,'0'
	
	add bh,bl
	cmp bh,dh ;bh=sum dh=9  //can directly compare with 9
	JLE aa ;display
	
	mov dx,offset err1
	mov ah,09h
	int 21h
	jmp bb
	
	aa:
	mov dx,offset str3
	mov ah,09h
	int 21h
	
	add bh,'0'
	mov dl,bh
	mov ah,02h
	int 21h
	
	
	bb:mov ah,4ch
	int 21h

main endp
end main