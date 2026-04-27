#!/bin/bash

TARGET_DIR="src/singletons"
FIX_ALL=false
if [[ "$1" == "--fix" ]]; then
    FIX_ALL=true
fi

echo -e " Verificando pragma Singleton em $TARGET_DIR...${NC}"

find "$TARGET_DIR" -name "*.qml" | while read -r file; do
    if ! head -n 1 "$file" | grep -q "pragma Singleton"; then
        echo -e " Erro:${NC} $file está sem o pragma obrigatório."
        
        if [ "$FIX_ALL" = true ]; then
            sed -i '1i pragma Singleton' "$file"
            echo -e "  ↳ Corrigido!${NC}"
        fi
    else
        echo -e " OK:${NC} $file"
    fi
done

if [ "$FIX_ALL" = false ]; then
    echo -e "\nDica:${NC} Rode './check_pragmas.sh --fix' para corrigir todos automaticamente."
fi

