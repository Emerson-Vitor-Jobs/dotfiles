#!/bin/bash

# (Não precisamos mais do log, esta é a versão final)
WALLPAPER_DIR="$HOME/Imagens/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Erro: O diretório $WALLPAPER_DIR não foi encontrado."
  exit 1
fi

WOFI_OPTIONS="--dmenu --show-icons --allow-images --width 800 --height 600"

options=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) |
  while read -r file; do
    echo -e "$file\0icon\x1f$file"
  done)

# --- A CORREÇÃO ESTÁ AQUI ---
# 1. Capturamos a saída "suja" do wofi
selected_dirty_path=$(echo -e "$options" | wofi $WOFI_OPTIONS)

# 2. Se for vazia (pressionou Esc), saímos
if [ -z "$selected_dirty_path" ]; then
  exit 0
fi

# 3. "Limpamos" a saída:
#    Usamos 'sed' para remover a palavra 'icon' e tudo que vem depois dela.
selected_full_path=$(echo "$selected_dirty_path" | sed 's/icon.*//')
# -----------------------------

# Agora, $selected_full_path contém APENAS o caminho correto
swww img "$selected_full_path" \
  --transition-type "wipe" \
  --transition-duration 1 \
  --transition-fps 60
