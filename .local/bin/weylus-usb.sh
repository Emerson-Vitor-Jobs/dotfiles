#!/bin/bash

# 1. Garante que o monitor VIRTUAL-1 exista
# Verifica se ele já está rodando para não criar duplicado
if ! hyprctl monitors | grep -q "VIRTUAL-1"; then
  echo "🖥️  Criando monitor VIRTUAL-1..."
  hyprctl output create headless VIRTUAL-1
else
  echo "✅ Monitor VIRTUAL-1 já está ativo."
fi

# 2. Configura a conexão USB (ADB)
echo "📱 Aguardando tablet via USB..."
adb wait-for-device
adb reverse tcp:1701 tcp:1701
adb reverse tcp:9001 tcp:9001
echo "🔗 Portas redirecionadas (Cabo USB)"

# 3. Inicia o Weylus
# Dica: O Weylus no Wayland vai abrir um popup pedindo qual tela compartilhar.
# Selecione o "VIRTUAL-1" nessa hora.
echo "🚀 Iniciando Weylus..."
weylus
