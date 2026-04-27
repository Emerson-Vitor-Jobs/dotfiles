package main

import (
	// "encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"unicode"
)

type ModuleConfig struct {
	Type string `json:"type"`
}

type Config struct {
	Modules map[string]ModuleConfig `json:"modules"`
}

// func loadConfig() Config {
// 	data, err := os.ReadFile("qsev.json")
// 	if err != nil {
// 		fmt.Println(" qsev.json não encontrado. Usando configuração padrão.")
// 		return Config{Modules: make(map[string]ModuleConfig)}
// 	}
// 	var cfg Config
// 	json.Unmarshal(data, &cfg)
// 	return cfg
// }

func healEmptyFiles() {
	filepath.Walk("src", func(path string, info os.FileInfo, err error) error {
		if err != nil || info.IsDir() || !strings.HasSuffix(path, ".qml") {
			return nil
		}

		if info.Size() <= 30 {
			fmt.Printf(" Curando e adicionando pragma: %s\n", path)

			content := "import QtQuick\n\nItem {\n    id: root\n}\n"

			if strings.Contains(path, "singletons") || strings.Contains(path, "theme") {
				content = "pragma Singleton\nimport QtQuick\n\nQtObject {\n    // QSEV Auto-generated Singleton\n}\n"
			}

			os.WriteFile(path, []byte(content), 0644)
		}
		return nil
	})
}

func main() {
	arg := "sync"
	if len(os.Args) > 1 {
		arg = os.Args[1]
	}

	switch arg {
	case "sync":
		runSync()
	case "add":
		if len(os.Args) < 4 {
			fmt.Println(" Uso: qsev add <categoria> <nome>")
			return
		}
		runAdd(os.Args[2], os.Args[3])
	default:
		fmt.Printf(" Comando desconhecido: %s\n", arg)
	}
}

func runSync() {
	fmt.Println(" Iniciando Sincronização QSEV...")

	healEmptyFiles()

	generateAllQmldir()

	fmt.Println(" Projeto sincronizado com sucesso!")
}

func generateAllQmldir() {
	entries, _ := os.ReadDir("src")

	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}

		moduleName := entry.Name()
		modulePath := filepath.Join("src", moduleName)
		qmldirPath := filepath.Join(modulePath, "qmldir")

		var lines []string
		lines = append(lines, fmt.Sprintf("module src.%s", moduleName))

		isSingleton := moduleName == "singletons" || moduleName == "theme" || moduleName == "utils"

		filepath.Walk(modulePath, func(path string, info os.FileInfo, err error) error {
			if err != nil || info.IsDir() || !strings.HasSuffix(path, ".qml") {
				return nil
			}

			relPath, _ := filepath.Rel(modulePath, path)
			compName := strings.TrimSuffix(info.Name(), ".qml")

			prefix := ""
			if isSingleton {
				prefix = "singleton "
			}

			lines = append(lines, fmt.Sprintf("%s%s 1.0 %s", prefix, compName, relPath))
			return nil
		})

		os.WriteFile(qmldirPath, []byte(strings.Join(lines, "\n")+"\n"), 0644)
		fmt.Printf(" Gerado: %s\n", qmldirPath)
	}
}

func runAdd(category, name string) {
	runes := []rune(name)
	runes[0] = unicode.ToUpper(runes[0])
	compName := string(runes)

	path := filepath.Join("src", category, name)
	os.MkdirAll(path, 0755)

	filePath := filepath.Join(path, compName+".qml")
	content := fmt.Sprintf("import QtQuick\n\nItem {\n    id: root\n    // Novo componente %s\n}\n", compName)

	os.WriteFile(filePath, []byte(content), 0644)
	fmt.Printf(" Módulo criado: %s\n", filePath)

	runSync()
}
