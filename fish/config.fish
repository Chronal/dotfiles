if status is-interactive
    # Commands to run in interactive sessions can go here
end

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/chronal/.opam/opam-init/init.fish' && source '/home/chronal/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# Environment Variables
set -gx EDITOR vim
set -gx VISUAL emacsclient --create-frame --alternate-editor=vim

set -gx LD_LIBRARY_PATH "/usr/lib64" "/usr/local/lib64" "/usr/local/lib/" "$HOME/.local/lib"

## XDG
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

## pnpm
set -gx PNPM_HOME "/home/chronal/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Adding things to $PATH
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
