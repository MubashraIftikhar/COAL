.model small
.stack 100h
.data
	str1 db "Enter two digits:$"
	str2 db "Enter operator(+ or -):$"
	str3 db "Sum is:$"
	str4 db "Difference:$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dx,offset str1
	mov ah,09h
	int 21h
	
	mov ah,01h ;i/p 1
	int 21h
	
	mov bl,al
	sub bl,'0'
	
	mov ah,01h ;i/p 2
	int 21h
	
	mov bh,al
	sub bh,'0'
	
	mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	
	mov dx,offset str2
	mov ah,09h
	int 21h
	
	mov ah,01h ;i/p 3 (opr)
	int 21h
	mov cl,al
	
	mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	
	cmp cl,'+' 
	JE aa
		
	mov dx,offset str4 ;difference
	mov ah,09h
	int 21h
	
	cmp bh,bl
	ja cc
	
	sub bl,bh 
	add bl,'0'
	mov dl,bl
	mov ah,02h
	int 21h
	JMP bb
	
	cc:sub bh,bl
	add bh,'0'
	mov dl,bh
	mov ah,02h
	int 21h
	JMP bb
	
aa:	
	mov dx,offset str3
	mov ah,09h
	int 21h
	
	add bh,bl
	add bh,'0'
	mov dl,bh
	mov ah,02h
	int 21h
		

	bb:mov ah,4ch
	int 21h

main endp
end main