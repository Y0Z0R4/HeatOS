print_banner:
    mov byte [text_color], 13 ; Light Magenta
    mov si, banner_line1
    call print_string
    call print_newline
    mov si, banner_line2
    call print_string
    call print_newline

    mov byte [text_color], 5  ; Magenta
    mov si, banner_line3
    call print_string
    call print_newline

    mov byte [text_color], 1  ; Blue
    mov si, banner_line4
    call print_string
    call print_newline

    mov byte [text_color], 9  ; Light Blue
    mov si, banner_line5
    call print_string
    call print_newline

    mov byte [text_color], 3  ; Cyan
    mov si, banner_line6
    call print_string
    call print_newline

    mov byte [text_color], 11 ; Light Cyan
    mov si, banner_line7
    call print_string
    call print_newline

    mov byte [text_color], 15 ; White
    mov si, banner_line8
    call print_string
    call print_newline
    mov si, banner_line9
    call print_string
    call print_newline
    mov si, banner_line10
    call print_string
    call print_newline

    mov byte [text_color], 11 ; Light Cyan
    mov si, banner_line11
    call print_string
    call print_newline

    mov byte [text_color], 3  ; Cyan
    mov si, banner_line12
    call print_string
    call print_newline

    mov byte [text_color], 9  ; Light Blue
    mov si, banner_line13
    call print_string
    call print_newline

    mov byte [text_color], 1  ; Blue
    mov si, banner_line14
    call print_string
    call print_newline

    mov byte [text_color], 5  ; Magenta
    mov si, banner_line15
    call print_string
    call print_newline

    mov byte [text_color], 13 ; Light Magenta
    mov si, banner_line16
    call print_string
    call print_newline

    mov byte [text_color], 0x0F ; Reset to white
    ret

print_char:
    push ax
    push bx
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, [text_color]
    int 0x10
    pop bx
    pop ax
    ret

print_string:
    pusha
.next_char:
    lodsb
    test al, al
    jz .done
    call print_char
    jmp .next_char
.done:
    popa
    ret

print_newline:
    pusha
    mov al, 13
    call print_char
    mov al, 10
    call print_char
    popa
    ret

print_boot_summary_line:
    mov si, boot_summary_a
    call print_string
    mov al, [boot_drive]
    call print_hex_byte
    mov si, boot_summary_b
    call print_string
    xor ax, ax
    mov al, [kernel_sectors]
    call print_word_decimal
    mov si, boot_summary_c
    call print_string
    ret

print_boot_info_inline:
    push ax
    push bx
    push dx
    push si

    mov si, boot_inline_a
    call print_string
    mov al, [boot_drive]
    call print_hex_byte

    mov si, boot_inline_b
    call print_string
    xor ax, ax
    mov al, [kernel_sectors]
    call print_word_decimal

    mov si, boot_inline_c
    call print_string
    xor ax, ax
    mov al, [kernel_sectors]
    mov bx, 512
    mul bx
    call print_dword_decimal

    mov si, boot_inline_d
    call print_string

    pop si
    pop dx
    pop bx
    pop ax
    ret
