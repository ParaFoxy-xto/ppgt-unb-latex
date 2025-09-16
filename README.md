# Modelo LaTeX para PPGT-UnB

Este repositório contém o modelo LaTeX oficial para dissertações e teses do **Programa de Pós-Graduação em Transportes (PPGT)** da Universidade de Brasília, desenvolvido com base no template Word oficial do programa.

## 📋 Características

- ✅ Baseado no template Word oficial do PPGT-UnB
- ✅ Compatível com pdfLaTeX, XeLaTeX e LuaLaTeX
- ✅ Geração automática de páginas pré-textuais
- ✅ Integração com BibTeX/BibLaTeX
- ✅ Suporte para diferentes tipos de documento (mestrado, doutorado, qualificação)
- ✅ Interface simples e intuitiva
- ✅ Documentação completa e exemplos

## 🚀 Início Rápido

### Pré-requisitos

- Distribuição LaTeX completa (TeX Live, MiKTeX ou MacTeX)
- Editor LaTeX (recomendado: VS Code com LaTeX Workshop, TeXstudio, ou Overleaf)

### Instalação

1. **Clone ou baixe este repositório:**
   ```bash
   git clone https://github.com/ppgt-unb/latex-template.git
   cd latex-template
   ```

2. **Compile o documento de exemplo:**
   ```bash
   pdflatex monografia.tex
   bibtex monografia
   pdflatex monografia.tex
   pdflatex monografia.tex
   ```

3. **Ou use o Makefile (Linux/macOS):**
   ```bash
   make
   ```

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

### Problemas Comuns

1. **Erro de compilação com acentos:**
   - Certifique-se de que seus arquivos estão salvos em UTF-8
   - Use `\usepackage[utf8]{inputenc}` se necessário

2. **Bibliografia não aparece:**
   - Execute a sequência completa: pdflatex → bibtex → pdflatex → pdflatex
   - Verifique se há citações no texto com `\cite{}`

3. **Figuras não aparecem:**
   - Verifique se o caminho da imagem está correto
   - Certifique-se de que a imagem está em formato suportado (PNG, JPG, PDF)

4. **Problemas com caracteres especiais:**
   - Use comandos LaTeX: `\~{a}` para ã, `\'{e}` para é, etc.
   - Ou configure adequadamente a codificação UTF-8

### Logs e Depuração

- Sempre verifique o arquivo `.log` para mensagens de erro detalhadas
- Use `\listfiles` no preâmbulo para listar pacotes carregados
- Compile com `-interaction=nonstopmode` para ver todos os erros

## 📖 Exemplos Avançados

### Subfiguras

```latex
\begin{figure}[htb]
    \centering
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{img/fig1.png}
        \caption{Primeira subfigura}
        \label{fig:sub1}
    \end{subfigure}
    \hfill
    \begin{subfigure}{0.45\textwidth}
        \includegraphics[width=\textwidth]{img/fig2.png}
        \caption{Segunda subfigura}
        \label{fig:sub2}
    \end{subfigure}
    \caption{Figura com subfiguras}
    \label{fig:completa}
\end{figure}
```

### Tabelas Complexas

```latex
\begin{table}[htb]
    \centering
    \caption{Tabela com células mescladas}
    \label{tab:complexa}
    \begin{tabular}{lcccc}
        \toprule
        \multirow{2}{*}{\textbf{Variável}} & \multicolumn{2}{c}{\textbf{Grupo A}} & \multicolumn{2}{c}{\textbf{Grupo B}} \\
        \cmidrule(lr){2-3} \cmidrule(lr){4-5}
        & \textbf{Média} & \textbf{DP} & \textbf{Média} & \textbf{DP} \\
        \midrule
        Variável 1 & 10,5 & 2,3 & 12,1 & 1,8 \\
        Variável 2 & 8,7 & 3,1 & 9,2 & 2,5 \\
        \bottomrule
    \end{tabular}
\end{table}
```

## 🤝 Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 📞 Suporte

- **Issues:** Use o sistema de issues do GitHub para reportar bugs ou solicitar funcionalidades
- **Email:** ppgt@unb.br
- **Documentação:** Consulte este README e os comentários no código

## 🙏 Agradecimentos

- Programa de Pós-Graduação em Transportes da UnB
- Comunidade LaTeX brasileira
- Desenvolvedores das classes UnB-CIC e FGA-UnB que serviram de inspiração

## 📋 Changelog

### v1.0.0 (2024-01-15)
- Versão inicial baseada no template Word oficial
- Suporte completo para dissertações e teses
- Geração automática de páginas pré-textuais
- Integração com bibliografia
- Documentação completa

---

**Desenvolvido com ❤️ para a comunidade acadêmica do PPGT-UnB**