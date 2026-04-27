#!/bin/bash

# Script rápido para captura de tela com seleção no Wayland
# Usa grim + slurp que é muito mais rápido que flameshot

# Criar diretório de screenshots se não existir
mkdir -p ~/Pictures/Screenshots

# Capturar área selecionada e salvar
FILENAME=~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png
slurp | grim -g - "$FILENAME"

# Copiar para área de transferência
wl-copy < "$FILENAME"

# Notificar sucesso
notify-send "Screenshot" "Captura salva e copiada para área de transferência!"