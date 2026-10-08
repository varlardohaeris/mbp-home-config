if status is-interactive
    function ls --description 'List files with eza icons'
        command eza --icons=auto --group-directories-first $argv
    end

    # Commands to run in interactive sessions can go here
end

set -gx PATH /Users/wujiahua/.local/bin $PATH
fish_add_path /opt/homebrew/opt/llvm@21/bin
fish_add_path /opt/homebrew/opt/lld@21/bin

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/wujiahua/.ghcup/bin $PATH # ghcup-env

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/wujiahua/.opam/opam-init/init.fish' && source '/Users/wujiahua/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
#

set -gx XDG_CONFIG_HOME $HOME/.config

#

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

starship init fish | source

abbr -a l 'lsd -l'
abbr -a la 'lsd -a'
abbr -a lla 'lsd -la'
abbr -a lt 'lsd --tree'



string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)

set -gx PATH /Users/wujiahua/Library/Android/sdk/platform-tools $PATH

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<

# opencode
fish_add_path /Users/wujiahua/.opencode/bin


# Added by Antigravity CLI installer
set -gx PATH "/Users/wujiahua/.local/bin" $PATH
