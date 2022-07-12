function fish_prompt --description "Main prompt"
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    printf '%s%s@%s%s %s%s %s%s%s%s \n$ '  \
        (set_color $fish_color_user) $USER \
        (set_color $fish_color_host) (prompt_hostname) \
        (set_color $fish_color_cwd) (prompt_pwd) $pipestatus_string (set_color normal)

end


function fish_right_prompt --description "Right-side prompt"
    printf '%s[%s]' (set_color $fish_color_host) (date '+%Y/%m/%d(%a)%H:%M:%S')
end
