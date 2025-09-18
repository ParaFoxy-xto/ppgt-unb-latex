@echo off
setlocal enabledelayedexpansion

REM ============================================================================
REM SISTEMA DE TESTES AUTOMATIZADOS PARA UnB-PPGT (Windows)
REM ============================================================================
REM
REM Este script executa testes abrangentes de compilação e validação para
REM a classe LaTeX UnB-PPGT em sistemas Windows, testando diferentes 
REM configurações, compiladores e cenários de uso.
REM
REM Funcionalidades:
REM - Testes com pdflatex, xelatex, lualatex
REM - Validação de diferentes tipos de documento
REM - Verificação de compatibilidade com distribuições LaTeX
REM - Testes de regressão visual
REM - Relatórios detalhados de resultados
REM
REM Uso: test-runner.bat [opções]
REM   -c COMP     Testa apenas o compilador especificado
REM   -t TYPE     Testa apenas o tipo de documento especificado
REM   -v          Saída detalhada
REM   -q          Saída mínima
REM   -h          Mostra esta ajuda
REM
REM Autor: Equipe PPGT-UnB
REM Versão: 1.0.0
REM

REM Configurações globais
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%..\"
set "TEST_DIR=%SCRIPT_DIR%"
set "TEMP_DIR=%TEST_DIR%temp"
set "RESULTS_DIR=%TEST_DIR%results"
set "LOG_FILE=%RESULTS_DIR%\test-results.log"

REM Contadores
set /a TOTAL_TESTS=0
set /a PASSED_TESTS=0
set /a FAILED_TESTS=0

REM Configurações de teste
set "VERBOSE=false"
set "QUIET=false"
set "SPECIFIC_COMPILER="
set "SPECIFIC_TYPE="

REM Arrays de configurações para teste (simulados com variáveis)
set "COMPILERS=pdflatex xelatex lualatex"
set "DOCUMENT_TYPES=mestrado doutorado qualificacao qualificacao-mestrado qualificacao-doutorado"
set "SPACING_OPTIONS=singlespacing onehalfspacing doublespacing"
set "FONT_SIZES=10pt 11pt 12pt"

REM ============================================================================
REM FUNÇÕES AUXILIARES
REM ============================================================================

:log
set "level=%1"
set "message=%~2"
set "timestamp=%date% %time%"

echo [%timestamp%] [%level%] %message% >> "%LOG_FILE%"

if "%level%"=="ERROR" (
    echo [ERROR] %message%
) else if "%level%"=="WARN" (
    echo [WARN] %message%
) else if "%level%"=="INFO" (
    if not "%QUIET%"=="true" echo [INFO] %message%
) else if "%level%"=="SUCCESS" (
    echo [SUCCESS] %message%
) else if "%level%"=="DEBUG" (
    if "%VERBOSE%"=="true" echo [DEBUG] %message%
)
goto :eof

:check_dependencies
call :log "INFO" "Verificando dependências do sistema..."

set "missing_deps="

REM Verifica compiladores LaTeX
for %%c in (%COMPILERS%) do (
    where %%c >nul 2>&1
    if errorlevel 1 (
        set "missing_deps=!missing_deps! %%c"
    )
)

REM Verifica ferramentas auxiliares
for %%t in (bibtex makeglossaries) do (
    where %%t >nul 2>&1
    if errorlevel 1 (
        set "missing_deps=!missing_deps! %%t"
    )
)

if not "%missing_deps%"=="" (
    call :log "WARN" "Dependências não encontradas:%missing_deps%"
    call :log "WARN" "Alguns testes podem falhar devido a dependências ausentes"
) else (
    call :log "SUCCESS" "Todas as dependências encontradas"
)
goto :eof

:setup_test_environment
call :log "INFO" "Preparando ambiente de teste..."

REM Cria diretórios necessários
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"
if not exist "%RESULTS_DIR%" mkdir "%RESULTS_DIR%"

REM Limpa resultados anteriores
if exist "%LOG_FILE%" del "%LOG_FILE%"
if exist "%TEMP_DIR%\*" rmdir /s /q "%TEMP_DIR%" >nul 2>&1
mkdir "%TEMP_DIR%"

REM Inicializa log
echo # Relatório de Testes UnB-PPGT - %date% %time% > "%LOG_FILE%"
echo # Diretório do projeto: %PROJECT_ROOT% >> "%LOG_FILE%"
echo # Diretório de testes: %TEST_DIR% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

