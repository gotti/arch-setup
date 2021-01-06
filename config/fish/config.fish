#eval (hub alias -s)
alias b popd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
export FZF_DEFAULT_OPTS="--ansi --extended --cycle"
alias top=htop
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias se='grep $1 -rl $2'
bind \cd delete-char
alias vi=nvim
alias vim=nvim
export GOPATH=$HOME/.go/vendor
export JAVA_HOME="/opt/java/jdk-11.0.2"
export PATH="$PATH:$HOME/.go/go/bin:$GOPATH/bin:$HOME/.cargo/bin:/opt/intelFPGA/20.1/quartus/bin/:/usr/bin:$JAVA_HOME/bin:$HOME/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/.local/bin"
export GO111MODULE=on
export VISUAL=nvim
export EDITOR=nvim

export DOCKER_HOST=unix:///run/user/1000/docker.sock
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cx\ck peco_kill
end
set -U FZF_LEGACY_KEYBINDINGS 0
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
set LANG en_US.UTF8

set VBOX_USB usbfs
set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
#export DOCKER_HOST=unix:///run/user/1000/docker.sock
