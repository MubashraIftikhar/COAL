.model small
.386
.stack 100h
.data
arr db 5 dup('$')
.code 

main proc	
	
	mov ax , @data
	mov ds , ax
	
	lea si , arr
	lea di , arr
	mov cl , 05

input:	
	xor bl , bl
	call BinInput
	dec cl ;take ip 5times
	Jnz input
	
	
	mov ch , 05	 ;to display 5times
output:	

	call HexOutput
	dec ch
	jnz output
			
mov ah , 4ch
int 21h

main endp

BinInput proc
	
	mov ch, 8
	
again:
	mov ah, 01h
	int 21h
		
	sub al, 48
	
	shl bl, 1
	or bl, al
	
	dec ch
	jnz again
	
	mov [si] , bl
	inc si
	
	mov dl , 10
	mov ah , 02h
	int 21h
	
	mov dl , 13
	mov ah , 02h
	int 21h
	
	ret
	
BinInput endp


HexOutput proc
	mov bx , 0
	mov bl , [di]
	mov cl , 02
again:
	rol bl , 4
	mov dl , bl
	and dl , 0fh
	cmp dl , 09h
	Jbe aa
	add dl , 07
aa:
	add dl , 30h
	mov ah , 02
	int 21h
	dec cl
	jnz again
	
	inc di

	mov dl , 10
	mov ah , 02h
	int 21h
	
	mov dl , 13
	mov ah , 02h
	int 21h
	
	ret
HexOutput endp


end main