.model small
.stack 100h
.386
.data

str0 db 50('$')
str1 db 10,13,"Enter Expression: $"
str2 db 10,13,"Too many right brackets, Begin again:$"
str3 db 10,13,"Too many left brackets, Begin again:$"
str4 db 10,13,"Expression is balanced $"
str5 db 10,13,"Do you want to continue (y/n): $"

.code
main proc
    mov ax,@data
    mov ds,ax
	
re:
    mov cl,0
    
start:
    mov dx,offset str1
    mov ah,09
    int 21h

input:
    mov ah,01
    int 21h
    
    cmp al,13
    je check_balance
    
    cmp al,'('
    je opening
    
    cmp al,')'
    je closing
    
    jmp input

opening:
    push ax 
    inc cl  ;keep count of unclosed (
    jmp input

closing:
    cmp cl, 0 ;no opening bracket in stack
    je err1
    
    pop ax ; pop the top of the stack
    dec cl
    
    jmp input
    
check_balance:
    cmp cl,0
    je disp
    
    jmp err2
    
err1:
    mov dx,offset str2
    mov ah,09
    int 21h
    jmp start

err2:
    mov dx,offset str3
    mov ah,09
    int 21h
    jmp start

disp:
    mov dx,offset str4
    mov ah,09
    int 21h
    
    mov dx,offset str5
    mov ah,09
    int 21h
    
    mov ah,01
    int 21h
    
    cmp al,'y'
    je re  ; Restart the process if user enters 'y'
    
    cmp al,'n'
    je terminate  ; Terminate the program if user enters 'n'

    jmp disp ; If user enters anything else, ask again

terminate:
    mov ah,4ch
    int 21h

main endp
end main
