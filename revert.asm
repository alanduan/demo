    org 0x7c00

    jmp start

string db 'abcdefghijklmnopqrstuvwxyz'
string_end

start:
    ; ds <- cs
    mov ax, cs
    mov ds, ax

    ; es <- 0xb800
    mov ax, 0xb800
    mov es, ax

    ;call show
    call revert
    call show

    jmp $

revert:
    mov si, string
    mov di, string_end - 1
.letter:
    cmp di, si
    jle .done
    mov al, [di]
    mov ah, [si]
    mov [di], ah
    mov [si], al
    inc si
    dec di
    jmp .letter
.done
    ret

show:
    mov bx, string
    mov si, 0
    mov di, 0
    mov cx, string_end - string
.letter:
    mov al, [bx+si]
    mov ah, 0x02
    mov [es:di], ax
    add di, 2
    inc si
    loop .letter
    ret

times 510-($-$$) db 0x0
    db 0x55,0xaa
