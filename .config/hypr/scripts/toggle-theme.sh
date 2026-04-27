#!/usr/bin/env bash

# --- ARQUIVO DE ESTADO ---
# Este arquivo guarda o tema atual ("light" or "dark")
STATE_FILE="$HOME/.config/hypr/theme.state"

# --- TEMAS (PREENCHA ISSO!) ---

# Configurações do Tema LIGHT (BlulocoLight)
LIGHT_GTK_THEME="Tokyonight-Light"        # Nome exato do tema GTK
LIGHT_ICON_THEME="oomox-Tokyonight-Light" # Nome do tema de ícones
LIGHT_CURSOR_THEME="Oxygen Blue"          # Nome do tema de cursor
LIGHT_KITTY_CONF="Bluloco Light"
LIGHT_WAYBAR_CSS="style-light.css"                            # Nome do arquivo CSS do Waybar (dentro de ~/.config/waybar/)
LIGHT_HYPR_CONF="$HOME/.config/hypr/themes/blulocoLight.conf" # Caminho para o .conf do tema do Hyprland
LIGHT_NVIM_THEME="bluloco-light"                              # Nome do colorscheme no Neovim
LIGHT_WALLPAPER="$HOME/Documentos/Backgrounds/pixel_sakura.gif"

# Configurações do Tema DARK (Tokyonight)
DARK_GTK_THEME="Tokyonight-Dark"
DARK_ICON_THEME="oomox-Tokyonight-Dark"
DARK_CURSOR_THEME="Bibata-Modern-Classic"
DARK_WAYBAR_CSS="style-dark.css"
DARK_KITTY_CONF="Tokyo Night Storm"
DARK_NVIM_THEME="tokyonight"
DARK_WALLPAPER="$HOME/Documentos/Backgrounds/pixel_sakura_night_pixel.gif"

# --- ARQUIVOS DE CONFIGURAÇÃO (NÃO MUDE ISSO) ---
# O script vai gerenciar esses links simbólicos/arquivos
KITTY_THEME_SYMLINK="$HOME/.config/kitty/current-theme.conf"
WAYBAR_THEME_SYMLINK="$HOME/.config/waybar/style.css"
HYPR_THEME_SYMLINK="$HOME/.config/hypr/current-theme.conf"

# Arquivo do Neovim que define o tema (veja o Passo 2)
NVIM_THEME_FILE="$HOME/.config/nvim/lua/core/colorscheme.lua"
# Defina o tamanho (ex: 11) que você preferir
FONT_NAME="BigBlueTermPlus Nerd Font Mono 11"
MONO_FONT_NAME="BigBlueTermPlus Nerd Font Mono 11"

# Fonte padrão da interface
gsettings set org.gnome.desktop.interface font-name "$FONT_NAME"
# Fonte para documentos (opcional, pode ser uma fonte diferente)
gsettings set org.gnome.desktop.interface document-font-name "$FONT_NAME"
# Fonte monoespaçada (importante para apps de código)
gsettings set org.gnome.desktop.interface monospace-font-name "$MONO_FONT_NAME"
# --- LÓGICA DO SCRIPT ---

# Lê o estado atual (padrão é light se o arquivo não existir)
CURRENT_THEME="light"
if [ -f "$STATE_FILE" ]; then
  CURRENT_THEME=$(cat "$STATE_FILE")
fi

if [ "$CURRENT_THEME" == "light" ]; then
  # --- MUDANDO PARA DARK ---
  echo "Mudando para o tema DARK (Tokyonight)..."

  # 1. GTK / Gsettings
  gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"
  gsettings set org.gnome.desktop.interface icon-theme "$DARK_ICON_THEME"
  gsettings set org.gnome.desktop.interface cursor-theme "$DARK_CURSOR_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  # 2. Hyprland (via symlink)
  ln -sf "$DARK_HYPR_CONF" "$HYPR_THEME_SYMLINK"
  hyprctl reload

  # 3. Kitty (via symlink)
  command kitty +kitten themes --reload-in=all "$DARK_KITTY_CONF"

  # 4. Waybar (via symlink)
  ln -sf "$DARK_WAYBAR_CSS" "$WAYBAR_THEME_SYMLINK"
  killall -SIGUSR2 waybar # Recarrega o Waybar

  # 5. Neovim (via sed)
  # Substitui a linha do colorscheme no arquivo de configuração
  sed -i "s/vim.cmd.colorscheme \".*\"/vim.cmd.colorscheme \"$DARK_NVIM_THEME\"/" "$NVIM_THEME_FILE"

  # 6. Wallpaper
  swww img "$DARK_WALLPAPER" --transition-type random --transition-fps 60

  # 7. Atualiza o estado
  echo "dark" >"$STATE_FILE"

else
  # --- MUDANDO PARA LIGHT ---
  echo "Mudando para o tema LIGHT (BlulocoLight)..."

  # 1. GTK / Gsettings
  gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"
  gsettings set org.gnome.desktop.interface icon-theme "$LIGHT_ICON_THEME"
  gsettings set org.gnome.desktop.interface cursor-theme "$LIGHT_CURSOR_THEME"
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

  # 2. Hyprland
  ln -sf "$LIGHT_HYPR_CONF" "$HYPR_THEME_SYMLINK"
  hyprctl reload

  # 3. Kitty
  command kitty +kitten themes --reload-in=all "$LIGHT_KITTY_CONF"

  # 4. Waybar
  ln -sf "$LIGHT_WAYBAR_CSS" "$WAYBAR_THEME_SYMLINK"
  killall -SIGUSR2 waybar

  # 5. Neovim
  sed -i "s/vim.cmd.colorscheme \".*\"/vim.cmd.colorscheme \"$LIGHT_NVIM_THEME\"/" "$NVIM_THEME_FILE"

  # 6. Wallpaper
  swww img "$LIGHT_WALLPAPER" --transition-type random --transition-fps 60

  # 7. Atualiza o estado
  echo "light" >"$STATE_FILE"
fi

echo "Troca de tema concluída."
