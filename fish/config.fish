if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Environment Variables
set -gx EDITOR vim
set -gx VISUAL emacsclient --create-frame --alternate-editor=vim

set -gx LD_LIBRARY_PATH "$HOME/.local/lib" /usr/local/lib /usr/local/lib64

## XDG
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

## pnpm
set -gx PNPM_HOME $XDG_DATA_HOME/pnpm

# SSH
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -gx SSH_ASKPASS ksshaskpass

# Adding things to $PATH
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.config/emacs/bin # Doom
fish_add_path $PNPM_HOME

# BEGIN opam configuration, only needed for Rocq
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/chronal/.opam/opam-init/init.fish' && source '/home/chronal/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration

# Adds fzf keybinds to fish if it's installed
command -q fzf; and fzf --fish | source

# Theming
fish_config prompt choose acidhub
fish_config theme  choose 'Tomorrow Night Bright'
