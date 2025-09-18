# ============================================================================
# MAKEFILE PARA TESTES AUTOMATIZADOS DA CLASSE UnB-PPGT
# ============================================================================
#
# Este Makefile automatiza a execução de testes de compilação e validação
# para a classe LaTeX UnB-PPGT, fornecendo targets específicos para
# diferentes tipos de teste e configurações.
#
# Targets principais:
#   all          - Executa todos os testes
#   basic        - Testes básicos de compilação
#   complete     - Testes completos com todos os elementos
#   validation   - Testes de validação de erros
#   compatibility - Testes de compatibilidade
#   clean        - Limpa arquivos temporários
#   clean-all    - Limpa todos os arquivos gerados
#   report       - Gera relatório de testes
#
# Uso:
#   make all              # Executa todos os testes
#   make basic            # Apenas testes básicos
#   make COMPILER=xelatex # Testa apenas com XeLaTeX
#   make TYPE=doutorado   # Testa apenas documentos de doutorado
#
# Autor: Equipe PPGT-UnB
# Versão: 1.0.0
#

# Configurações padrão
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

# Diretórios
PROJECT_ROOT := ..
TEST_DIR := .
TEMP_DIR := $(TEST_DIR)/temp
RESULTS_DIR := $(TEST_DIR)/results
CONFIG_DIR := $(TEST_DIR)/test-configs

# Compiladores LaTeX disponíveis
COMPILERS := pdflatex xelatex lualatex
COMPILER ?= pdflatex

# Tipos de documento
DOCUMENT_TYPES := mestrado doutorado qualificacao qualificacao-mestrado qualificacao-doutorado
TYPE ?= mestrado

# Configurações de teste
SPACING_OPTIONS := singlespacing onehalfspacing doublespacing
FONT_SIZES := 10pt 11pt 12pt

# Arquivos de configuração de teste
TEST_CONFIGS := minimal-test complete-test validation-test doutorado-test qualificacao-test

# Cores para output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Função para logging
define log
	@echo -e "$(BLUE)[$(shell date '+%H:%M:%S')]$(NC) $(1)"
endef

define log_success
	@echo -e "$(GREEN)[SUCCESS]$(NC) $(1)"
endef

define log_error
	@echo -e "$(RED)[ERROR]$(NC) $(1)"
endef

define log_warn
	@echo -e "$(YELLOW)[WARN]$(NC) $(1)"
endef

# Verifica se um compilador está disponível
define check_compiler
	@if ! command -v $(1) >/dev/null 2>&1; then \
		$(call log_warn,Compilador $(1) não encontrado); \
		exit 1; \
	fi
endef

# Compila um documento LaTeX
define compile_latex
	@$(call log,Compilando $(2) com $(1))
	@cd $(3) && \
	for i in {1..3}; do \
		$(1) -interaction=nonstopmode -halt-on-error $(2) >/dev/null 2>&1 || exit 1; \
		if [ -f "$(basename $(2) .tex).aux" ] && grep -q "\\bibdata" "$(basename $(2) .tex).aux" 2>/dev/null; then \
			bibtex "$(basename $(2) .tex)" >/dev/null 2>&1 || true; \
		fi; \
		if [ -f "$(basename $(2) .tex).glo" ]; then \
			makeglossaries "$(basename $(2) .tex)" >/dev/null 2>&1 || true; \
		fi; \
	done
endef

# Valida PDF gerado
define validate_pdf
	@if [ ! -f "$(1)" ]; then \
		$(call log_error,PDF não encontrado: $(1)); \
		exit 1; \
	fi
	@if [ ! -s "$(1)" ]; then \
		$(call log_error,PDF vazio: $(1)); \
		exit 1; \
	fi
	@$(call log_success,PDF válido: $(1))
endef

# ================================================================