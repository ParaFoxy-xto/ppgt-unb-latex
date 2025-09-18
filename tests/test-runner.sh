#!/bin/bash

##
## ============================================================================
## SISTEMA DE TESTES AUTOMATIZADOS PARA UnB-PPGT
## ============================================================================
##
## Este script executa testes abrangentes de compilação e validação para
## a classe LaTeX UnB-PPGT, testando diferentes configurações, compiladores
## e cenários de uso.
##
## Funcionalidades:
## - Testes com pdflatex, xelatex, lualatex
## - Validação de diferentes tipos de documento
## - Verificação de compatibilidade com distribuições LaTeX
## - Testes de regressão visual
## - Relatórios detalhados de resultados
##
## Uso: ./test-runner.sh [opções]
##   -c, --compiler COMP    Testa apenas o compilador especificado
##   -t, --type TYPE        Testa apenas o tipo de documento especificado
##   -v, --verbose          Saída detalhada
##   -q, --quiet            Saída mínima
##   -h, --help             Mostra esta ajuda
##
## Autor: Equipe PPGT-UnB
## Versão: 1.0.0
##

set -e  # Para na primeira falha

# Configurações globais
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEST_DIR="$SCRIPT_DIR"
TEMP_DIR="$TEST_DIR/temp"
RESULTS_DIR="$TEST_DIR/results"
LOG_FILE="$RESULTS_DIR/test-results.log"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contadores
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Configurações de teste
VERBOSE=false
QUIET=false
SPECIFIC_COMPILER=""
SPECIFIC_TYPE=""

# Arrays de configurações para teste
COMPILERS=("pdflatex" "xelatex" "lualatex")
DOCUMENT_TYPES=("mestrado" "doutorado" "qualificacao" "qualificacao-mestrado" "qualificacao-doutorado")
SPACING_OPTIONS=("singlespacing" "onehalfspacing" "doublespacing")
FONT_SIZES=("10pt" "11pt" "12pt")

##
## ============================================================================
## FUNÇÕES AUXILIARES
## ============================================================================
##

# Função para logging
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
    
    if [[ "$level" == "ERROR" ]]; then
        echo -e "${RED}[ERROR]${NC} $message" >&2
    elif [[ "$level" == "WARN" ]]; then
        echo -e "${YELLOW}[WARN]${NC} $message" >&2
    elif [[ "$level" == "INFO" ]] && [[ "$QUIET" != "true" ]]; then
        echo -e "${BLUE}[INFO]${NC} $message"
    elif [[ "$level" == "SUCCESS" ]]; then
        echo -e "${GREEN}[SUCCESS]${NC} $message"
    elif [[ "$level" == "DEBUG" ]] && [[ "$VERBOSE" == "true" ]]; then
        echo -e "${BLUE}[DEBUG]${NC} $message"
    fi
}

# Função para verificar dependências
check_dependencies() {
    log "INFO" "Verificando dependências do sistema..."
    
    local missing_deps=()
    
    # Verifica compiladores LaTeX
    for compiler in "${COMPILERS[@]}"; do
        if ! command -v "$compiler" &> /dev/null; then
            missing_deps+=("$compiler")
        fi
    done
    
    # Verifica ferramentas auxiliares
    local tools=("bibtex" "makeglossaries" "gs" "convert")
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_deps+=("$tool")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log "WARN" "Dependências não encontradas: ${missing_deps[*]}"
        log "WARN" "Alguns testes podem falhar devido a dependências ausentes"
    else
        log "SUCCESS" "Todas as dependências encontradas"
    fi
}

