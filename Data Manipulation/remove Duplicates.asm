.model small
.stack 100h
.data
    str1 db "Enter a string:$"
    str2 db 0Ah,0Dh,"Output is: $"
    input db 50 dup('$')
    stack db 50 dup('$')   ; Manual stack buffer
    top db 0               ; Stack pointer

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt user
    mov dx, offset str1
    mov ah, 09
    int 21h

    lea si, input   ; SI -> input buffer
    lea di, stack   ; DI -> stack base
    mov top, 0      ; Reset stack pointer

read_input:
    mov ah, 01      ; Read a character
    int 21h
    cmp al, 13      ; Check for Enter key
    je display_result

    ; If stack empty, push character
    mov cl, top
    cmp cl, 0
    je push_char

    ; Compare with top character on stack
    mov bl, [di + top - 1]
    cmp bl, al
    je pop_char         ; If equal, pop and discard both

push_char:
    mov [di + top], al  ; Push current char to stack
    inc top
    jmp read_input

pop_char:
    dec top             ; Pop previous char
    jmp read_input

display_result:
    mov dx, offset str2
    mov ah, 09
    int 21h

    ; Print stack content from 0 to top-1
    mov cl, top
    mov si, 0
print_loop:
    cmp si, cl
    je exit_program

    mov dl, [di + si]
    mov ah, 02
    int 21h

    inc si
    jmp print_loop

exit_program:
    mov ah, 4Ch
    int 21h

main endp
end main