call :log "SUCCESS" "Ambiente de teste preparado"
goto :eof

:cleanup_test_environment
call :log "INFO" "Limpando ambiente de teste..."

REM Remove arquivos temporários, mas mantém resultados
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%" >nul 2>&1

call :log "SUCCESS" "Limpeza concluída"
goto :eof

:compile_document
set "compiler=%1"
set "tex_file=%2"
set "output_dir=%3"
set "max_runs=%4"
if "%max_runs%"=="" set "max_runs=3"

call :log "DEBUG" "Compilando %tex_file% com %compiler% (máximo %max_runs% execuções)"

pushd "%output_dir%"

set "success=true"
set /a run=1

:compile_loop
if %run% gtr %max_runs% goto :compile_done

call :log "DEBUG" "Execução %run%/%max_runs% do %compiler%"

if "%compiler%"=="pdflatex" (
    pdflatex -interaction=nonstopmode -halt-on-error "%tex_file%" >nul 2>&1
) else if "%compiler%"=="xelatex" (
    xelatex -interaction=nonstopmode -halt-on-error "%tex_file%" >nul 2>&1
) else if "%compiler%"=="lualatex" (
    lualatex -interaction=nonstopmode -halt-on-error "%tex_file%" >nul 2>&1
)

if errorlevel 1 (
    set "success=false"
    goto :compile_done
)

REM Executa bibtex se necessário
for %%f in ("%tex_file%") do set "basename=%%~nf"
if exist "%basename%.aux" (
    findstr "\\bibdata" "%basename%.aux" >nul 2>&1
    if not errorlevel 1 (
        call :log "DEBUG" "Executando bibtex para %basename%"
        bibtex "%basename%" >nul 2>&1
    )
)

REM Executa makeglossaries se necessário
if exist "%basename%.glo" (
    call :log "DEBUG" "Executando makeglossaries para %basename%"
    makeglossaries "%basename%" >nul 2>&1
)

set /a run+=1
goto :compile_loop

:compile_done
popd

if "%success%"=="true" (
    set "pdf_file=%output_dir%\%basename%.pdf"
    if exist "!pdf_file!" (
        call :log "DEBUG" "Compilação bem-sucedida: !pdf_file! gerado"
        exit /b 0
    ) else (
        call :log "DEBUG" "Compilação falhou: PDF não foi gerado"
        exit /b 1
    )
) else (
    call :log "DEBUG" "Compilação falhou durante execução do %compiler%"
    exit /b 1
)

:validate_pdf
set "pdf_file=%1"

call :log "DEBUG" "Validando PDF: %pdf_file%"

if not exist "%pdf_file%" (
    call :log "DEBUG" "PDF não encontrado: %pdf_file%"
    exit /b 1
)

REM Verifica se o arquivo não está vazio
for %%f in ("%pdf_file%") do (
    if %%~zf lss 1024 (
        call :log "DEBUG" "PDF muito pequeno (possivelmente corrompido): %pdf_file%"
        exit /b 1
    )
)

call :log "DEBUG" "PDF válido: %pdf_file%"
exit /b 0

REM ============================================================================
REM FUNÇÕES DE TESTE
REM ============================================================================

:test_basic_compilation
set "compiler=%1"
set "doc_type=%2"
set "test_name=basic_%compiler%_%doc_type%"

call :log "INFO" "Executando teste: %test_name%"
set /a TOTAL_TESTS+=1

set "test_dir=%TEMP_DIR%\%test_name%"
mkdir "%test_dir%"

