jmp start

msg db 'h',0x07,'e',0x07,'l',0x07,'l',0x07,'o',0x07,' ',0x07,'w',0x07,\
    'o',0x07,'r',0x07,'l',0x07,'d',0x07
msg_end

start:
    mov ax, 0x7c0
    mov ds, ax
    mov si, msg

    mov ax, 0xb800
    mov es, ax
    mov di, 0

    cld

    mov cx, (msg_end-msg)/2
    rep movsw

number equ 510-($-$$)
times number db 0x0
    dw 0xaa55
