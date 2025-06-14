#!/usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

#source "$HOME/.cargo/env.fish"
#fish_add_path "~/.cargo/bin"
#fish_add_path ~/.nimble/bin
