#!/bin/bash

opcoes=$(echo -e "vim |  Abrir Neovim no terminal\nfirefox |  Abrir navegador\nlock |  Bloquear a tela\nfiles |  Abrir gerenciador de arquivos" | rofi -dmenu -p "Comando")
escolha=$(echo "$opcoes" | awk -F '|' '{print $1}' | tr -d '[:space:]')

case $escolha in
vim)
  kitty nvim
  ;;
firefox)
  firefox
  ;;
lock)
  swaylock
  ;;
files)
  thunar
  ;;
esac
