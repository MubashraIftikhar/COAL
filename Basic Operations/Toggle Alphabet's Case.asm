.model small
.stack 100h
.data
	str1 db "Enter a char:$"
	str2 db "You enter:$"
.code
main proc
	mov ax,@data
	mov ds,ax
	
	mov dx,offset str1
	mov ah,09
	int 21h
	
	mov ah,01h
	int 21h
	mov bl, al ; Store the entered character in BL
	
	mov dl,10
	mov ah,02h
	int 21h
	
	mov dl,13
	mov ah,02h
	int 21h
	
	mov dx,offset str2
	mov ah,09
	int 21h

	mov al, bl
    xor al, 20h;00100000b ; Toggle the case by flipping the 6th bit
    mov dl, al
	
	mov ah,02h ;display toggled char
	int 21h
	
	mov ah,4ch
	int 21h

main endp
end main

; using code present in word file with the new line and carriage return
;portion was not giving expected result cuz it was messing up with dl val
;so i first stored dl val in bl when read char
;then shifted bl to al toggled it 
;moved to dl to print 