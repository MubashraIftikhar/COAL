.model small
.stack 100h
.386
.data
var db 4
str1 db 10,13,"Enter a binary number up to 16 digits:$"
str2 db 10,13,"Hex Output: $"
err1 db 10,13,"Illegal binary digit,try again:$"
.code
main proc
	mov ax, @data
    mov ds, ax

	xor bx,bx   ;bl empty
	
	mov cl,16    ;counter
	
	mov dx, offset str1   ;display str1
    mov ah, 09h
    int 21h
again:
	mov ah,01h      ;input for str1
	int 21h
	
	cmp al,13      ;jmp 
	je output
	
	cmp al,'0'   ;invalid case below 0
    jb	err 

    cmp al,'1' ;valid case 0 or 1
    jbe bb
	
	cmp al,'1' ;invalid case not 1
    ja err
	
	
bb:	sub al,'0'       ;make ascii

	shl bx,1    ;shift bin
	or bl,al     ;set
	
	dec cl
	jnz again

output:
	mov dx, offset str2   ;str2 dis
    mov ah, 09h
    int 21h
	
	mov cx,4
	
again2:
    rol bx,4     
    
    mov dl,bl        
    and dl,0fh
	cmp dl,9
	ja letter
	
	add dl,48d
	JMP op
	

letter:
	add dl,55d
	
op:
	mov ah,02h
	int 21h
	
	dec cx
	jnz again2

exit:
    mov ah, 4ch
    int 21h

err:
	xor bx,bx
    mov dx, offset err1
    mov ah, 09h
    int 21h      
    jmp again

main endp
end main