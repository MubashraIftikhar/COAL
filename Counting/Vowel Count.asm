.model small
.stack 100h
.data
	str1 db 10 dup('$')
	str2 db "Enter a string:$"
	str3 db "Vowel character are:$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dx,offset str2 ;print str
	mov ah,09h
	int 21h
	
	mov si,offset str1
	mov cl,'0'
again:
	mov ah,01
	int 21h
		.
	mov [si],al
	mov bl,al
	inc si
	
	cmp bl,'a'
	je count
	
	cmp bl,'e'
	je count
	
	cmp bl,'i'
	je count
	
	cmp bl,'o'
	je count
	
	cmp bl,'u'
	je count
	
cc:
	cmp al,13  ;bl is input
	jne again
	
	mov dx,offset str3 ;print str
	mov ah,09h
	int 21h
	
	mov dl,cl
	mov ah,02h
	int 21h
	
	jmp exit 
	
count:	
	add cl,1
	jmp cc
	
exit:
	mov ah,4ch
	int 21h

main endp
end main