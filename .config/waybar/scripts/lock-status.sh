#!/bin/bash

# Encontra os arquivos de brilho (status) dos LEDs
CAPS_FILE=$(find /sys/class/leds/ -name "*::capslock" -print -quit 2>/dev/null)/brightness
NUM_FILE=$(find /sys/class/leds/ -name "*::numlock" -print -quit 2>/dev/null)/brightness

COLOR_ON='#D2B48C'
COLOR_OFF='#8b8d9e'
CAPS_STATUS=$(cat "$CAPS_FILE" 2>/dev/null)
NUM_STATUS=$(cat "$NUM_FILE" 2>/dev/null)

if [ "$CAPS_STATUS" -eq 1 ]; then
  CAPS="<span color='$COLOR_ON'> CAP </span>"
else
  CAPS="<span color='$COLOR_OFF'> CAP </span>"
fi

if [ "$NUM_STATUS" -eq 1 ]; then
  NUM="<span color='$COLOR_ON'> NUM </span>"
else
  NUM="<span color='$COLOR_OFF'> NUM </span>"
fi

# Apenas imprime o resultado. O Waybar vai capturar este "echo".
echo "$CAPS $NUM"
