#!/usr/bin/env fish

eval "$(/opt/homebrew/bin/brew shellenv)"

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

fish_add_path "~/.cargo/bin"
set -x TERM xterm-256color
ulimit -n 32768

set -x LDFLAGS "-L/opt/homebrew/opt/tcl-tk/lib"
set -x CPPFLAGS "-I/opt/homebrew/opt/tcl-tk/include"