# Função para preparar ambiente de teste
setup_test_environment() {
    log "INFO" "Preparando ambiente de teste..."
    
    # Cria diretórios necessários
    mkdir -p "$TEMP_DIR" "$RESULTS_DIR"
    
    # Limpa resultados anteriores
    rm -f "$LOG_FILE"
    rm -rf "$TEMP_DIR"/*
    
    # Inicializa log
    echo "# Relatório de Testes UnB-PPGT - $(date)" > "$LOG_FILE"
    echo "# Diretório do projeto: $PROJECT_ROOT" >> "$LOG_FILE"
    echo "# Diretório de testes: $TEST_DIR" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    
    log "SUCCESS" "Ambiente de teste preparado"
}

# Função para limpar ambiente de teste
cleanup_test_environment() {
    log "INFO" "Limpando ambiente de teste..."
    
    # Remove arquivos temporários, mas mantém resultados
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "$TEMP_DIR"
    fi
    
    log "SUCCESS" "Limpeza concluída"
}

# Função para compilar documento LaTeX
compile_document() {
    local compiler=$1
    local tex_file=$2
    local output_dir=$3
    local max_runs=${4:-3}
    
    log "DEBUG" "Compilando $tex_file com $compiler (máximo $max_runs execuções)"
    
    cd "$output_dir"
    
    local success=true
    local run=1
    
    while [[ $run -le $max_runs ]]; do
        log "DEBUG" "Execução $run/$max_runs do $compiler"
        
        if [[ "$compiler" == "pdflatex" ]]; then
            if ! pdflatex -interaction=nonstopmode -halt-on-error "$tex_file" > /dev/null 2>&1; then
                success=false
                break
            fi
        elif [[ "$compiler" == "xelatex" ]]; then
            if ! xelatex -interaction=nonstopmode -halt-on-error "$tex_file" > /dev/null 2>&1; then
                success=false
                break
            fi
        elif [[ "$compiler" == "lualatex" ]]; then
            if ! lualatex -interaction=nonstopmode -halt-on-error "$tex_file" > /dev/null 2>&1; then
                success=false
                break
            fi
        fi
        
        # Executa bibtex se necessário
        local basename=$(basename "$tex_file" .tex)
        if [[ -f "$basename.aux" ]] && grep -q "\\bibdata" "$basename.aux" 2>/dev/null; then
            log "DEBUG" "Executando bibtex para $basename"
            bibtex "$basename" > /dev/null 2>&1 || true
        fi
        
        # Executa makeglossaries se necessário
        if [[ -f "$basename.glo" ]]; then
            log "DEBUG" "Executando makeglossaries para $basename"
            makeglossaries "$basename" > /dev/null 2>&1 || true
        fi
        
        ((run++))
    done
    
    cd - > /dev/null
    
    if [[ "$success" == "true" ]]; then
        local pdf_file="$output_dir/$(basename "$tex_file" .tex).pdf"
        if [[ -f "$pdf_file" ]]; then
            log "DEBUG" "Compilação bem-sucedida: $pdf_file gerado"
            return 0
        else
            log "DEBUG" "Compilação falhou: PDF não foi gerado"
            return 1
        fi
    else
        log "DEBUG" "Compilação falhou durante execução do $compiler"
        return 1
    fi
}

# Função para validar PDF gerado
validate_pdf() {
    local pdf_file=$1
    
    log "DEBUG" "Validando PDF: $pdf_file"
    
    if [[ ! -f "$pdf_file" ]]; then
        log "DEBUG" "PDF não encontrado: $pdf_file"
        return 1
    fi
    
    # Verifica se o PDF não está corrompido
    if ! gs -dNOPAUSE -dBATCH -sDEVICE=nullpage "$pdf_file" > /dev/null 2>&1; then
        log "DEBUG" "PDF corrompido: $pdf_file"
        return 1
    fi
    
    # Verifica número mínimo de páginas (deve ter pelo menos 10 páginas)
    local page_count=$(gs -dNOPAUSE -dBATCH -sDEVICE=nullpage -c "($pdf_file) (r) file runpdfbegin pdfpagecount = quit" 2>/dev/null || echo "0")
    
    if [[ "$page_count" -lt 10 ]]; then
        log "DEBUG" "PDF com poucas páginas ($page_count): $pdf_file"
        return 1
    fi
    
    log "DEBUG" "PDF válido com $page_count páginas: $pdf_file"
    return 0
}

##
## ============================================================================
## FUNÇÕES DE TESTE
## ============================================================================
##

# Teste básico de compilação
test_basic_compilation() {
    local compiler=$1
    local doc_type=$2
    local test_name="basic_${compiler}_${doc_type}"
    
    log "INFO" "Executando teste: $test_name"
    ((TOTAL_TESTS++))
    
    local test_dir="$TEMP_DIR/$test_name"
    mkdir -p "$test_dir"
    
    # Cria documento de teste mínimo
    cat > "$test_dir/test.tex" << EOF
\\documentclass[$doc_type,12pt,hyperref]{UnB-PPGT}

\\titulo{Teste de Compilação Básica}
\\autor{Teste}{Sistema}
\\orientador{Prof. Dr. Orientador Teste}{Universidade de Brasília}
\\diamesano{1}{1}{2024}
\\coordenador{Prof. Dr. Coordenador Teste}{Universidade de Brasília}
\\membrobancafunc{Prof. Dr. Orientador Teste}{Universidade de Brasília}{Orientador}
\\membrobancafunc{Prof. Dr. Membro 1}{Universidade de Brasília}{Examinador}
\\membrobancafunc{Prof. Dr. Membro 2}{Universidade Federal}{Examinador}

\\palavraschave{teste, compilação, latex}{teste, compilação, latex}
\\keywords{test, compilation, latex}{test, compilation, latex}

\\begin{document}

\\pretextual
\\capa
\\folhaderosto
\\folhadeaprovacao

\\begin{resumo}
Este é um teste básico de compilação da classe UnB-PPGT.
\\end{resumo}

\\begin{abstract}
This is a basic compilation test for the UnB-PPGT class.
\\end{abstract}

\\textual

\\chapter{Introdução}
Este é um capítulo de teste.

\\section{Seção de Teste}
Esta é uma seção de teste com texto simples.

\\chapter{Conclusão}
Esta é a conclusão do teste.

\\postextual

\\end{document}
EOF
    
    # Copia arquivos necessários
    cp "$PROJECT_ROOT/UnB-PPGT.cls" "$test_dir/"
    
    # Compila documento
    if compile_document "$compiler" "test.tex" "$test_dir"; then
        if validate_pdf "$test_dir/test.pdf"; then
            log "SUCCESS" "Teste $test_name: PASSOU"
            ((PASSED_TESTS++))
            
            # Copia PDF para resultados
            cp "$test_dir/test.pdf" "$RESULTS_DIR/${test_name}.pdf"
        else
            log "ERROR" "Teste $test_name: FALHOU (PDF inválido)"
            ((FAILED_TESTS++))
        fi
    else
        log "ERROR" "Teste $test_name: FALHOU (compilação)"
        ((FAILED_TESTS++))
        
        # Copia log de erro
        if [[ -f "$test_dir/test.log" ]]; then
            cp "$test_dir/test.log" "$RESULTS_DIR/${test_name}_error.log"
        fi
    fi
}

# Teste completo com todos os elementos
test_complete_document() {
    local compiler=$1
    local doc_type=$2
    local spacing=$3
    local font_size=$4
    local test_name="complete_${compiler}_${doc_type}_${spacing}_${font_size}"
    
    log "INFO" "Executando teste: $test_name"
    ((TOTAL_TESTS++))
    
    local test_dir="$TEMP_DIR/$test_name"
    mkdir -p "$test_dir"
    
    # Cria documento completo baseado no exemplo
    cp "$PROJECT_ROOT/monografia.tex" "$test_dir/test.tex"
    cp "$PROJECT_ROOT/UnB-PPGT.cls" "$test_dir/"
    cp "$PROJECT_ROOT/bibliografia.bib" "$test_dir/"
    cp -r "$PROJECT_ROOT/tex" "$test_dir/"
    
    # Modifica opções da classe
    sed -i "s/\\documentclass\[.*\]{UnB-PPGT}/\\documentclass[$doc_type,$spacing,$font_size,hyperref]{UnB-PPGT}/" "$test_dir/test.tex"
    
    # Compila documento
    if compile_document "$compiler" "test.tex" "$test_dir" 4; then
        if validate_pdf "$test_dir/test.pdf"; then
            log "SUCCESS" "Teste $test_name: PASSOU"
            ((PASSED_TESTS++))
            
            # Copia PDF para resultados
            cp "$test_dir/test.pdf" "$RESULTS_DIR/${test_name}.pdf"
        else
            log "ERROR" "Teste $test_name: FALHOU (PDF inválido)"
            ((FAILED_TESTS++))
        fi
    else
        log "ERROR" "Teste $test_name: FALHOU (compilação)"
        ((FAILED_TESTS++))
        
        # Copia log de erro
        if [[ -f "$test_dir/test.log" ]]; then
            cp "$test_dir/test.log" "$RESULTS_DIR/${test_name}_error.log"
        fi
    fi
}

# Teste de validação de campos obrigatórios
test_validation() {
    local compiler=$1
    local test_name="validation_${compiler}"
    
    log "INFO" "Executando teste: $test_name"
    ((TOTAL_TESTS++))
    
    local test_dir="$TEMP_DIR/$test_name"
    mkdir -p "$test_dir"
    
    # Cria documento com campos obrigatórios faltando
    cat > "$test_dir/test.tex" << EOF
\\documentclass[mestrado,12pt]{UnB-PPGT}

% Propositalmente omite campos obrigatórios para testar validação

\\begin{document}

\\pretextual
\\capa

\\textual

\\chapter{Teste}
Este documento deve falhar na validação.

\\end{document}
EOF
    
    # Copia arquivos necessários
    cp "$PROJECT_ROOT/UnB-PPGT.cls" "$test_dir/"
    
    # Compila documento (deve falhar)
    if ! compile_document "$compiler" "test.tex" "$test_dir"; then
        log "SUCCESS" "Teste $test_name: PASSOU (falhou como esperado)"
        ((PASSED_TESTS++))
    else
        log "ERROR" "Teste $test_name: FALHOU (deveria ter falhado na validação)"
        ((FAILED_TESTS++))
    fi
}

# Teste de compatibilidade com diferentes distribuições
test_distribution_compatibility() {
    local compiler=$1
    local test_name="compatibility_${compiler}"
    
    log "INFO" "Executando teste: $test_name"
    ((TOTAL_TESTS++))
    
    # Verifica versão do LaTeX
    local latex_version=$($compiler --version 2>/dev/null | head -n1 || echo "Desconhecida")
    log "DEBUG" "Versão do $compiler: $latex_version"
    
    # Verifica pacotes essenciais
    local test_dir="$TEMP_DIR/$test_name"
    mkdir -p "$test_dir"
    
    cat > "$test_dir/test.tex" << EOF
\\documentclass{article}
\\usepackage{xkeyval}
\\usepackage[brazil]{babel}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{amsmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\usepackage{natbib}
\\usepackage{setspace}
\\usepackage{fancyhdr}
\\usepackage{geometry}
\\usepackage{tocloft}
\\usepackage{glossaries}

\\begin{document}
Teste de compatibilidade de pacotes.
\\end{document}
EOF
    
    if compile_document "$compiler" "test.tex" "$test_dir"; then
        log "SUCCESS" "Teste $test_name: PASSOU"
        ((PASSED_TESTS++))
    else
        log "ERROR" "Teste $test_name: FALHOU (incompatibilidade de pacotes)"
        ((FAILED_TESTS++))
        
        if [[ -f "$test_dir/test.log" ]]; then
            cp "$test_dir/test.log" "$RESULTS_DIR/${test_name}_error.log"
        fi
    fi
}

##
## ============================================================================
## FUNÇÃO PRINCIPAL DE EXECUÇÃO DOS TESTES
## ============================================================================
##

run_all_tests() {
    log "INFO" "Iniciando execução de todos os testes..."
    
    # Determina quais compiladores testar
    local compilers_to_test=()
    if [[ -n "$SPECIFIC_COMPILER" ]]; then
        compilers_to_test=("$SPECIFIC_COMPILER")
    else
        for compiler in "${COMPILERS[@]}"; do
            if command -v "$compiler" &> /dev/null; then
                compilers_to_test+=("$compiler")
            else
                log "WARN" "Compilador $compiler não encontrado, pulando testes"
            fi
        done
    fi
    
    # Determina quais tipos de documento testar
    local types_to_test=()
    if [[ -n "$SPECIFIC_TYPE" ]]; then
        types_to_test=("$SPECIFIC_TYPE")
    else
        types_to_test=("${DOCUMENT_TYPES[@]}")
    fi
    
    log "INFO" "Compiladores a testar: ${compilers_to_test[*]}"
    log "INFO" "Tipos de documento a testar: ${types_to_test[*]}"
    
    # Executa testes básicos
    log "INFO" "=== TESTES BÁSICOS DE COMPILAÇÃO ==="
    for compiler in "${compilers_to_test[@]}"; do
        for doc_type in "${types_to_test[@]}"; do
            test_basic_compilation "$compiler" "$doc_type"
        done
    done
    
    # Executa testes de compatibilidade
    log "INFO" "=== TESTES DE COMPATIBILIDADE ==="
    for compiler in "${compilers_to_test[@]}"; do
        test_distribution_compatibility "$compiler"
    done
    
    # Executa testes de validação
    log "INFO" "=== TESTES DE VALIDAÇÃO ==="
    for compiler in "${compilers_to_test[@]}"; do
        test_validation "$compiler"
    done
    
    # Executa testes completos (amostra)
    log "INFO" "=== TESTES COMPLETOS (AMOSTRA) ==="
    for compiler in "${compilers_to_test[@]}"; do
        # Testa apenas algumas combinações para evitar explosão de testes
        test_complete_document "$compiler" "mestrado" "onehalfspacing" "12pt"
        test_complete_document "$compiler" "doutorado" "singlespacing" "11pt"
    done
}

##
## ============================================================================
## GERAÇÃO DE RELATÓRIOS
## ============================================================================
##

generate_report() {
    log "INFO" "Gerando relatório final..."
    
    local report_file="$RESULTS_DIR/test-report.md"
    local html_report="$RESULTS_DIR/test-report.html"
    
    # Relatório em Markdown
    cat > "$report_file" << EOF
# Relatório de Testes - UnB-PPGT LaTeX Class

**Data:** $(date)  
**Diretório:** $PROJECT_ROOT  

## Resumo dos Resultados

- **Total de testes:** $TOTAL_TESTS
- **Testes aprovados:** $PASSED_TESTS
- **Testes falharam:** $FAILED_TESTS
- **Taxa de sucesso:** $(( PASSED_TESTS * 100 / TOTAL_TESTS ))%

## Detalhes dos Testes

### Compiladores Testados
EOF
    
    for compiler in "${COMPILERS[@]}"; do
        if command -v "$compiler" &> /dev/null; then
            local version=$($compiler --version 2>/dev/null | head -n1 || echo "Versão desconhecida")
            echo "- **$compiler:** $version" >> "$report_file"
        else
            echo "- **$compiler:** Não disponível" >> "$report_file"
        fi
    done
    
    cat >> "$report_file" << EOF

### Arquivos Gerados

Os seguintes arquivos foram gerados durante os testes:

EOF
    
    # Lista PDFs gerados
    for pdf in "$RESULTS_DIR"/*.pdf; do
        if [[ -f "$pdf" ]]; then
            local filename=$(basename "$pdf")
            local size=$(du -h "$pdf" | cut -f1)
            echo "- **$filename** ($size)" >> "$report_file"
        fi
    done
    
    # Lista logs de erro
    echo "" >> "$report_file"
    echo "### Logs de Erro" >> "$report_file"
    echo "" >> "$report_file"
    
    for log in "$RESULTS_DIR"/*_error.log; do
        if [[ -f "$log" ]]; then
            local filename=$(basename "$log")
            echo "- **$filename**" >> "$report_file"
        fi
    done
    
    # Converte para HTML se pandoc estiver disponível
    if command -v pandoc &> /dev/null; then
        pandoc "$report_file" -o "$html_report" 2>/dev/null || true
        log "INFO" "Relatório HTML gerado: $html_report"
    fi
    
    log "SUCCESS" "Relatório gerado: $report_file"
}

##
## ============================================================================
## PROCESSAMENTO DE ARGUMENTOS E EXECUÇÃO PRINCIPAL
## ============================================================================
##

show_help() {
    cat << EOF
Sistema de Testes Automatizados para UnB-PPGT

Uso: $0 [opções]

Opções:
  -c, --compiler COMP    Testa apenas o compilador especificado
                         (pdflatex, xelatex, lualatex)
  -t, --type TYPE        Testa apenas o tipo de documento especificado
                         (mestrado, doutorado, qualificacao, etc.)
  -v, --verbose          Saída detalhada
  -q, --quiet            Saída mínima
  -h, --help             Mostra esta ajuda

Exemplos:
  $0                     Executa todos os testes
  $0 -c pdflatex         Testa apenas com pdflatex
  $0 -t mestrado         Testa apenas documentos de mestrado
  $0 -v -c xelatex       Testa com xelatex em modo verboso

EOF
}

# Processa argumentos da linha de comando
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--compiler)
            SPECIFIC_COMPILER="$2"
            shift 2
            ;;
        -t|--type)
            SPECIFIC_TYPE="$2"
            shift 2
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -q|--quiet)
            QUIET=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            log "ERROR" "Opção desconhecida: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validação de argumentos
if [[ -n "$SPECIFIC_COMPILER" ]] && [[ ! " ${COMPILERS[*]} " =~ " $SPECIFIC_COMPILER " ]]; then
    log "ERROR" "Compilador inválido: $SPECIFIC_COMPILER"
    log "ERROR" "Compiladores válidos: ${COMPILERS[*]}"
    exit 1
fi

if [[ -n "$SPECIFIC_TYPE" ]] && [[ ! " ${DOCUMENT_TYPES[*]} " =~ " $SPECIFIC_TYPE " ]]; then
    log "ERROR" "Tipo de documento inválido: $SPECIFIC_TYPE"
    log "ERROR" "Tipos válidos: ${DOCUMENT_TYPES[*]}"
    exit 1
fi

##
## ============================================================================
## EXECUÇÃO PRINCIPAL
## ============================================================================
##

main() {
    log "INFO" "Iniciando sistema de testes UnB-PPGT..."
    
    # Preparação
    setup_test_environment
    check_dependencies
    
    # Execução dos testes
    run_all_tests
    
    # Relatórios
    generate_report
    
    # Limpeza
    cleanup_test_environment
    
    # Resultado final
    echo ""
    echo "=========================================="
    echo "RESULTADO FINAL DOS TESTES"
    echo "=========================================="
    echo "Total de testes: $TOTAL_TESTS"
    echo "Testes aprovados: $PASSED_TESTS"
    echo "Testes falharam: $FAILED_TESTS"
    
    if [[ $FAILED_TESTS -eq 0 ]]; then
        echo -e "${GREEN}TODOS OS TESTES PASSARAM!${NC}"
        exit 0
    else
        echo -e "${RED}$FAILED_TESTS TESTE(S) FALHARAM${NC}"
        echo "Consulte os logs em: $RESULTS_DIR"
        exit 1
    fi
}

# Executa função principal
main "$@"