.model small
.stack 100h
.386
.data
str0 db 50 dup('$')          ; Input buffer
str1 db 10,13,"Enter string: $"
str2 db 10,13,"String is palindrome$"
str3 db 10,13,"String is not palindrome$"

.code
main proc
    mov ax,@data
    mov ds,ax

    lea si, str0              ; SI -> input buffer
    mov cx, 0                 ; Character counter

    ; Prompt user
    mov dx, offset str1
    mov ah, 09
    int 21h

input:
    mov ah, 01h               ; Read character
    int 21h
    cmp al, 13                ; Check for ENTER key
    je check                  ; If ENTER pressed, go to check

    mov [si], al              ; Store character in buffer
    inc si
    inc cx                    ; Count characters
    jmp input

check:
    ; Set SI to start, DI to end
    lea si, str0
    mov di, si
    add di, cx
    dec di                    ; Point DI to last character

palindrome_check:
    cmp si, di                ; If pointers crossed, string is palindrome
    ja palindrome

    mov al, [si]
    mov bl, [di]
    cmp al, bl                ; Compare chars from start and end
    jne not_palindrome

    inc si                    ; Move forward
    dec di                    ; Move backward
    jmp palindrome_check

palindrome:
    mov dx, offset str2       ; "String is palindrome"
    mov ah, 09
    int 21h
    jmp terminate

not_palindrome:
    mov dx, offset str3       ; "String is not palindrome"
    mov ah, 09
    int 21h

terminate:
    mov ah,4Ch
    int 21h

main endp
end main
