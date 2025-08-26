.model small
.stack 100h
.386
.data
    str1 db 10,13,"Enter hex number (0-FFFF):$"
    str2 db 10,13,"Binary Output: $"
    err1 db 10,13,"Illegal hex digit,try again:$"
.code
main proc
    mov ax, @data
    mov ds, ax

    ;xor bx, bx       
    ;mov cx, 4     ;input for hex begin here

start:
	xor bx, bx 
	mov cx, 4
    mov dx, offset str1
    mov ah, 09h
    int 21h      

again:  
    mov ah, 01h
    int 21h
    
    cmp al, 13
    je output     
    
    cmp al, '0'   ;invalid case below 0
    jb err        

    cmp al, '9' ;valid case between 0&9
    jbe valid_ip
    
    cmp al, 'A' ;invalid case below A
    jb err       
    
    cmp al, 'F' ;invalid case above F
    ja err      

valid_ip:
    cmp al, '9'
    ja letter    
    
    sub al,'0' ;48d
    jmp shifting

letter:
    sub al,37h ;or do 55

shifting:
    shl bx, 4     
    or bl, al     
    
    dec cx
    jnz again  ;if not total of 4 character entered again take ip

output:        ;Binary output code begin here
    mov dx, offset str2
    mov ah, 09h
    int 21h      

    mov cx, 16    

again2:
    rol bx, 1     ;ror to reverse
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
    jnz again2    ;B_out ends here

exit:
    mov ah, 4ch
    int 21h       

err:
	xor bx,bx
    mov dx, offset err1
    mov ah, 09h
    int 21h      
    jmp start

main endp
end main
