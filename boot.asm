org 0x7c00

; This is a program showing the value in ax
; Since values in ax varies from 0x0 to 0xFFFF which is
; 0 to 65535 in decimal, so we just need five digits to
; represent the value.

    mov cx, 0xb800
    mov ds, cx

    mov ax, 0
bigloop
    push ax
    call show
    pop ax
    inc ax
    call delay
    call clear
    jmp bigloop

delay:
    mov cx, 0x800
.loo
    push cx
.lo:
    mov word [0xa], 0x0720
    loop .lo

    pop cx
    loop .loo

    ret
    
clear:
    push bp
    mov bp, sp
    mov di, 0
    mov cx, 5
lo:
    mov word [di], 0x0720
    add di, 2
    loop lo
    mov sp, bp
    pop bp
    ret

show:
    push bp
    mov bp, sp
    mov ax, [bp+4]
    mov di, 8
    mov bx, 10
    mov cx, 5
scan:
    xor dx, dx  ; clear dx
    idiv bx
    mov dh, 0x02
    add dl, 0x30
    mov [di], dx
    sub di, 2
    loop scan
    mov sp, bp
    pop bp
    ret

number equ 510-$+$$
times number db 0
db 0x55,0xaa