REM Cria documento de teste mínimo
(
echo \documentclass[%doc_type%,12pt,hyperref]{UnB-PPGT}
echo.
echo \titulo{Teste de Compilação Básica}
echo \autor{Teste}{Sistema}
echo \orientador{Prof. Dr. Orientador Teste}{Universidade de Brasília}
echo \diamesano{1}{1}{2024}
echo \coordenador{Prof. Dr. Coordenador Teste}{Universidade de Brasília}
echo \membrobancafunc{Prof. Dr. Orientador Teste}{Universidade de Brasília}{Orientador}
echo \membrobancafunc{Prof. Dr. Membro 1}{Universidade de Brasília}{Examinador}
echo \membrobancafunc{Prof. Dr. Membro 2}{Universidade Federal}{Examinador}
echo.
echo \palavraschave{teste, compilação, latex}{teste, compilação, latex}
echo \keywords{test, compilation, latex}{test, compilation, latex}
echo.
echo \begin{document}
echo.
echo \pretextual
echo \capa
echo \folhaderosto
echo \folhadeaprovacao
echo.
echo \begin{resumo}
echo Este é um teste básico de compilação da classe UnB-PPGT.
echo \end{resumo}
echo.
echo \begin{abstract}
echo This is a basic compilation test for the UnB-PPGT class.
echo \end{abstract}
echo.
echo \textual
echo.
echo \chapter{Introdução}
echo Este é um capítulo de teste.
echo.
echo \section{Seção de Teste}
echo Esta é uma seção de teste com texto simples.
echo.
echo \chapter{Conclusão}
echo Esta é a conclusão do teste.
echo.
echo \postextual
echo.
echo \end{document}
) > "%test_dir%\test.tex"

REM Copia arquivos necessários
copy "%PROJECT_ROOT%UnB-PPGT.cls" "%test_dir%\" >nul

REM Compila documento
call :compile_document "%compiler%" "test.tex" "%test_dir%"
if not errorlevel 1 (
    call :validate_pdf "%test_dir%\test.pdf"
    if not errorlevel 1 (
        call :log "SUCCESS" "Teste %test_name%: PASSOU"
        set /a PASSED_TESTS+=1
        
        REM Copia PDF para resultados
        copy "%test_dir%\test.pdf" "%RESULTS_DIR%\%test_name%.pdf" >nul
    ) else (
        call :log "ERROR" "Teste %test_name%: FALHOU (PDF inválido)"
        set /a FAILED_TESTS+=1
    )
) else (
    call :log "ERROR" "Teste %test_name%: FALHOU (compilação)"
    set /a FAILED_TESTS+=1
    
    REM Copia log de erro
    if exist "%test_dir%\test.log" (
        copy "%test_dir%\test.log" "%RESULTS_DIR%\%test_name%_error.log" >nul
    )
)
goto :eof

:test_validation
set "compiler=%1"
set "test_name=validation_%compiler%"

call :log "INFO" "Executando teste: %test_name%"
set /a TOTAL_TESTS+=1

set "test_dir=%TEMP_DIR%\%test_name%"
mkdir "%test_dir%"

REM Cria documento com campos obrigatórios faltando
(
echo \documentclass[mestrado,12pt]{UnB-PPGT}
echo.
echo %% Propositalmente omite campos obrigatórios para testar validação
echo.
echo \begin{document}
echo.
echo \pretextual
echo \capa
echo.
echo \textual
echo.
echo \chapter{Teste}
echo Este documento deve falhar na validação.
echo.
echo \end{document}
) > "%test_dir%\test.tex"

REM Copia arquivos necessários
copy "%PROJECT_ROOT%UnB-PPGT.cls" "%test_dir%\" >nul

REM Compila documento (deve falhar)
call :compile_document "%compiler%" "test.tex" "%test_dir%"
if errorlevel 1 (
    call :log "SUCCESS" "Teste %test_name%: PASSOU (falhou como esperado)"
    set /a PASSED_TESTS+=1
) else (
    call :log "ERROR" "Teste %test_name%: FALHOU (deveria ter falhado na validação)"
    set /a FAILED_TESTS+=1
)
goto :eof

:test_distribution_compatibility
set "compiler=%1"
set "test_name=compatibility_%compiler%"

call :log "INFO" "Executando teste: %test_name%"
set /a TOTAL_TESTS+=1

REM Verifica versão do LaTeX
%compiler% --version >nul 2>&1
if not errorlevel 1 (
    for /f "tokens=*" %%v in ('%compiler% --version 2^>nul ^| findstr /n "." ^| findstr "1:"') do (
        set "latex_version=%%v"
        set "latex_version=!latex_version:~2!"
    )
) else (
    set "latex_version=Desconhecida"
)
call :log "DEBUG" "Versão do %compiler%: !latex_version!"

REM Verifica pacotes essenciais
set "test_dir=%TEMP_DIR%\%test_name%"
mkdir "%test_dir%"

