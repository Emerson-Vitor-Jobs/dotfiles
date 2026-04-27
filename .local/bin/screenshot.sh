#!/bin/bash

# Script de screenshot com wofi (ícones lado a lado)
chosen=$(echo -e "✂️\n🖥️\n🪟" | wofi --dmenu --prompt "Screenshot" --width 200 --height 50)

case "$chosen" in
"✂️")
  grim -g "$(slurp)" - | wl-copy
  notify-send "Screenshot" "Captura copiada!"
  ;;
"🖥️")
  grim - | wl-copy
  notify-send "Screenshot" "Captura copiada!"
  ;;
"🪟")
  geometry=$(hyprctl -j clients | jq -r '.[] | select(.focusHistoryID == 1) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
  grim -g "$geometry" - | wl-copy
  notify-send "Screenshot" "Captura copiada!"
  ;;
esac
