#eval (hub alias -s)
alias b popd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
export FZF_DEFAULT_OPTS="--ansi --extended --cycle"
alias top=htop
if [ -d $HOME/Trash ]
  alias rm='mv --backup=numbered --target-directory=$HOME/Trash'
end
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias se='grep $1 -rl $2'
bind \cd delete-char
alias vi=nvim
alias vim=nvim
export GOPATH=$HOME/.go/vendor
export JAVA_HOME="/opt/java/jdk-11.0.2"
export PATH="$PATH:$HOME/.go/go/bin:$GOPATH/bin:$HOME/gowin/IDE/bin/:/usr/bin:$JAVA_HOME/bin:$HOME/bin:$HOME/.gem/ruby/2.7.0/bin"
export GO111MODULE=on

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cx\ck peco_kill
end
set -U FZF_LEGACY_KEYBINDINGS 0
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
set LANG en_US.UTF8

set VBOX_USB usbfs
set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
