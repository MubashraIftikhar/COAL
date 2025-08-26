.model small
.stack 100h
.data
	str1 db 10,13,"Enter first digit:$"
	str2 db 10,13,"Enter second digit:$"
	
	err1 db 10,13,"Wrong choice$"
	err2 db 10,13,"ERROR:1st is greater than 2nd$"
	err3 db 10,13,"you have entered wrong options thrice , program aborted $"
	
	msg  db 10,13,"do you want to exit(e) or restart(s):$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov ch,3
	
	start:mov dx,offset str1
	mov ah,09h
	int 21h
	
	mov ah,01h  ;i/p 1
	int 21h
	
	mov bl,al
	sub bl,'0'
	
	cmp bl,9
	jg er1
	
	mov dx,offset str2
	mov ah,09h
	int 21h
	
	mov ah,01h ;i/p 2
	int 21h
	
	
	mov bh,al
	sub bh,'0'
	
	cmp bl,9
	jg er1
	
	cmp bl,bh
	ja er2
	
	sub bh,bl
	mov cl,bh
	inc cl
	
	add bh,bl
	add bl,'0'
	
	bb:mov dl,10 ;newline
	mov ah,02h
	int 21h
	
	
	mov dl,13;carriage return
	mov ah,02h
	int 21h
	

	mov dl,bl
	mov ah,02h
	int 21h
	
	cmp dl,bh
	je m
	
	inc bl
	dec cl
	jnz bb

	m:
	mov dx,offset msg
	mov ah,09h
	int 21h
	
	mov ah,01
	int 21h
	
	mov bh,al
	
	cmp bh,'e'
	je aa
	
	dec ch
	jz er3
	
	cmp bh,'s'
	je start
	
	
	er3:mov dx,offset err3
	mov ah,09h
	int 21h
	jmp aa
	
	er1:mov dx,offset err1
	mov ah,09h
	int 21h
	jmp m
	
	er2:mov dx,offset err2
	mov ah,09h
	int 21h
	jmp m
	
	aa:	
	mov ah,4ch
	int 21h

main endp
end main