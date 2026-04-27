BIN_NAME=qsev
CLI_SRC=cli/qs-mod/main.go
INSTALL_DIR=/usr/local/bin

BLUE=\033[0;34m
NC=\033[0m 

.PHONY: all build sync install run clean widget singleton

all: build sync

build:
	@echo "$(BLUE)🔨 Compilando QSEV CLI em $(CLI_SRC)...$(NC)"
	@go build -o $(BIN_NAME) $(CLI_SRC)

sync: build
	@echo "$(BLUE)🔄 Sincronizando módulos e qmldirs...$(NC)"
	@./$(BIN_NAME) sync

widget: build
	@./$(BIN_NAME) add widgets $(name)

singleton: build
	@./$(BIN_NAME) add singletons $(name)

run: sync
	@echo "$(BLUE)🚀 Iniciando Quickshell...$(NC)"
	@./qs-launch

install: build
	@echo "$(BLUE)📦 Instalando $(BIN_NAME) em $(INSTALL_DIR)...$(NC)"
	@sudo cp $(BIN_NAME) $(INSTALL_DIR)/$(BIN_NAME)

clean:
	@rm -f $(BIN_NAME)
	@find src -name "qmldir" -type f -delete
	@echo "🧹 Artefatos removidos."

check:
	@chmod +x check_pragmas.sh
	@./cli/qs-mod/check_pragmas.sh

fix-pragmas:
	@./cli/qs-mod/check_pragmas.sh --fix

kill:
	@echo "$(BLUE)💀 Encerrando instâncias do Quickshell...$(NC)"
	@pkill -f quickshell || echo "⚠️ Nenhum processo do Quickshell encontrado."

