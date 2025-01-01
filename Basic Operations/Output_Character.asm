.model small
.stack 100
.data
.code
.main proc
	mov ax,@data
	mov ds,ax
	mov al,'A'
	mov ah,'02'
	int 21h
	
	mov ah,4ch
	int 21h
main endp
end main