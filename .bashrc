#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/go/bin
export PATH=$PATH:/home/emerson/go/bin
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export QML_IMPORT_PATH=/usr/lib/qt6/qml

