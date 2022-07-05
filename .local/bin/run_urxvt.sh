#!/bin/sh

args=(
    ## common settings
    # -sr                          # scrollBar_right
    # -st                          # scrollBar_floating
    -scrollstyle plain           # scrollstyle
    +sb                          # scrollBar - on(default):-sb  off:+sb
    # -bc                          # cursorBlink
    # -uc                          # cursorUnderline
    -pointerBlank                # pointerBlank
    -vb                          # visualBell
    -sl 3000                     # saveLines
    -fade 35                     # fading

    ## font
    -fn 'xft:Inconsolata Nerd Font Mono-12, xft:IPAGothic'
    -letsp -1                    # letterSpace
    #-lsp 0                       # lineSpace

    ## color / opacity
    ## gruvbox-dark https://github.com/morhetz/gruvbox
    -depth       32              # depth
    -color0      '[90]#2E3440'   # (black)
    -color1      '[90]#3B4252'   # (red)
    -color2      '[90]#434C5E'   # (green)
    -color3      '[90]#4C566A'   # (yellow)
    -color4      '[90]#D8DEE9'   # (blue)
    -color5      '[90]#E5E9F0'   # (magenta)
    -color6      '[90]#ECEFF4'   # (cyan)
    -color7      '[90]#8FBCBB'   # (white)
    -color8      '[90]#88C0D0'   # (bright black)
    -color9      '[90]#81A1C1'   # (bright red)
    -color10     '[90]#5E81AC'   # (bright green)
    -color11     '[90]#BF616A'   # (bright yellow)
    -color12     '[90]#D08770'   # (bright blue)
    -color13     '[90]#EBCB8B'   # (bright magenta)
    -color14     '[90]#A3BE8C'   # (bright cyan)
    -color15     '[90]#B48EAD'   # (bright white)
    -fg          '[90]#D8DEE9'   # foreground
    -bg          '[90]#2E3440'   # background
    -colorIT     '[90]#A3BE8C'   # (italic characters)
    -colorBD     '[90]#d5c4a1'   # (bold characters)
    -colorUL     '[90]#83a598'   # (underlined characters)
    -scrollColor '[90]#A3BE8C'   # (scrollbar)
    #-troughColor '[90]#3C3836'   # (scrollbar's trough area)

    # -pe tabbed

    "$@"
)

urxvtc "${args[@]}" >/dev/null 2>&1 || {
    [ "$?" -eq 2 ] && urxvtd -q -o -f && urxvtc "${args[@]}"
}
