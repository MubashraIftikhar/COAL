.model small
.stack 100h
.386
.data
num1 dw 0           
den1 dw 0           
num2 dw 0           
den2 dw 0  
gcd_val dw 0
lcm dw 0 
temp dw 0  
str1  db "Enter num1:$"
str2  db "Enter denom1:$"
str3  db "Enter num2:$"
str4  db "Enter denom2:$"
str0  db "Result is:$"

.code
main proc

    mov ax,@data
    mov ds,ax
    
    ; Input num1
    mov dx,offset str1
    mov ah,09h
    int 21h
    call dec_input ; Result in BX
    mov [num1],bx
	
    ; Input den1
    mov dx,offset str2
    mov ah,09h
    int 21h
    call dec_input
    mov [den1],bx
	
    ; Input num2
    mov dx,offset str3
    mov ah,09h
    int 21h
    call dec_input
    mov [num2],bx
	
    ; Input den2
    mov dx,offset str4
    mov ah,09h
    int 21h
    call dec_input
    mov [den2],bx

    
    call compute_gcd

    ; Display Result
    lea dx, str0
    mov ah, 09h
    int 21h
    call display_result

    mov ah, 4Ch
    int 21h
main endp

dec_input proc
    mov bx,0
    
again:  
    mov ah,01h        
    int 21h
    
    cmp al,13         
    je exit
    
    sub al,48         
    mov cl,al
    mov ch,0
    
    mov ax,bx
    mov bx,10         
    mul bx            
    
    add ax,cx        
    mov bx,ax         
    jmp again         
exit:
    ret               
dec_input endp

compute_gcd proc
    mov ax,[den1]
    mov bx,[den2]
ag:
    xor dx,dx
    div bx

    cmp dx, 0
    je set

    mov ax, bx
    mov bx, dx
    jmp ag
set:
    mov [gcd_val], bx

    ; LCM Calculation
    mov ax, [den1]
    mul [den2]
    div bx ; Divide by GCD
    mov [lcm], ax

    ; Adjust Numerators
    mov ax, [lcm]
    xor dx, dx
    div [den1]
    mul [num1]
    mov [num1], ax

    mov ax, [lcm]
    xor dx, dx
    div [den2]
    mul [num2]
    mov [num2], ax

    ; Add Numerators
    mov ax, [num1]
    add ax, [num2]
    mov [num1], ax ; result in num1 (as final numerator)

    ret
compute_gcd endp

display_result proc
    mov ax, [num1]
    call print_number
    mov dl, '/'
    mov ah, 02h
    int 21h

    
    mov ax, [lcm]
    call print_number
    ret
display_result endp

print_number proc
    mov cx, 0
    mov bx, 10
convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convert_loop
print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits
    ret
print_number endp

end main