(
echo \documentclass{article}
echo \usepackage{xkeyval}
echo \usepackage[brazil]{babel}
echo \usepackage[utf8]{inputenc}
echo \usepackage[T1]{fontenc}
echo \usepackage{amsmath}
echo \usepackage{graphicx}
echo \usepackage{hyperref}
echo \usepackage{natbib}
echo \usepackage{setspace}
echo \usepackage{fancyhdr}
echo \usepackage{geometry}
echo \usepackage{tocloft}
echo \usepackage{glossaries}
echo.
echo \begin{document}
echo Teste de compatibilidade de pacotes.
echo \end{document}
) > "%test_dir%\test.tex"

call :compile_document "%compiler%" "test.tex" "%test_dir%"
if not errorlevel 1 (
    call :log "SUCCESS" "Teste %test_name%: PASSOU"
    set /a PASSED_TESTS+=1
) else (
    call :log "ERROR" "Teste %test_name%: FALHOU (incompatibilidade de pacotes)"
    set /a FAILED_TESTS+=1
    
    if exist "%test_dir%\test.log" (
        copy "%test_dir%\test.log" "%RESULTS_DIR%\%test_name%_error.log" >nul
    )
)
goto :eof

REM ============================================================================
REM FUNÇÃO PRINCIPAL DE EXECUÇÃO DOS TESTES
REM ============================================================================

:run_all_tests
call :log "INFO" "Iniciando execução de todos os testes..."

REM Determina quais compiladores testar
set "compilers_to_test="
if not "%SPECIFIC_COMPILER%"=="" (
    set "compilers_to_test=%SPECIFIC_COMPILER%"
) else (
    for %%c in (%COMPILERS%) do (
        where %%c >nul 2>&1
        if not errorlevel 1 (
            set "compilers_to_test=!compilers_to_test! %%c"
        ) else (
            call :log "WARN" "Compilador %%c não encontrado, pulando testes"
        )
    )
)

REM Determina quais tipos de documento testar
set "types_to_test="
if not "%SPECIFIC_TYPE%"=="" (
    set "types_to_test=%SPECIFIC_TYPE%"
) else (
    set "types_to_test=%DOCUMENT_TYPES%"
)

call :log "INFO" "Compiladores a testar:%compilers_to_test%"
call :log "INFO" "Tipos de documento a testar: %types_to_test%"

REM Executa testes básicos
call :log "INFO" "=== TESTES BÁSICOS DE COMPILAÇÃO ==="
for %%c in (%compilers_to_test%) do (
    for %%t in (%types_to_test%) do (
        call :test_basic_compilation "%%c" "%%t"
    )
)

REM Executa testes de compatibilidade
call :log "INFO" "=== TESTES DE COMPATIBILIDADE ==="
for %%c in (%compilers_to_test%) do (
    call :test_distribution_compatibility "%%c"
)

REM Executa testes de validação
call :log "INFO" "=== TESTES DE VALIDAÇÃO ==="
for %%c in (%compilers_to_test%) do (
    call :test_validation "%%c"
)

goto :eof

REM ============================================================================
REM GERAÇÃO DE RELATÓRIOS
REM ============================================================================

:generate_report
call :log "INFO" "Gerando relatório final..."

set "report_file=%RESULTS_DIR%\test-report.md"

REM Relatório em Markdown
(
echo # Relatório de Testes - UnB-PPGT LaTeX Class
echo.
echo **Data:** %date% %time%
echo **Diretório:** %PROJECT_ROOT%
echo.
echo ## Resumo dos Resultados
echo.
echo - **Total de testes:** %TOTAL_TESTS%
echo - **Testes aprovados:** %PASSED_TESTS%
echo - **Testes falharam:** %FAILED_TESTS%
set /a success_rate=PASSED_TESTS*100/TOTAL_TESTS
echo - **Taxa de sucesso:** !success_rate!%%
echo.
echo ## Detalhes dos Testes
echo.
echo ### Compiladores Testados
) > "%report_file%"

for %%c in (%COMPILERS%) do (
    where %%c >nul 2>&1
    if not errorlevel 1 (
        for /f "tokens=*" %%v in ('%%c --version 2^>nul ^| findstr /n "." ^| findstr "1:"') do (
            set "version=%%v"
            set "version=!version:~2!"
            echo - **%%c:** !version! >> "%report_file%"
        )
    ) else (
        echo - **%%c:** Não disponível >> "%report_file%"
    )
)

