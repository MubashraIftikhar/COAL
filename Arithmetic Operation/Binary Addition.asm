.model small
.stack 100h
.data
str1 db "Enter a Binary number(8-digits):$"
str2 db 10,13,"Enter another Binary number (8-digits):$"
str3 db 10,13,"The Binary Sum is:$"

.code
main proc
    mov ax, @data
    mov ds, ax


    mov dx, offset str1 ;input st
    mov ah, 09h
    int 21h

	xor bx,bx
	mov cx,8
	
again:

	mov ah,1
	int 21h
	
	cmp al,13
	je cc

	sub al,48
	
	shl bl,1
	or bl,al
	
	dec cx
	jnz again
	
	mov bh,bl ;ip1 in bh
	
    mov dx, offset str2 ;input st2
    mov ah, 09h
    int 21h

cc:
	mov cx,8	
again2:
	mov ah,1
	int 21h
	
	cmp al,13
	je addition
	
	sub al,48
	shl bl,1
	or bl,al
	
	dec cx
	jnz again2
	
addition:

;Binary output code begin here
    mov dx, offset str3
    mov ah, 09h
    int 21h      
	
	add bl,bh
	jnc dispBin
	
	mov bl,'1'
	mov ah,02
	int 21h

dispBin:
    mov cx,8   

ag:
    shl bl, 1     
    jc one

    mov dl, '0'   
    mov ah, 02h
    int 21h      
    jmp next

one:
    mov dl, '1'   
    mov ah, 02h
    int 21h       

next:
    dec cx
    jnz ag   ;B_out ends here
	
    mov ah, 4ch
    int 21h

main endp
end main

	