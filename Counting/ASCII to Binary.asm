.model small
.386
.stack 100h

.data
message1 db  10,13,"Enter a character: $"
message2 db  10,13,"The ASCII code of "
char db 00h ;null char
message3 db " in binary is $"
result db 10,13,"The number of 1 bits are : $"

.code 

main proc 
	
	MOV AX , @DATA
	MOV DS , AX
	
	MOV DX , OFFSET message1
	MOV AH , 09H
	INT 21H
	
	MOV AH , 01h	;input1
	INT 21H
	
	mov [char] , al
	mov bl , [char]
	
	MOV DX , OFFSET message2
	mov ah , 09h
	INT 21H
	
	MOV CH , '0'	;NUMBER OF 1 bits mov ch,30h
	
	MOV CL,8
	
aa:	
	ROL BL , 1
	MOV DL , BL
	AND DL , 01h
	add dl , '0'
	cmp dl , '0'
	JE bb
	INC CH
	
bb: 
	MOV AH , 02h
	INT 21h
	
	DEC  CL
	JNZ	aa

	MOV DX , OFFSET result
	mov ah , 09h
	INT 21H
	
	mov dl , CH
	mov ah , 02
	int 21h
	
	
MOV AH , 4Ch
INT 21h

main endp
end  main