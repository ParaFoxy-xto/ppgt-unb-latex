# Modelo LaTeX para PPGT-UnB

Este repositório contém o modelo LaTeX oficial para dissertações e teses do **Programa de Pós-Graduação em Transportes (PPGT)** da Universidade de Brasília, desenvolvido com base no template Word oficial do programa.

## 📋 Características

- ✅ Baseado no template Word oficial do PPGT-UnB
- ✅ Compatível com pdfLaTeX, XeLaTeX e LuaLaTeX
- ✅ Geração automática de páginas pré-textuais
- ✅ Integração com BibTeX/BibLaTeX
- ✅ Suporte para diferentes tipos de documento (mestrado, doutorado, qualificação)
- ✅ Interface simples e intuitiva
- ✅ Sistema de validação e tratamento de erros
- ✅ Documentação completa e exemplos

## 🚀 Início Rápido

### Pré-requisitos

Para usar este modelo, você precisa de uma distribuição LaTeX completa instalada em seu sistema:

#### Windows
- **TeX Live** (recomendado): [Download](https://www.tug.org/texlive/)
- **MiKTeX**: [Download](https://miktex.org/download)

#### macOS
- **MacTeX**: [Download](https://www.tug.org/mactex/)
- **TeX Live** via Homebrew: `brew install --cask mactex`

#### Linux
- **Ubuntu/Debian**: `sudo apt-get install texlive-full`
- **Fedora**: `sudo dnf install texlive-scheme-full`
- **Arch Linux**: `sudo pacman -S texlive-most texlive-lang`

#### Editor LaTeX (Recomendado)
- **VS Code** com extensão LaTeX Workshop
- **TeXstudio** (multiplataforma)
- **TeXmaker** (multiplataforma)
- **Overleaf** (online)

### Instalação

1. **Clone ou baixe este repositório:**
   ```bash
   git clone https://github.com/ppgt-unb/latex-template.git
   cd latex-template
   ```

2. **Teste a instalação compilando o exemplo:**
   ```bash
   # Sequência completa de compilação
   pdflatex monografia.tex
   bibtex monografia
   pdflatex monografia.tex
   pdflatex monografia.tex
   ```

3. **Ou use o Makefile (Linux/macOS/Windows com WSL):**
   ```bash
   make          # Compilação completa
   make clean    # Limpar arquivos auxiliares
   make help     # Ver todas as opções disponíveis
   ```

4. **Verificação da instalação:**
   - Se a compilação foi bem-sucedida, você deve ter um arquivo `monografia.pdf`
   - Abra o PDF e verifique se todas as páginas foram geradas corretamente
   - Verifique se não há mensagens de erro no terminal

## 📁 Estrutura do Projeto

```
ppgt-latex-template/
├── UnB-PPGT.cls              # Classe LaTeX principal
├── monografia.tex            # Arquivo principal do documento
├── bibliografia.bib          # Referências bibliográficas
├── README.md                 # Este arquivo
├── Makefile                  # Automação de compilação (opcional)
├── tex/                      # Capítulos e seções
│   ├── introducao.tex
│   ├── metodologia.tex
│   ├── resultados.tex
│   └── conclusao.tex
└── img/                      # Imagens do documento
    └── exemplo.png
```

## 🎯 Uso Básico

### 1. Configuração do Documento

No arquivo `monografia.tex`, configure as opções da classe:

```latex
\documentclass[mestrado,onehalfspacing,12pt,hyperref]{UnB-PPGT}
```

**Opções disponíveis:**
- **Tipo:** `mestrado` (padrão) | `doutorado` | `qualificacao`
- **Espaçamento:** `onehalfspacing` (padrão) | `singlespacing` | `doublespacing`
- **Fonte:** `12pt` (padrão) | `10pt` | `11pt`
- **Links:** `hyperref` (padrão) | `impressao`

### 2. Definição de Metadados

```latex
% Informações básicas
\titulo{Título do Trabalho}
\subtitulo{Subtítulo (opcional)}
\autor{Nome}{Sobrenome}

% Orientação
\orientador{Prof. Dr. Nome do Orientador}{Universidade de Brasília}
\coorientador{Prof. Dr. Nome do Coorientador}{Instituição} % Opcional

% Data da defesa
\diamesano{15}{março}{2024}

% Banca examinadora
\membrobanca{Prof. Dr. Nome}{Instituição}{Função}
\membrobanca{Prof. Dr. Nome}{Instituição}{Função}
% ... adicione todos os membros

% Palavras-chave
\palavraschave[Para CIP]{palavras, para, resumo}
\keywords[For CIP]{keywords, for, abstract}
```

### 3. Estrutura do Documento

```latex
\begin{document}

% Seção pré-textual
\pretextual
\capa                    % Gerada automaticamente
\folhaderosto           % Gerada automaticamente
\folhadeaprovacao       % Gerada automaticamente
\fichacatalografica     % Gerada automaticamente

% Elementos opcionais
\begin{dedicatoria}
Texto da dedicatória...
\end{dedicatoria}

\begin{agradecimentos}
Texto dos agradecimentos...
\end{agradecimentos}

\begin{resumo}
Texto do resumo...
\end{resumo}

\begin{abstract}
Abstract text...
\end{abstract}

% Listas automáticas
\listoffigures
\listoftables

\begin{siglas}
\item[PPGT] Programa de Pós-Graduação em Transportes
\item[UnB] Universidade de Brasília
\end{siglas}

% Seção textual
\textual
\input{tex/introducao}
\input{tex/metodologia}
\input{tex/resultados}
\input{tex/conclusao}

% Seção pós-textual
\postextual
\bibliography{bibliografia}

\end{document}
```

## 📝 Comandos Específicos

### Capítulos e Seções

```latex
\capitulo{label}{Título do Capítulo}
\section{Título da Seção}
\subsection{Título da Subseção}
```

### Referências Cruzadas

```latex
\refCap{label}      % Referência a capítulo
\refFig{label}      % Referência a figura
\refTab{label}      % Referência a tabela
\refEq{label}       % Referência a equação
```

### Figuras e Tabelas

```latex
% Figura
\begin{figure}[htb]
    \centering
    \includegraphics[width=0.8\textwidth]{img/figura.png}
    \caption{Legenda da figura}
    \label{fig:exemplo}
\end{figure}

% Tabela
\begin{table}[htb]
    \centering
    \caption{Título da tabela}
    \label{tab:exemplo}
    \begin{tabular}{lcc}
        \toprule
        \textbf{Coluna 1} & \textbf{Coluna 2} & \textbf{Coluna 3} \\
        \midrule
        Linha 1 & Dado 1 & Dado 2 \\
        Linha 2 & Dado 3 & Dado 4 \\
        \bottomrule
    \end{tabular}
\end{table}
```

### Equações

```latex
\begin{equation}
    E = mc^2
    \label{eq:einstein}
\end{equation}
```

## 🎨 Personalização

### Comandos Personalizados

Você pode definir comandos personalizados no preâmbulo:

```latex
\newcommand{\sigla}[1]{\textsc{#1}}
\newcommand{\software}[1]{\textit{#1}}
\newcommand{\variavel}[1]{\textit{#1}}
```

### Pacotes Adicionais

Para funcionalidades específicas, adicione pacotes no preâmbulo:

```latex
% Matemática avançada
\usepackage{amsmath,amssymb,amsthm}

% Tabelas avançadas
\usepackage{booktabs,multirow}

% Algoritmos
\usepackage{algorithm,algorithmic}

% Código fonte
\usepackage{listings,xcolor}
```

## 📚 Bibliografia

### Configuração Básica

O modelo usa BibTeX por padrão. Suas referências devem estar no arquivo `bibliografia.bib`:

```bibtex
@article{autor2023,
  author  = {Nome do Autor},
  title   = {Título do Artigo},
  journal = {Nome da Revista},
  year    = {2023},
  volume  = {10},
  pages   = {1--20}
}
```

### Citações

```latex
\cite{autor2023}           % (AUTOR, 2023)
\citep{autor2023}          % (AUTOR, 2023)
\citet{autor2023}          % Autor (2023)
\cite[p. 15]{autor2023}    % (AUTOR, 2023, p. 15)
```

## 🔧 Compilação

### Sequência Padrão

```bash
pdflatex monografia.tex
bibtex monografia
pdflatex monografia.tex
pdflatex monografia.tex
```

### Usando Makefile

```bash
make          # Compilação completa
make clean    # Limpar arquivos auxiliares
make distclean # Limpar tudo exceto PDF
```

### Usando latexmk

```bash
latexmk -pdf monografia.tex
```

## 🐛 Solução de Problemas

### Problemas de Instalação

#### 1. Distribuição LaTeX Incompleta
**Sintoma:** Erro "File `xxx.sty' not found"
```
! LaTeX Error: File `setspace.sty' not found.
```
**Solução:**
- **Windows (MiKTeX):** Abra o MiKTeX Console e instale os pacotes em falta
- **Linux:** Instale `texlive-full` em vez de `texlive-base`
- **macOS:** Use MacTeX completo em vez de BasicTeX

#### 2. Problemas de Codificação
**Sintoma:** Caracteres especiais aparecem incorretamente
```
! Package inputenc Error: Unicode char ã (U+00E3) not set up for use with LaTeX.
```
**Solução:**
- Salve todos os arquivos `.tex` em codificação UTF-8
- No VS Code: `File > Save with Encoding > UTF-8`
- No TeXstudio: `Options > Configure > Editor > Default Font Encoding > UTF-8`

#### 3. Problemas com Imagens
**Sintoma:** Figuras não aparecem ou erro de compilação
```
! LaTeX Error: File `img/figura.png' not found.
```
**Solução:**
- Verifique se o arquivo existe no caminho especificado
- Use formatos suportados: PNG, JPG, PDF (para pdfLaTeX)
- Para XeLaTeX/LuaLaTeX: também suporta SVG e outros formatos

### Problemas de Compilação

#### 1. Bibliografia Não Aparece
**Sintoma:** Lista de referências vazia mesmo com citações
**Solução:**
```bash
# Execute a sequência completa
pdflatex monografia.tex    # 1ª compilação
bibtex monografia          # Processa bibliografia
pdflatex monografia.tex    # 2ª compilação (inclui citações)
pdflatex monografia.tex    # 3ª compilação (resolve referências cruzadas)
```

#### 2. Referências Cruzadas Incorretas
**Sintoma:** "??" no lugar de números de figuras/tabelas
**Solução:**
- Execute pelo menos duas compilações com pdflatex
- Use `\label{}` após `\caption{}` em figuras e tabelas
- Verifique se os labels são únicos

#### 3. Erro de Banca Insuficiente
**Sintoma:** 
```
! Class UnB-PPGT Error: Numero insuficiente de membros da banca: 2
```
**Solução:**
- Adicione pelo menos 3 membros usando `\membrobancafunc{}{}{}`
- Para doutorado, são necessários pelo menos 4 membros

### Problemas de Formatação

#### 1. Espaçamento Incorreto
**Sintoma:** Documento com espaçamento simples quando deveria ser 1,5
**Solução:**
- Verifique se usou a opção correta: `\documentclass[onehalfspacing]{UnB-PPGT}`
- Se o problema persistir, adicione `\onehalfspacing` após `\begin{document}`

#### 2. Margens Incorretas
**Sintoma:** Margens diferentes do template Word
**Solução:**
- Não modifique as configurações de margem manualmente
- Use apenas as opções da classe: `hyperref` (digital) ou `impressao`
- Para debug: adicione `\usepackage{showframe}` para visualizar margens

#### 3. Numeração de Páginas Incorreta
**Sintoma:** Páginas pré-textuais com numeração arábica
**Solução:**
- Certifique-se de usar `\pretextual` antes das páginas pré-textuais
- Use `\textual` antes dos capítulos
- Use `\postextual` antes da bibliografia

### Problemas Específicos por Sistema

#### Windows
```bash
# Se houver problemas com caminhos
# Use barras normais em vez de barras invertidas
\includegraphics{img/figura.png}  # ✓ Correto
\includegraphics{img\figura.png}  # ✗ Pode causar problemas
```

#### macOS
```bash
# Se houver problemas com fontes
# Instale as fontes do sistema
sudo tlmgr install collection-fontsrecommended
```

#### Linux
```bash
# Se houver problemas de permissão
sudo chown -R $USER:$USER ~/texmf
sudo tlmgr init-usertree
```

### Ferramentas de Diagnóstico

#### 1. Verificação de Pacotes
Adicione no preâmbulo para listar todos os pacotes carregados:
```latex
\listfiles
```

#### 2. Modo Draft para Debug
Use a opção `draft` para compilação mais rápida durante desenvolvimento:
```latex
\documentclass[mestrado,draft]{UnB-PPGT}
```

#### 3. Verificação de Logs
Sempre verifique o arquivo `.log` para mensagens detalhadas:
```bash
# Procure por erros específicos
grep -i error monografia.log
grep -i warning monografia.log
```

#### 4. Compilação Verbosa
Para ver mais detalhes durante a compilação:
```bash
pdflatex -interaction=nonstopmode -file-line-error monografia.tex
```

### Problemas Avançados

#### 1. Conflitos de Pacotes
**Sintoma:** Erros sobre comandos redefinidos
**Solução:**
- Carregue pacotes na ordem correta (geometry antes de fancyhdr)
- Use `\PassOptionsToPackage{}{}` se necessário
- Consulte a documentação dos pacotes para opções de compatibilidade

#### 2. Problemas de Memória
**Sintoma:** "TeX capacity exceeded"
**Solução:**
```bash
# Aumente os limites do TeX
export max_print_line=1000
export error_line=254
export half_error_line=238
```

#### 3. Problemas com Hyperref
**Sintoma:** Links quebrados ou formatação estranha
**Solução:**
- Use a opção `impressao` se não precisar de links
- Para problemas específicos: `\usepackage[hidelinks]{hyperref}`

### Obtendo Ajuda

#### 1. Informações do Sistema
Execute para obter informações de diagnóstico:
```bash
pdflatex --version
bibtex --version
kpsewhich --var-value TEXMFHOME
```

#### 2. Comunidade
- **TeX Stack Exchange:** [tex.stackexchange.com](https://tex.stackexchange.com)
- **LaTeX Community:** [latex.org/forum](https://latex.org/forum)
- **PPGT-UnB:** Entre em contato com o programa

#### 3. Reportar Bugs
Ao reportar problemas, inclua:
- Versão do LaTeX (`pdflatex --version`)
- Sistema operacional
- Arquivo `.log` completo
- Exemplo mínimo que reproduz o problema

## 📖 Exemplos Avançados

### Subfiguras

Para incluir múltiplas figuras lado a lado:

```latex
\usepackage{subcaption} % Adicione no preâmbulo

\begin{figure}[htb]
    \centering
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{img/grafico_antes.png}
        \caption{Situação antes da intervenção}
        \label{fig:antes}
    \end{subfigure}
    \hfill
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{img/grafico_depois.png}
        \caption{Situação após a intervenção}
        \label{fig:depois}
    \end{subfigure}
    \caption{Comparação do fluxo de veículos antes e depois da implementação do BRT}
    \label{fig:comparacao}
\end{figure}

% Referências: \refFig{fig:antes}, \refFig{fig:depois}, \refFig{fig:comparacao}
```

### Tabelas Complexas

Para tabelas com células mescladas e formatação avançada:

```latex
\usepackage{booktabs,multirow} % Adicione no preâmbulo

\begin{table}[htb]
    \centering
    \caption{Análise comparativa de modais de transporte}
    \label{tab:modais}
    \begin{tabular}{lcccc}
        \toprule
        \multirow{2}{*}{\textbf{Modal}} & \multicolumn{2}{c}{\textbf{Custo (R\$/km)}} & \multicolumn{2}{c}{\textbf{Tempo (min)}} \\
        \cmidrule(lr){2-3} \cmidrule(lr){4-5}
        & \textbf{Usuário} & \textbf{Social} & \textbf{Pico} & \textbf{Normal} \\
        \midrule
        Ônibus & 3,50 & 2,80 & 45 & 35 \\
        Metrô & 4,00 & 3,20 & 25 & 20 \\
        Automóvel & 8,50 & 12,30 & 35 & 25 \\
        Bicicleta & 0,00 & 0,50 & 30 & 30 \\
        \bottomrule
    \end{tabular}
    \fonte{Elaboração própria com base em dados da SEMOB-DF (2023)}
\end{table}
```

### Equações Numeradas

Para equações matemáticas com numeração:

```latex
\usepackage{amsmath} % Já incluído na classe

% Equação simples
\begin{equation}
    V = \frac{Q}{C}
    \label{eq:velocidade}
\end{equation}

% Sistema de equações
\begin{align}
    F &= ma \label{eq:newton} \\
    E &= mc^2 \label{eq:einstein} \\
    P &= \frac{F}{A} \label{eq:pressao}
\end{align}

% Referência: Como mostrado na \refEq{eq:velocidade}...
```

### Algoritmos

Para incluir algoritmos e pseudocódigo:

```latex
\usepackage{algorithm}
\usepackage{algorithmic}

\begin{algorithm}[htb]
\caption{Algoritmo de otimização de rotas}
\label{alg:otimizacao}
\begin{algorithmic}[1]
\REQUIRE Matriz de distâncias $D$, conjunto de pontos $P$
\ENSURE Rota otimizada $R$
\STATE $R \leftarrow \emptyset$
\STATE $atual \leftarrow$ ponto inicial
\WHILE{$P \neq \emptyset$}
    \STATE $proximo \leftarrow$ ponto mais próximo de $atual$ em $P$
    \STATE $R \leftarrow R \cup \{proximo\}$
    \STATE $P \leftarrow P \setminus \{proximo\}$
    \STATE $atual \leftarrow proximo$
\ENDWHILE
\RETURN $R$
\end{algorithmic}
\end{algorithm}
```

### Código Fonte

Para incluir código de programação:

```latex
\usepackage{listings}
\usepackage{xcolor}

% Configuração para Python
\lstset{
    language=Python,
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue},
    commentstyle=\color{green},
    stringstyle=\color{red},
    numbers=left,
    numberstyle=\tiny,
    frame=single,
    breaklines=true
}

\begin{lstlisting}[caption={Análise de dados de mobilidade}, label=lst:python]
import pandas as pd
import numpy as np

# Carrega dados de mobilidade
dados = pd.read_csv('mobilidade.csv')

# Calcula estatísticas básicas
media_tempo = dados['tempo_viagem'].mean()
desvio_tempo = dados['tempo_viagem'].std()

print(f"Tempo médio: {media_tempo:.2f} min")
print(f"Desvio padrão: {desvio_tempo:.2f} min")
\end{lstlisting}
```

### Gráficos com TikZ

Para gráficos e diagramas criados diretamente no LaTeX:

```latex
\usepackage{tikz}
\usepackage{pgfplots}

\begin{figure}[htb]
    \centering
    \begin{tikzpicture}
        \begin{axis}[
            xlabel={Tempo (horas)},
            ylabel={Fluxo de veículos},
            title={Variação do fluxo ao longo do dia},
            grid=major,
            width=0.8\textwidth,
            height=0.6\textwidth
        ]
        \addplot[blue,thick] coordinates {
            (6,200) (7,800) (8,1200) (9,900) (10,600)
            (11,500) (12,700) (13,650) (14,550) (15,600)
            (16,900) (17,1100) (18,1300) (19,800) (20,400)
        };
        \end{axis}
    \end{tikzpicture}
    \caption{Fluxo de veículos na Asa Norte durante um dia útil}
    \label{fig:fluxo}
\end{figure}
```

### Citações Avançadas

Diferentes tipos de citações com natbib:

```latex
% Citação simples
\cite{silva2023}                    % (SILVA, 2023)

% Citação no texto
\citet{silva2023}                   % Silva (2023)

% Citação com página
\cite[p. 45]{silva2023}             % (SILVA, 2023, p. 45)

% Múltiplas citações
\cite{silva2023,santos2022,lima2021} % (SILVA, 2023; SANTOS, 2022; LIMA, 2021)

% Citação de autor apenas
\citeauthor{silva2023}              % Silva

% Citação de ano apenas
\citeyear{silva2023}                % 2023

% Citação online (autor faz parte da frase)
\citeonline{silva2023}              % Silva (2023)
```

### Apêndices e Anexos

Para incluir material complementar:

```latex
% No final do documento, após \postextual

% Apêndices (material elaborado pelo autor)
\apendice{ap:questionario}{Questionário Aplicado na Pesquisa}
\input{tex/apendice-questionario}

\apendice{ap:calculos}{Cálculos Detalhados}
\input{tex/apendice-calculos}

% Anexos (material de terceiros)
\anexo{an:legislacao}{Lei Federal nº 12.587/2012}
\input{tex/anexo-legislacao}

\anexo{an:mapas}{Mapas da Região Metropolitana}
\input{tex/anexo-mapas}
```

### Glossário e Lista de Símbolos

Para definições e símbolos técnicos:

```latex
\usepackage[acronym,symbols]{glossaries}
\makeglossaries

% Definições no preâmbulo
\newacronym{brt}{BRT}{Bus Rapid Transit}
\newacronym{vlt}{VLT}{Veículo Leve sobre Trilhos}

\newglossaryentry{mobilidade}{
    name=mobilidade urbana,
    description={Condição em que se realizam os deslocamentos de pessoas e cargas no espaço urbano}
}

% No documento
\gls{brt}           % Bus Rapid Transit (BRT) na primeira ocorrência, BRT nas seguintes
\glspl{vlt}         % VLTs (plural)
\gls{mobilidade}    % mobilidade urbana

% Lista de símbolos
\newglossaryentry{velocidade}{
    type=symbols,
    name={\ensuremath{v}},
    description={velocidade média},
    sort=v
}

% No final do documento
\printglossary[type=\acronymtype,title=Lista de Siglas]
\printglossary[type=symbols,title=Lista de Símbolos]
\printglossary[title=Glossário]
```

## 🔧 Guia de Instalação Detalhado

### Instalação no Windows

#### Opção 1: TeX Live (Recomendado)
1. Baixe o instalador do [TeX Live](https://www.tug.org/texlive/acquire-netinst.html)
2. Execute `install-tl-windows.exe` como administrador
3. Selecione "Install TeX Live" e aguarde (pode demorar 1-2 horas)
4. Adicione `C:\texlive\2023\bin\win32` ao PATH do sistema

#### Opção 2: MiKTeX
1. Baixe o [MiKTeX](https://miktex.org/download)
2. Execute o instalador e escolha "Install for all users"
3. Configure para instalar pacotes automaticamente
4. Abra o MiKTeX Console e atualize todos os pacotes

#### Editor Recomendado para Windows
- **VS Code** + LaTeX Workshop: Mais moderno e flexível
- **TeXstudio**: Interface tradicional, muito estável

### Instalação no macOS

#### Usando MacTeX (Recomendado)
```bash
# Download direto
curl -O http://mirror.ctan.org/systems/mac/mactex/MacTeX.pkg
sudo installer -pkg MacTeX.pkg -target /

# Ou usando Homebrew
brew install --cask mactex
```

#### Configuração pós-instalação
```bash
# Adicione ao PATH (adicione ao ~/.zshrc ou ~/.bash_profile)
export PATH="/usr/local/texlive/2023/bin/universal-darwin:$PATH"

# Atualize a base de dados
sudo tlmgr update --self --all
```

### Instalação no Linux

#### Ubuntu/Debian
```bash
# Instalação completa (recomendado)
sudo apt update
sudo apt install texlive-full

# Instalação mínima + pacotes específicos
sudo apt install texlive-latex-base texlive-latex-recommended \
                 texlive-latex-extra texlive-fonts-recommended \
                 texlive-lang-portuguese texlive-bibtex-extra
```

#### Fedora/CentOS/RHEL
```bash
# Instalação completa
sudo dnf install texlive-scheme-full

# Instalação mínima
sudo dnf install texlive-latex texlive-collection-latexrecommended \
                 texlive-collection-latexextra texlive-babel-portuguese
```

#### Arch Linux
```bash
# Instalação completa
sudo pacman -S texlive-most texlive-lang

# Instalação mínima
sudo pacman -S texlive-core texlive-latexextra texlive-langportuguese
```

### Configuração do Editor

#### VS Code + LaTeX Workshop
1. Instale o VS Code
2. Instale a extensão "LaTeX Workshop"
3. Configure no `settings.json`:

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": ["%DOCFILE%"]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex ➞ bibtex ➞ pdflatex × 2",
            "tools": ["pdflatex", "bibtex", "pdflatex", "pdflatex"]
        }
    ]
}
```

#### TeXstudio
1. Baixe e instale o [TeXstudio](https://www.texstudio.org/)
2. Configure em Options > Configure TeXstudio:
   - Build: Default Compiler = PdfLaTeX
   - Build: Default Bibliography Tool = BibTeX
   - Editor: Encoding = UTF-8

### Verificação da Instalação

Execute os seguintes comandos para verificar se tudo está funcionando:

```bash
# Verificar versões
pdflatex --version
bibtex --version
makeindex --version

# Testar compilação simples
echo '\documentclass{article}\begin{document}Hello World\end{document}' > test.tex
pdflatex test.tex
```

## 📚 Guia de Uso Completo

### Estrutura Recomendada do Projeto

```
minha-dissertacao/
├── monografia.tex           # Arquivo principal
├── UnB-PPGT.cls            # Classe LaTeX (copie do template)
├── bibliografia.bib        # Referências bibliográficas
├── Makefile               # Automação (opcional)
├── tex/                   # Capítulos
│   ├── introducao.tex
│   ├── revisao.tex
│   ├── metodologia.tex
│   ├── resultados.tex
│   ├── conclusao.tex
│   ├── resumo.tex
│   ├── abstract.tex
│   └── siglas.tex
├── img/                   # Imagens
│   ├── logo-unb.png
│   ├── figura1.png
│   └── grafico1.pdf
├── dados/                 # Dados da pesquisa (opcional)
│   ├── questionario.csv
│   └── analise.xlsx
└── backup/               # Backups (opcional)
    ├── versao-1.0/
    └── versao-2.0/
```

### Fluxo de Trabalho Recomendado

#### 1. Configuração Inicial
```bash
# Clone o template
git clone https://github.com/ppgt-unb/latex-template.git minha-dissertacao
cd minha-dissertacao

# Teste a compilação
make

# Configure seu controle de versão
git init
git add .
git commit -m "Configuração inicial do template"
```

#### 2. Personalização dos Metadados
Edite o arquivo `monografia.tex` e configure:
- Título e subtítulo
- Dados do autor
- Orientador e coorientador
- Data da defesa
- Membros da banca
- Palavras-chave

#### 3. Desenvolvimento do Conteúdo
- Escreva cada capítulo em um arquivo separado na pasta `tex/`
- Use `\input{tex/capitulo}` para incluir no documento principal
- Mantenha as imagens organizadas na pasta `img/`
- Atualize a bibliografia no arquivo `bibliografia.bib`

#### 4. Compilação Regular
```bash
# Durante o desenvolvimento (compilação rápida)
pdflatex monografia.tex

# Quando adicionar citações (compilação completa)
make

# Para limpar arquivos temporários
make clean
```

### Dicas de Produtividade

#### 1. Controle de Versão
```bash
# Configure .gitignore para LaTeX
echo "*.aux
*.bbl
*.blg
*.log
*.out
*.toc
*.lof
*.lot
*.fls
*.fdb_latexmk
*.synctex.gz" > .gitignore

# Commits regulares
git add .
git commit -m "Capítulo 2: Revisão da literatura"
```

#### 2. Backup Automático
```bash
# Script para backup automático (Linux/macOS)
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
tar -czf "backup/backup_$DATE.tar.gz" *.tex tex/ img/ bibliografia.bib
```

#### 3. Compilação Automática
Configure seu editor para compilar automaticamente ao salvar, ou use:
```bash
# Observa mudanças e recompila automaticamente
latexmk -pdf -pvc monografia.tex
```

## 🤝 Contribuição

### Como Contribuir

Contribuições são muito bem-vindas! Você pode ajudar de várias formas:

#### 1. Reportando Bugs
- Use o sistema de [Issues do GitHub](https://github.com/ppgt-unb/latex-template/issues)
- Inclua informações detalhadas sobre o problema
- Forneça um exemplo mínimo que reproduz o erro

#### 2. Sugerindo Melhorias
- Abra uma Issue com sua sugestão
- Descreva o problema atual e a solução proposta
- Inclua exemplos de uso se aplicável

#### 3. Contribuindo com Código
```bash
# 1. Fork o projeto no GitHub
# 2. Clone seu fork
git clone https://github.com/seu-usuario/latex-template.git
cd latex-template

# 3. Crie uma branch para sua feature
git checkout -b feature/nova-funcionalidade

# 4. Faça suas modificações
# 5. Teste suas mudanças
make test

# 6. Commit suas mudanças
git commit -am 'Adiciona nova funcionalidade X'

# 7. Push para sua branch
git push origin feature/nova-funcionalidade

# 8. Abra um Pull Request
```

#### 4. Melhorando a Documentação
- Corrija erros de digitação
- Adicione exemplos práticos
- Traduza para outros idiomas
- Melhore explicações técnicas

### Diretrizes para Contribuição

#### Código
- Mantenha compatibilidade com pdfLaTeX, XeLaTeX e LuaLaTeX
- Adicione comentários explicativos
- Teste em diferentes sistemas operacionais
- Siga as convenções de nomenclatura existentes

#### Documentação
- Use linguagem clara e objetiva
- Inclua exemplos práticos
- Mantenha a formatação consistente
- Teste todos os exemplos fornecidos

## 📄 Licença

Este projeto está licenciado sob a **Licença MIT** - veja o arquivo [LICENSE](LICENSE) para detalhes.

### O que isso significa?
- ✅ Uso comercial permitido
- ✅ Modificação permitida
- ✅ Distribuição permitida
- ✅ Uso privado permitido
- ❌ Sem garantia
- ❌ Sem responsabilidade do autor

## 📞 Suporte e Contato

### Canais Oficiais
- **Issues GitHub:** [github.com/ppgt-unb/latex-template/issues](https://github.com/ppgt-unb/latex-template/issues)
- **Email PPGT:** ppgt@unb.br
- **Site do PPGT:** [ppgt.unb.br](https://ppgt.unb.br)

### Comunidade LaTeX
- **TeX Stack Exchange:** [tex.stackexchange.com](https://tex.stackexchange.com)
- **LaTeX Community:** [latex.org/forum](https://latex.org/forum)
- **Grupo LaTeX Brasil:** [groups.google.com/g/latex-br](https://groups.google.com/g/latex-br)

### Ao Solicitar Ajuda
Inclua sempre:
1. Versão do LaTeX (`pdflatex --version`)
2. Sistema operacional
3. Arquivo `.log` completo
4. Exemplo mínimo que reproduz o problema
5. Descrição detalhada do comportamento esperado vs. atual

## 🙏 Agradecimentos

### Instituições
- **Programa de Pós-Graduação em Transportes (PPGT-UnB)**
- **Universidade de Brasília (UnB)**
- **Faculdade de Tecnologia (FT)**

### Projetos que Inspiraram
- **UnB-CIC:** Classe LaTeX do Departamento de Ciência da Computação
- **FGA-UnB:** Modelo da Faculdade do Gama
- **abnTeX2:** Normas ABNT para LaTeX

### Comunidade
- Comunidade LaTeX brasileira
- Desenvolvedores do TeX Live e MiKTeX
- Contribuidores do projeto no GitHub

### Colaboradores
Agradecemos a todos que contribuíram com código, documentação, testes e feedback.

## 📋 Changelog

### v1.2.0 (2024-03-15)
- ✨ Adicionado sistema completo de validação e tratamento de erros
- ✨ Implementado suporte aprimorado para diferentes tipos de documento
- 🐛 Corrigidos problemas de formatação em listas automáticas
- 📚 Documentação completamente reescrita com exemplos práticos
- 🔧 Melhorada compatibilidade com XeLaTeX e LuaLaTeX

### v1.1.0 (2024-02-20)
- ✨ Adicionado suporte para qualificação de mestrado e doutorado
- ✨ Implementada geração automática de ficha catalográfica
- 🐛 Corrigidos problemas de numeração de páginas
- 📚 Adicionados exemplos de uso avançado

### v1.0.0 (2024-01-15)
- 🎉 Versão inicial baseada no template Word oficial
- ✨ Suporte completo para dissertações e teses
- ✨ Geração automática de páginas pré-textuais
- ✨ Integração com BibTeX/natbib
- 📚 Documentação inicial

### Próximas Versões (Roadmap)
- [ ] Suporte para BibLaTeX como alternativa ao natbib
- [ ] Templates específicos para diferentes áreas de pesquisa
- [ ] Integração com ferramentas de gestão de referências (Zotero, Mendeley)
- [ ] Suporte aprimorado para documentos multilíngues
- [ ] Tema escuro para visualização digital

---

**Desenvolvido com ❤️ para a comunidade acadêmica do PPGT-UnB**

*"A educação é a arma mais poderosa que você pode usar para mudar o mundo."* - Nelson Mandela