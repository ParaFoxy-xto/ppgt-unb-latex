# Sistema de Listas Automatizadas - UnB-PPGT

## Visão Geral

O modelo LaTeX UnB-PPGT agora inclui um sistema completo de geração automática de listas com formatação específica do PPGT. O sistema gera automaticamente:

1. **Lista de Figuras** - Gerada automaticamente quando há figuras no documento
2. **Lista de Tabelas** - Gerada automaticamente quando há tabelas no documento  
3. **Lista de Siglas e Abreviações** - Gerada automaticamente quando há siglas definidas

## Funcionalidades Implementadas

### 1. Lista de Figuras Automatizada

- **Detecção automática**: Só inclui a lista se houver figuras no documento
- **Formatação PPGT**: Aplica formatação específica com prefixo "Figura" e dois pontos
- **Integração com sumário**: Adiciona automaticamente ao sumário
- **Espaçamento adequado**: Usa espaçamento 1,5 conforme normas

### 2. Lista de Tabelas Automatizada

- **Detecção automática**: Só inclui a lista se houver tabelas no documento
- **Formatação PPGT**: Aplica formatação específica com prefixo "Tabela" e dois pontos
- **Integração com sumário**: Adiciona automaticamente ao sumário
- **Espaçamento adequado**: Usa espaçamento 1,5 conforme normas

### 3. Lista de Siglas e Abreviações

- **Sistema aprimorado**: Baseado no pacote glossaries com melhorias
- **Validação de entrada**: Verifica se siglas e significados não estão vazios
- **Formatação específica**: Espaçamento simples para melhor legibilidade
- **Integração flexível**: Funciona com arquivo siglas.tex ou definições inline

## Como Usar

### Uso Básico (Automático)

O sistema funciona automaticamente. Basta usar figuras, tabelas e siglas normalmente:

```latex
\documentclass[mestrado]{UnB-PPGT}

% Definir siglas
\sigla{PPGT}{Programa de Pós-Graduação em Transportes}
\sigla{UnB}{Universidade de Brasília}

\begin{document}

% As listas são geradas automaticamente no pré-textual

\chapter{Introdução}

% Usar figuras normalmente
\begin{figure}[ht]
\centering
\includegraphics{minha-figura.png}
\caption{Descrição da figura}
\label{fig:exemplo}
\end{figure}

% Usar tabelas normalmente
\begin{table}[ht]
\centering
\caption{Descrição da tabela}
\begin{tabular}{|c|c|}
\hline
Col1 & Col2 \\
\hline
\end{tabular}
\label{tab:exemplo}
\end{table}

% Usar siglas normalmente
O \gls{PPGT} da \gls{UnB} oferece cursos de mestrado e doutorado.

\end{document}
```

### Comandos de Controle Avançado

#### Desabilitar Listas Específicas

```latex
% Desabilitar lista de figuras
\desabilitarlistafiguras

% Desabilitar lista de tabelas
\desabilitarlistatabelas

% Desabilitar lista de siglas
\desabilitarlistasiglas

% Desabilitar todas as listas
\desabilitartodaslistas
```

#### Habilitar Listas Específicas

```latex
% Habilitar lista de figuras
\habilitarlistafiguras

% Habilitar lista de tabelas
\habilitarlistatabelas

% Habilitar lista de siglas
\habilitarlistasiglas

% Habilitar todas as listas
\habilitartodaslistas
```

#### Incluir Listas Manualmente

```latex
% Incluir lista de figuras manualmente
\incluirlistafiguras

% Incluir lista de tabelas manualmente
\incluirlistatabelas

% Incluir lista de siglas manualmente
\incluirlistasiglas
```

#### Forçar Inclusão de Listas Vazias

```latex
% Forçar lista de figuras mesmo sem figuras
\forcarlistafiguras

% Forçar lista de tabelas mesmo sem tabelas
\forcarlistatabelas

% Forçar lista de siglas mesmo sem siglas
\forcarlistasiglas
```

### Personalização de Formatação

#### Personalizar Formatação Individual

```latex
% Personalizar formatação da lista de figuras
\configurarlistafiguras{%
    \singlespacing% Espaçamento simples
    \small% Fonte menor
}

% Personalizar formatação da lista de tabelas
\configurarlistatabelas{%
    \doublespacing% Espaçamento duplo
    \large% Fonte maior
}

% Personalizar formatação da lista de siglas
\configurarlistasiglas{%
    \onehalfspacing% Espaçamento 1,5
    \normalsize% Fonte normal
}
```

#### Personalizar Todas as Listas

```latex
\configurartodaslistas{%
    % Formatação para figuras
    \onehalfspacing\normalsize%
}{%
    % Formatação para tabelas
    \onehalfspacing\normalsize%
}{%
    % Formatação para siglas
    \singlespacing\small%
}
```

#### Personalizar Títulos das Listas

```latex
% Personalizar título da lista de figuras
\titulolistafiguras{Lista de Ilustrações}

% Personalizar título da lista de tabelas
\titulolistatabelas{Lista de Quadros}

% Personalizar título da lista de siglas
\titulolistasiglas{Glossário de Termos}
```

## Formatação Específica do PPGT

### Lista de Figuras
- Prefixo "Figura" antes do número
- Dois pontos após o número (ex: "Figura 1.1: Descrição")
- Espaçamento 1,5 entre linhas
- Fonte normal
- Pontos de preenchimento até o número da página

### Lista de Tabelas
- Prefixo "Tabela" antes do número
- Dois pontos após o número (ex: "Tabela 1.1: Descrição")
- Espaçamento 1,5 entre linhas
- Fonte normal
- Pontos de preenchimento até o número da página

### Lista de Siglas
- Espaçamento simples para melhor legibilidade
- Formatação padrão do glossaries
- Ordenação alfabética automática
- Integração com hyperref para links

## Depuração

### Modo Debug

Para ativar informações de depuração sobre as listas:

```latex
\debuglistas
```

Isso mostrará no log de compilação:
- Quantas figuras foram encontradas
- Quantas tabelas foram encontradas
- Se o arquivo siglas.tex foi encontrado
- Quais listas serão incluídas

### Arquivos Gerados

O sistema gera os seguintes arquivos auxiliares:
- `.lof` - Lista de figuras
- `.lot` - Lista de tabelas
- `.acn`, `.acr` - Arquivos de siglas (glossaries)
- `.glsdefs` - Definições de glossário

## Compatibilidade

- **Compatível com**: pdflatex, xelatex, lualatex
- **Requer**: Pacotes tocloft, glossaries, totalcount
- **Funciona com**: Hyperref, babel, diferentes idiomas

## Solução de Problemas

### Lista não aparece
- Verifique se há figuras/tabelas/siglas no documento
- Compile duas vezes para atualizar referências
- Para siglas, execute `makeglossaries` se disponível

### Formatação incorreta
- Verifique se está usando a versão mais recente da classe
- Compile duas vezes após mudanças de formatação

### Siglas não funcionam
- Verifique se as siglas estão definidas com `\sigla{SIGLA}{Significado}`
- Para usar siglas, use `\gls{SIGLA}` no texto
- Execute `makeglossaries` se disponível no sistema

## Exemplo Completo

Veja o arquivo `test-automated-lists.tex` para um exemplo completo de uso do sistema de listas automatizadas.