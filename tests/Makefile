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

# ============================================================================
# TARGETS PRINCIPAIS
# ============================================================================

.PHONY: all basic complete validation compatibility clean clean-all report help

# Target padrão - executa todos os testes
all: setup basic complete validation compatibility report
	@$(call log_success,Todos os testes concluídos)

# Testes básicos de compilação
basic: setup
	@$(call log,Iniciando testes básicos de compilação)
	@$(MAKE) -s basic-tests
	@$(call log_success,Testes básicos concluídos)

# Testes completos
complete: setup
	@$(call log,Iniciando testes completos)
	@$(MAKE) -s complete-tests
	@$(call log_success,Testes completos concluídos)

# Testes de validação
validation: setup
	@$(call log,Iniciando testes de validação)
	@$(MAKE) -s validation-tests
	@$(call log_success,Testes de validação concluídos)

# Testes de compatibilidade
compatibility: setup
	@$(call log,Iniciando testes de compatibilidade)
	@$(MAKE) -s compatibility-tests
	@$(call log_success,Testes de compatibilidade concluídos)

# ============================================================================
# TARGETS DE CONFIGURAÇÃO
# ============================================================================

.PHONY: setup check-deps

# Prepara ambiente de teste
setup: check-deps
	@$(call log,Preparando ambiente de teste)
	@mkdir -p $(TEMP_DIR) $(RESULTS_DIR)
	@rm -rf $(TEMP_DIR)/*
	@echo "# Relatório de Testes UnB-PPGT - $(shell date)" > $(RESULTS_DIR)/test-log.txt
	@$(call log_success,Ambiente preparado)

# Verifica dependências
check-deps:
	@$(call log,Verificando dependências)
	@for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			$(call log_success,$$compiler encontrado); \
		else \
			$(call log_warn,$$compiler não encontrado); \
		fi; \
	done
	@for tool in bibtex makeglossaries; do \
		if command -v $$tool >/dev/null 2>&1; then \
			$(call log_success,$$tool encontrado); \
		else \
			$(call log_warn,$$tool não encontrado); \
		fi; \
	done

# ============================================================================
# TARGETS DE TESTE ESPECÍFICOS
# ============================================================================

.PHONY: basic-tests complete-tests validation-tests compatibility-tests

# Executa testes básicos
basic-tests:
	@for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			for doc_type in $(DOCUMENT_TYPES); do \
				$(MAKE) -s test-basic COMPILER=$$compiler TYPE=$$doc_type; \
			done; \
		fi; \
	done

# Executa testes completos
complete-tests:
	@for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			$(MAKE) -s test-complete COMPILER=$$compiler; \
		fi; \
	done

# Executa testes de validação
validation-tests:
	@for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			$(MAKE) -s test-validation COMPILER=$$compiler; \
		fi; \
	done

# Executa testes de compatibilidade
compatibility-tests:
	@for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			$(MAKE) -s test-compatibility COMPILER=$$compiler; \
		fi; \
	done

# ============================================================================
# TARGETS DE TESTE INDIVIDUAIS
# ============================================================================

.PHONY: test-basic test-complete test-validation test-compatibility

# Teste básico individual
test-basic:
	@$(call check_compiler,$(COMPILER))
	@test_name="basic_$(COMPILER)_$(TYPE)"; \
	test_dir="$(TEMP_DIR)/$$test_name"; \
	mkdir -p "$$test_dir"; \
	$(call log,Executando teste: $$test_name); \
	sed 's/\[mestrado,/[$(TYPE),/' $(CONFIG_DIR)/minimal-test.tex > "$$test_dir/test.tex"; \
	cp $(PROJECT_ROOT)/UnB-PPGT.cls "$$test_dir/"; \
	if $(call compile_latex,$(COMPILER),test.tex,$$test_dir); then \
		$(call validate_pdf,$$test_dir/test.pdf); \
		cp "$$test_dir/test.pdf" "$(RESULTS_DIR)/$$test_name.pdf"; \
		echo "PASS: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
	else \
		$(call log_error,Teste $$test_name falhou); \
		echo "FAIL: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
		if [ -f "$$test_dir/test.log" ]; then \
			cp "$$test_dir/test.log" "$(RESULTS_DIR)/$${test_name}_error.log"; \
		fi; \
		exit 1; \
	fi

# Teste completo individual
test-complete:
	@$(call check_compiler,$(COMPILER))
	@test_name="complete_$(COMPILER)"; \
	test_dir="$(TEMP_DIR)/$$test_name"; \
	mkdir -p "$$test_dir"; \
	$(call log,Executando teste: $$test_name); \
	cp $(CONFIG_DIR)/complete-test.tex "$$test_dir/test.tex"; \
	cp $(PROJECT_ROOT)/UnB-PPGT.cls "$$test_dir/"; \
	if $(call compile_latex,$(COMPILER),test.tex,$$test_dir); then \
		$(call validate_pdf,$$test_dir/test.pdf); \
		cp "$$test_dir/test.pdf" "$(RESULTS_DIR)/$$test_name.pdf"; \
		echo "PASS: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
	else \
		$(call log_error,Teste $$test_name falhou); \
		echo "FAIL: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
		if [ -f "$$test_dir/test.log" ]; then \
			cp "$$test_dir/test.log" "$(RESULTS_DIR)/$${test_name}_error.log"; \
		fi; \
		exit 1; \
	fi

# Teste de validação individual (deve falhar)
test-validation:
	@$(call check_compiler,$(COMPILER))
	@test_name="validation_$(COMPILER)"; \
	test_dir="$(TEMP_DIR)/$$test_name"; \
	mkdir -p "$$test_dir"; \
	$(call log,Executando teste: $$test_name); \
	cp $(CONFIG_DIR)/validation-test.tex "$$test_dir/test.tex"; \
	cp $(PROJECT_ROOT)/UnB-PPGT.cls "$$test_dir/"; \
	if $(call compile_latex,$(COMPILER),test.tex,$$test_dir); then \
		$(call log_error,Teste $$test_name deveria ter falhado); \
		echo "FAIL: $$test_name (should have failed)" >> $(RESULTS_DIR)/test-log.txt; \
		exit 1; \
	else \
		$(call log_success,Teste $$test_name falhou como esperado); \
		echo "PASS: $$test_name (failed as expected)" >> $(RESULTS_DIR)/test-log.txt; \
	fi

# Teste de compatibilidade individual
test-compatibility:
	@$(call check_compiler,$(COMPILER))
	@test_name="compatibility_$(COMPILER)"; \
	test_dir="$(TEMP_DIR)/$$test_name"; \
	mkdir -p "$$test_dir"; \
	$(call log,Executando teste: $$test_name); \
	echo "\\documentclass{article}" > "$$test_dir/test.tex"; \
	echo "\\usepackage{xkeyval,babel,inputenc,fontenc,amsmath,graphicx,hyperref,natbib,setspace,fancyhdr,geometry,tocloft,glossaries}" >> "$$test_dir/test.tex"; \
	echo "\\begin{document}Teste de compatibilidade\\end{document}" >> "$$test_dir/test.tex"; \
	if $(call compile_latex,$(COMPILER),test.tex,$$test_dir); then \
		$(call log_success,Teste $$test_name passou); \
		echo "PASS: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
	else \
		$(call log_error,Teste $$test_name falhou); \
		echo "FAIL: $$test_name" >> $(RESULTS_DIR)/test-log.txt; \
		if [ -f "$$test_dir/test.log" ]; then \
			cp "$$test_dir/test.log" "$(RESULTS_DIR)/$${test_name}_error.log"; \
		fi; \
		exit 1; \
	fi

# ============================================================================
# TARGETS ESPECIAIS
# ============================================================================

.PHONY: test-specific test-doutorado test-qualificacao

# Testa configuração específica
test-specific:
	@if [ -z "$(CONFIG)" ]; then \
		$(call log_error,Especifique CONFIG=nome-do-arquivo); \
		exit 1; \
	fi
	@$(call check_compiler,$(COMPILER))
	@test_name="specific_$(COMPILER)_$(CONFIG)"; \
	test_dir="$(TEMP_DIR)/$$test_name"; \
	mkdir -p "$$test_dir"; \
	$(call log,Executando teste específico: $$test_name); \
	cp $(CONFIG_DIR)/$(CONFIG).tex "$$test_dir/test.tex"; \
	cp $(PROJECT_ROOT)/UnB-PPGT.cls "$$test_dir/"; \
	if $(call compile_latex,$(COMPILER),test.tex,$$test_dir); then \
		$(call validate_pdf,$$test_dir/test.pdf); \
		cp "$$test_dir/test.pdf" "$(RESULTS_DIR)/$$test_name.pdf"; \
		$(call log_success,Teste $$test_name passou); \
	else \
		$(call log_error,Teste $$test_name falhou); \
		exit 1; \
	fi

# Testa documento de doutorado
test-doutorado:
	@$(MAKE) -s test-specific CONFIG=doutorado-test COMPILER=$(COMPILER)

# Testa documento de qualificação
test-qualificacao:
	@$(MAKE) -s test-specific CONFIG=qualificacao-test COMPILER=$(COMPILER)

# ============================================================================
# RELATÓRIOS E LIMPEZA
# ============================================================================

.PHONY: report clean clean-all

# Gera relatório de testes
report:
	@$(call log,Gerando relatório de testes)
	@report_file="$(RESULTS_DIR)/test-report.md"; \
	echo "# Relatório de Testes - UnB-PPGT LaTeX Class" > "$$report_file"; \
	echo "" >> "$$report_file"; \
	echo "**Data:** $(shell date)" >> "$$report_file"; \
	echo "**Diretório:** $(PROJECT_ROOT)" >> "$$report_file"; \
	echo "" >> "$$report_file"; \
	echo "## Resumo dos Resultados" >> "$$report_file"; \
	echo "" >> "$$report_file"; \
	total=$$(grep -c ":" $(RESULTS_DIR)/test-log.txt 2>/dev/null || echo "0"); \
	passed=$$(grep -c "PASS:" $(RESULTS_DIR)/test-log.txt 2>/dev/null || echo "0"); \
	failed=$$(grep -c "FAIL:" $(RESULTS_DIR)/test-log.txt 2>/dev/null || echo "0"); \
	echo "- **Total de testes:** $$total" >> "$$report_file"; \
	echo "- **Testes aprovados:** $$passed" >> "$$report_file"; \
	echo "- **Testes falharam:** $$failed" >> "$$report_file"; \
	if [ $$total -gt 0 ]; then \
		success_rate=$$((passed * 100 / total)); \
		echo "- **Taxa de sucesso:** $$success_rate%" >> "$$report_file"; \
	fi; \
	echo "" >> "$$report_file"; \
	echo "## Compiladores Testados" >> "$$report_file"; \
	echo "" >> "$$report_file"; \
	for compiler in $(COMPILERS); do \
		if command -v $$compiler >/dev/null 2>&1; then \
			version=$$($$compiler --version 2>/dev/null | head -n1 || echo "Versão desconhecida"); \
			echo "- **$$compiler:** $$version" >> "$$report_file"; \
		else \
			echo "- **$$compiler:** Não disponível" >> "$$report_file"; \
		fi; \
	done; \
	echo "" >> "$$report_file"; \
	echo "## Arquivos Gerados" >> "$$report_file"; \
	echo "" >> "$$report_file"; \
	for pdf in $(RESULTS_DIR)/*.pdf; do \
		if [ -f "$$pdf" ]; then \
			filename=$$(basename "$$pdf"); \
			size=$$(du -h "$$pdf" | cut -f1); \
			echo "- **$$filename** ($$size)" >> "$$report_file"; \
		fi; \
	done; \
	$(call log_success,Relatório gerado: $$report_file)

# Limpa arquivos temporários
clean:
	@$(call log,Limpando arquivos temporários)
	@rm -rf $(TEMP_DIR)
	@$(call log_success,Limpeza concluída)

# Limpa todos os arquivos gerados
clean-all: clean
	@$(call log,Limpando todos os arquivos gerados)
	@rm -rf $(RESULTS_DIR)
	@$(call log_success,Limpeza completa concluída)

# ============================================================================
# AJUDA
# ============================================================================

.PHONY: help

# Mostra ajuda
help:
	@echo "Makefile para Testes Automatizados da Classe UnB-PPGT"
	@echo ""
	@echo "Targets principais:"
	@echo "  all          - Executa todos os testes"
	@echo "  basic        - Testes básicos de compilação"
	@echo "  complete     - Testes completos com todos os elementos"
	@echo "  validation   - Testes de validação de erros"
	@echo "  compatibility - Testes de compatibilidade"
	@echo "  report       - Gera relatório de testes"
	@echo "  clean        - Limpa arquivos temporários"
	@echo "  clean-all    - Limpa todos os arquivos gerados"
	@echo "  help         - Mostra esta ajuda"
	@echo ""
	@echo "Targets especiais:"
	@echo "  test-doutorado    - Testa documento de doutorado"
	@echo "  test-qualificacao - Testa documento de qualificação"
	@echo "  test-specific     - Testa configuração específica (requer CONFIG=nome)"
	@echo ""
	@echo "Variáveis:"
	@echo "  COMPILER     - Compilador a usar ($(COMPILERS))"
	@echo "  TYPE         - Tipo de documento ($(DOCUMENT_TYPES))"
	@echo "  CONFIG       - Arquivo de configuração específico"
	@echo ""
	@echo "Exemplos:"
	@echo "  make all                    # Executa todos os testes"
	@echo "  make basic COMPILER=xelatex # Testes básicos com XeLaTeX"
	@echo "  make test-doutorado         # Testa documento de doutorado"
	@echo "  make test-specific CONFIG=minimal-test  # Testa configuração específica"
	@echo ""

# ============================================================================
# CONFIGURAÇÕES AVANÇADAS
# ============================================================================

# Previne execução paralela problemática
.NOTPARALLEL:

# Mantém arquivos intermediários para debug
.PRECIOUS: $(TEMP_DIR)/%.tex $(TEMP_DIR)/%.pdf

# Configurações específicas por sistema operacional
ifeq ($(OS),Windows_NT)
    # Configurações para Windows
    RM := del /Q
    MKDIR := mkdir
else
    # Configurações para Unix/Linux/macOS
    RM := rm -f
    MKDIR := mkdir -p
endif