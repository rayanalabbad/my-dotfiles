#!/usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

function figloldate
    clear
    date | figlet -c | lolcat -as 100
end

source "$HOME/.cargo/env.fish"
fish_add_path "~/.cargo/bin"
set -x TERM xterm-256color
ulimit -n 32768

fish_add_path ~/.nimble/bin
