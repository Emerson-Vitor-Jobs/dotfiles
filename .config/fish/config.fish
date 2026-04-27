# Fish Shell Configuration
# Baseado no guia: https://ruihao-li.github.io/blog/fish-shell-customization/

# --- [INÍCIO DO BLOCO NOVO] ---
# Auto-start do Tmux (apenas se for interativo e não estiver dentro do tmux/vscode)
if status is-interactive
    and not set -q TMUX
    and not set -q VSCODE_INJECTION
    # O 'exec' faz o tmux substituir o processo do fish inicial, economizando RAM
    exec tmux new-session -A -s main
end
# --- [FIM DO BLOCO NOVO] ---

# =============================================================================
# CONFIGURAÇÕES BÁSICAS
# =============================================================================

# Definir editor padrão
set -gx EDITOR nvim
set -gx VISUAL nvim

# =============================================================================
# ALIASES ÚTEIS
# ============================================================================

# cursor cli
alias cursor-agent='/home/emerson/.local/bin/cursor-agent'

# Aliases básicos
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Aliases para Git
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git checkout main'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'
alias glog='git log --oneline --graph --decorate --all'

# Aliases para desenvolvimento
alias py='python'
alias py3='python3'
alias pip='pip3'
alias venv='python -m venv'
alias activate='source venv/bin/activate.fish'

# Aliases para Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'

# Aliases para Node.js
alias ni='npm install'
alias nid='npm install --save-dev'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'

# Aliases para sistema
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='htop'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Alias para controle de ventoinha
alias fan='/home/emerson/fan_control_simple.sh'

# Aliases para arquivos
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# =============================================================================
# FUNÇÕES PERSONALIZADAS
# =============================================================================

# Função para criar diretório e navegar para ele
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Função para extrair arquivos
function extract
    if test -f $argv[1]
        switch $argv[1]
            case *.tar.bz2
                tar xjf $argv[1]
            case *.tar.gz
                tar xzf $argv[1]
            case *.bz2
                bunzip2 $argv[1]
            case *.rar
                unrar e $argv[1]
            case *.gz
                gunzip $argv[1]
            case *.tar
                tar xf $argv[1]
            case *.tbz2
                tar xjf $argv[1]
            case *.tgz
                tar xzf $argv[1]
            case *.zip
                unzip $argv[1]
            case *.Z
                uncompress $argv[1]
            case *.7z
                7z x $argv[1]
            case *
                echo "'$argv[1]' não pode ser extraído via extract()"
        end
    else
        echo "'$argv[1]' não é um arquivo válido"
    end
end

# Função para encontrar arquivos
function ff
    find . -type f -name "*$argv[1]*"
end

# Função para encontrar diretórios
function fd
    find . -type d -name "*$argv[1]*"
end

# Função para criar um novo projeto Python
function newpy
    mkdir -p $argv[1]
    cd $argv[1]
    python -m venv venv
    source venv/bin/activate
    touch main.py requirements.txt README.md
    echo "# $argv[1]" >README.md
end

# Função para criar um novo projeto Node.js
function newnode
    mkdir -p $argv[1]
    cd $argv[1]
    npm init -y
    mkdir src
    touch src/index.js README.md
    echo "# $argv[1]" >README.md
end

# Função para limpar arquivos temporários
function cleanup
    echo "Limpando arquivos temporários..."
    find . -type f -name "*.pyc" -delete
    find . -type d -name __pycache__ -exec rm -rf {} +
    find . -type f -name "*.log" -delete
    find . -type f -name ".DS_Store" -delete
    echo "Limpeza concluída!"
end

# =============================================================================
# CONFIGURAÇÕES DE HISTÓRICO
# =============================================================================

# Configurações do histórico do Fish
set -g fish_history_size 10000
set -g fish_history_file ~/.config/fish/fish_history

# =============================================================================
# CONFIGURAÇÕES DE PATH
# =============================================================================

# Adicionar diretórios ao PATH se necessário
# set -gx PATH $PATH ~/.local/bin
# set -gx PATH $PATH ~/.cargo/bin
#
function log_to_buffer --on-event fish_preexec
    set -l timestamp (date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [FISH] $argv" >>/tmp/pc_shell_stream.log
end
# =============================================================================
# MENSAGEM DE BOAS-VINDAS
# =============================================================================
function qsf
    # Define a variável de ambiente apenas para esta sessão
    set -x QML_IMPORT_PATH $HOME/.config/quickshell
    
    # Chama o script bash de monitoramento
    bash $HOME/.config/quickshell/qs-launch

end

function qs-logs
    # Conecta ao log em tempo real
    socat - UNIX-CONNECT:/tmp/quickshell.sock
end
function fish_greeting
    echo "🐟 Bem-vindo ao Fish Shell!"
   
end
set -gx PATH $PATH /home/emerson/go/bin
set -gx QML_IMPORT_PATH /usr/lib/qt6/qml
# Define o editor padrão (necessário para o Yazi)
set -gx EDITOR nvim

# Força o uso do portal (importante para navegadores)
set -gx GTK_USE_PORTAL 1

# Define seu desktop (ex: Hyprland, Sway, GNOME, etc)
set -gx XDG_CURRENT_DESKTOP Hyprland 

# Starship (Isso define seu prompt atual)
starship init fish | source

export PATH="$HOME/.local/bin:$PATH"