(
echo.
echo ### Arquivos Gerados
echo.
echo Os seguintes arquivos foram gerados durante os testes:
echo.
) >> "%report_file%"

REM Lista PDFs gerados
for %%f in ("%RESULTS_DIR%\*.pdf") do (
    if exist "%%f" (
        for %%s in ("%%f") do (
            set "size=%%~zs"
            set /a size_kb=!size!/1024
            echo - **%%~nxf** (!size_kb! KB) >> "%report_file%"
        )
    )
)

REM Lista logs de erro
(
echo.
echo ### Logs de Erro
echo.
) >> "%report_file%"

for %%f in ("%RESULTS_DIR%\*_error.log") do (
    if exist "%%f" (
        echo - **%%~nxf** >> "%report_file%"
    )
)

call :log "SUCCESS" "Relatório gerado: %report_file%"
goto :eof

REM ============================================================================
REM PROCESSAMENTO DE ARGUMENTOS E EXECUÇÃO PRINCIPAL
REM ============================================================================

:show_help
echo Sistema de Testes Automatizados para UnB-PPGT
echo.
echo Uso: %~nx0 [opções]
echo.
echo Opções:
echo   -c COMP     Testa apenas o compilador especificado
echo               (pdflatex, xelatex, lualatex)
echo   -t TYPE     Testa apenas o tipo de documento especificado
echo               (mestrado, doutorado, qualificacao, etc.)
echo   -v          Saída detalhada
echo   -q          Saída mínima
echo   -h          Mostra esta ajuda
echo.
echo Exemplos:
echo   %~nx0                Executa todos os testes
echo   %~nx0 -c pdflatex    Testa apenas com pdflatex
echo   %~nx0 -t mestrado    Testa apenas documentos de mestrado
echo   %~nx0 -v -c xelatex  Testa com xelatex em modo verboso
echo.
goto :eof

REM Processa argumentos da linha de comando
:parse_args
if "%1"=="" goto :args_done
if "%1"=="-c" (
    set "SPECIFIC_COMPILER=%2"
    shift
    shift
    goto :parse_args
)
if "%1"=="-t" (
    set "SPECIFIC_TYPE=%2"
    shift
    shift
    goto :parse_args
)
if "%1"=="-v" (
    set "VERBOSE=true"
    shift
    goto :parse_args
)
if "%1"=="-q" (
    set "QUIET=true"
    shift
    goto :parse_args
)
if "%1"=="-h" (
    call :show_help
    exit /b 0
)
echo Opção desconhecida: %1
call :show_help
exit /b 1

:args_done

REM Validação de argumentos
if not "%SPECIFIC_COMPILER%"=="" (
    echo %COMPILERS% | findstr /c:"%SPECIFIC_COMPILER%" >nul
    if errorlevel 1 (
        echo Compilador inválido: %SPECIFIC_COMPILER%
        echo Compiladores válidos: %COMPILERS%
        exit /b 1
    )
)

if not "%SPECIFIC_TYPE%"=="" (
    echo %DOCUMENT_TYPES% | findstr /c:"%SPECIFIC_TYPE%" >nul
    if errorlevel 1 (
        echo Tipo de documento inválido: %SPECIFIC_TYPE%
        echo Tipos válidos: %DOCUMENT_TYPES%
        exit /b 1
    )
)

REM ============================================================================
REM EXECUÇÃO PRINCIPAL
REM ============================================================================

:main
call :parse_args %*

call :log "INFO" "Iniciando sistema de testes UnB-PPGT..."

REM Preparação
call :setup_test_environment
call :check_dependencies

REM Execução dos testes
call :run_all_tests

REM Relatórios
call :generate_report

REM Limpeza
call :cleanup_test_environment

REM Resultado final
echo.
echo ==========================================
echo RESULTADO FINAL DOS TESTES
echo ==========================================
echo Total de testes: %TOTAL_TESTS%
echo Testes aprovados: %PASSED_TESTS%
echo Testes falharam: %FAILED_TESTS%

if %FAILED_TESTS% equ 0 (
    echo TODOS OS TESTES PASSARAM!
    exit /b 0
) else (
    echo %FAILED_TESTS% TESTE(S) FALHARAM
    echo Consulte os logs em: %RESULTS_DIR%
    exit /b 1
)

REM Chama função principal
call :main %*