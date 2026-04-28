#!/bin/bash
# install.sh - Instalador Automatizado de Ambiente Arch Linux (Emerson)
# Execute este script no diretório raiz do pendrive (dentro da pasta dotfiles)
# Script de Instalação tolerante a pequenas falhas (remoção do set -e)
echo "================================================="
echo "   Iniciando a instalação do ambiente - Emerson"
echo "================================================="

echo "ATENÇÃO: Será pedida sua senha de SUDO para algumas operações."

# 1. Atualizar base e instalar pacotes do repositório oficial
if [ -f "pkglist-repo.txt" ]; then
    echo "-> [1/4] Instalando pacotes do repositório oficial (pacman)..."
    sudo pacman -Syu --needed --noconfirm - < pkglist-repo.txt
else
    echo "Aviso: Arquivo pkglist-repo.txt não encontrado."
fi

# 2. Instalar Helper do AUR (yay) se necessário
if ! command -v yay >/dev/null 2>&1; then
    echo "-> [2/4] Preparando dependências do AUR (yay)..."
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay-install
    cd /tmp/yay-install
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay-install
else
    echo "-> [2/4] yay detectado no sistema."
fi

# 3. Instalar pacotes do AUR
if [ -f "pkglist-aur.txt" ]; then
    echo "-> [3/4] Instalando pacotes AUR..."
    yay -S --needed --noconfirm - < pkglist-aur.txt
else
    echo "Aviso: Arquivo pkglist-aur.txt não encontrado."
fi

# 4. Restaurar arquivos e permissões
echo "-> [4/4] Restaurando suas configurações e atalhos..."

# Garantir existência das pastas destino
mkdir -p ~/.config
mkdir -p ~/scripts
mkdir -p ~/.local/bin

# Copiar dotfiles e shell
if [ -d ".config" ]; then cp -a .config/* ~/.config/; fi
if [ -d "scripts" ]; then cp -a scripts/* ~/scripts/; fi
if [ -d ".local/bin" ]; then cp -a .local/bin/* ~/.local/bin/; fi

[ -f ".bashrc" ] && cp .bashrc ~/.bashrc
[ -f ".tmux.conf" ] && cp .tmux.conf ~/.tmux.conf

# Ajustar permissões e execução de scripts (garantia contra perda de metadados no pendrive)
echo "Ajustando permissões executáveis de bash (.sh)..."
find ~/.local/bin -name "*.sh" -exec chmod +x {} + 2>/dev/null || true
find ~/scripts -name "*.sh" -exec chmod +x {} + 2>/dev/null || true
find ~/.config/hypr/scripts -name "*.sh" -exec chmod +x {} + 2>/dev/null || true
find ~/.config/waybar -name "*.sh" -exec chmod +x {} + 2>/dev/null || true

# Configurar SDDM (Login Screen) e Autologin
echo "Restaurando configurações do SDDM e habilitando serviço..."
if [ -d "etc_backup/sddm.conf.d" ]; then
    sudo mkdir -p /etc/sddm.conf.d/
    sudo cp -a etc_backup/sddm.conf.d/* /etc/sddm.conf.d/
fi
sudo systemctl enable sddm

# Configurar o Fish como shell padrão
if command -v fish >/dev/null 2>&1; then
    echo "Definindo o Fish como shell padrão..."
    chsh -s $(which fish)
fi

echo "================================================="
echo " Instalação finalizada com sucesso!              "
echo " Reinicie a máquina e o Hyprland deverá carregar "
echo " com todo o seu ambiente habitual."
echo "================================================="
