.model small
.stack 100h
.386
.data
str1 db 10,13,"Enter a character:$"
str2 db 10,13,"ASCII of $"
str3 db " in hexa is;$"

.code
main proc
	mov ax, @data
    mov ds, ax

doosri:
    mov dx, offset str1
    mov ah, 09h
    int 21h
   
    mov ah, 01h
    int 21h
	mov bl,al
	
	cmp bl,13
	je exit
	
	mov dx, offset str2
    mov ah, 09h
    int 21h
	
	mov dl, al      ; Print i/p character
    mov ah, 02h
    int 21h
		
	mov dx, offset str3
    mov ah, 09h
    int 21h
	
	mov cl,2
	

again:
    rol bl,4     
    
    mov dl,bl        
    and dl,0fh
	cmp dl,9
	ja letter
	
	add dl,48d
	JMP aa
	

letter:
	add dl,55d
	
aa:
	mov ah,02h
	int 21h
	
	dec cl
	jnz again
	
outer:
	cmp cl,0
	je doosri
exit:
    mov ah, 4ch
    int 21h

main endp
end main