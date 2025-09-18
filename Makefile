# Makefile para compilação do modelo LaTeX PPGT-UnB
# Uso: make [target]
# Targets disponíveis: all, pdf, clean, distclean, help

# Configurações
MAIN = monografia
LATEX = pdflatex
BIBTEX = bibtex
VIEWER = evince

# Arquivos
TEX_FILES = $(wildcard tex/*.tex)
BIB_FILES = bibliografia.bib
CLS_FILES = UnB-PPGT.cls
IMG_FILES = $(wildcard img/*)

# Arquivos auxiliares gerados
AUX_FILES = *.aux *.log *.bbl *.blg *.toc *.lof *.lot *.out *.nav *.snm *.vrb
AUX_FILES += *.fls *.fdb_latexmk *.synctex.gz *.run.xml *.bcf
AUX_FILES += *.acn *.glo *.ist *.glsdefs

# Target padrão
.PHONY: all
all: pdf

# Compilação completa
.PHONY: pdf
pdf: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex $(TEX_FILES) $(BIB_FILES) $(CLS_FILES) $(IMG_FILES)
	@echo "=== Compilando documento LaTeX ==="
	@echo "Primeira passada..."
	$(LATEX) $(MAIN).tex
	@echo "Processando bibliografia..."
	$(BIBTEX) $(MAIN)
	@echo "Segunda passada..."
	$(LATEX) $(MAIN).tex
	@echo "Terceira passada..."
	$(LATEX) $(MAIN).tex
	@echo "=== Compilação concluída ==="
	@echo "Arquivo gerado: $(MAIN).pdf"

# Compilação rápida (sem bibliografia)
.PHONY: quick
quick: $(MAIN).tex $(TEX_FILES) $(CLS_FILES)
	@echo "=== Compilação rápida ==="
	$(LATEX) $(MAIN).tex
	@echo "=== Compilação rápida concluída ==="

# Visualizar PDF
.PHONY: view
view: $(MAIN).pdf
	@echo "Abrindo $(MAIN).pdf..."
	$(VIEWER) $(MAIN).pdf &

# Limpeza de arquivos auxiliares
.PHONY: clean
clean:
	@echo "Removendo arquivos auxiliares..."
	rm -f $(AUX_FILES)
	@echo "Limpeza concluída."

# Limpeza completa (incluindo PDF)
.PHONY: distclean
distclean: clean
	@echo "Removendo PDF..."
	rm -f $(MAIN).pdf
	@echo "Limpeza completa concluída."

# Verificar dependências
.PHONY: check
check:
	@echo "=== Verificando dependências ==="
	@which $(LATEX) > /dev/null || (echo "ERRO: $(LATEX) não encontrado" && exit 1)
	@which $(BIBTEX) > /dev/null || (echo "ERRO: $(BIBTEX) não encontrado" && exit 1)
	@echo "Dependências OK."

# Contar palavras (aproximado)
.PHONY: wordcount
wordcount: $(TEX_FILES)
	@echo "=== Contagem de palavras (aproximada) ==="
	@detex $(TEX_FILES) | wc -w
	@echo "Nota: Esta é uma estimativa. Para contagem precisa, use ferramentas específicas."

# Estatísticas do documento
.PHONY: stats
stats: $(MAIN).pdf
	@echo "=== Estatísticas do documento ==="
	@echo "Páginas: $$(pdfinfo $(MAIN).pdf | grep Pages | awk '{print $$2}')"
	@echo "Tamanho: $$(du -h $(MAIN).pdf | cut -f1)"
	@echo "Arquivos TeX: $$(echo $(TEX_FILES) | wc -w)"
	@echo "Imagens: $$(echo $(IMG_FILES) | wc -w)"

# Backup do projeto
.PHONY: backup
backup:
	@echo "=== Criando backup ==="
	@DATE=$$(date +%Y%m%d_%H%M%S); \
	tar -czf backup_$$DATE.tar.gz \
		$(MAIN).tex $(TEX_FILES) $(BIB_FILES) $(CLS_FILES) $(IMG_FILES) \
		README.md Makefile; \
	echo "Backup criado: backup_$$DATE.tar.gz"

# Validar arquivos BibTeX
.PHONY: bibcheck
bibcheck: $(BIB_FILES)
	@echo "=== Validando bibliografia ==="
	@for bib in $(BIB_FILES); do \
		echo "Verificando $$bib..."; \
		$(BIBTEX) --min-crossrefs=1000 $$bib || true; \
	done

# Instalar dependências (Ubuntu/Debian)
.PHONY: install-deps
install-deps:
	@echo "=== Instalando dependências LaTeX (Ubuntu/Debian) ==="
	sudo apt-get update
	sudo apt-get install -y texlive-full biber
	@echo "Dependências instaladas."

# Instalar dependências (macOS com Homebrew)
.PHONY: install-deps-mac
install-deps-mac:
	@echo "=== Instalando dependências LaTeX (macOS) ==="
	brew install --cask mactex
	@echo "Dependências instaladas. Reinicie o terminal."

# Modo de desenvolvimento (compilação automática)
.PHONY: watch
watch:
	@echo "=== Modo de desenvolvimento ativo ==="
	@echo "Pressione Ctrl+C para parar"
	@while true; do \
		inotifywait -e modify $(MAIN).tex $(TEX_FILES) $(BIB_FILES) 2>/dev/null && \
		make quick; \
	done

# Ajuda
.PHONY: help
help:
	@echo "Makefile para modelo LaTeX PPGT-UnB"
	@echo ""
	@echo "Targets disponíveis:"
	@echo "  all         - Compilação completa (padrão)"
	@echo "  pdf         - Compilação completa com bibliografia"
	@echo "  quick       - Compilação rápida (sem bibliografia)"
	@echo "  view        - Visualizar PDF gerado"
	@echo "  clean       - Remover arquivos auxiliares"
	@echo "  distclean   - Remover arquivos auxiliares e PDF"
	@echo "  check       - Verificar dependências"
	@echo "  wordcount   - Contar palavras (aproximado)"
	@echo "  stats       - Estatísticas do documento"
	@echo "  backup      - Criar backup do projeto"
	@echo "  bibcheck    - Validar arquivos BibTeX"
	@echo "  watch       - Modo de desenvolvimento (requer inotify-tools)"
	@echo "  help        - Mostrar esta ajuda"
	@echo ""
	@echo "Instalação de dependências:"
	@echo "  install-deps     - Ubuntu/Debian"
	@echo "  install-deps-mac - macOS com Homebrew"
	@echo ""
	@echo "Exemplos:"
	@echo "  make              # Compilação completa"
	@echo "  make quick        # Compilação rápida"
	@echo "  make clean pdf    # Limpar e compilar"
	@echo "  make view         # Compilar e visualizar"

# Evitar conflitos com arquivos de mesmo nome
.PHONY: all pdf quick view clean distclean check wordcount stats backup bibcheck help install-deps install-deps-mac watch