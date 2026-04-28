#!/bin/bash
# install_tools.sh - Instalador de Ferramentas, Linguagens e Dotfiles (Emerson)

echo "=========================================================="
echo "   Instalando Ferramentas, Linguagens e Configurações"
echo "=========================================================="

echo "Poderá ser solicitada a sua senha (SUDO)..."

# 1. Instalar as ferramentas essenciais, dependências e linguagens
echo "-> [1/4] Instalando ferramentas, Go, Python e Node.js..."
sudo pacman -S --needed --noconfirm \
    neovim \
    starship \
    yazi \
    kitty \
    waybar \
    ttf-jetbrains-mono-nerd \
    ttf-firacode-nerd \
    ripgrep \
    fd \
    wl-clipboard \
    unzip \
    go \
    python \
    python-pip \
    nodejs \
    npm

# 2. Restaurar as pastas de configuração das ferramentas
echo "-> [2/4] Copiando as dotfiles (Fish, Kitty, Waybar, Yazi, Starship)..."
mkdir -p ~/.config

# Copiar os diretórios existentes no backup para a sua Home
[ -d ".config/fish" ] && cp -r .config/fish ~/.config/
[ -d ".config/kitty" ] && cp -r .config/kitty ~/.config/
[ -d ".config/waybar" ] && cp -r .config/waybar ~/.config/
[ -d ".config/yazi" ] && cp -r .config/yazi ~/.config/
[ -d ".config/quickshell" ] && cp -r .config/quickshell ~/.config/
[ -f ".config/starship.toml" ] && cp .config/starship.toml ~/.config/
[ -f ".tmux.conf" ] && cp .tmux.conf ~/

# 3. Instalar o seu Neovim Puro (Sakura-vim)
echo "-> [3/4] Clonando o seu Neovim customizado (Sakura-vim)..."
# Se já existir uma pasta do nvim (por testes anteriores), fazemos backup
if [ -d "$HOME/.config/nvim" ]; then
    echo "Fazendo backup da configuração antiga do nvim para ~/.config/nvim.bak..."
    mv ~/.config/nvim ~/.config/nvim.bak
fi
# Clona o seu repositório exatamente onde o Neovim procura
git clone https://github.com/Emerson-Vitor/Sakura-vim.git ~/.config/nvim

# 4. Ajustar permissões finais
echo "-> [4/4] Ajustando permissões de scripts..."
find ~/.config/waybar/scripts -name "*.sh" -exec chmod +x {} + 2>/dev/null || true

echo "=========================================================="
echo " Concluído com sucesso!"
echo " "
echo " O seu ambiente com o Sakura-vim, Go, Python e Node.js"
echo " está pronto. Ao abrir o 'nvim' pela primeira vez, aguarde"
echo " uns segundos para ele baixar os plugins da sua configuração."
echo "=========================================================="
