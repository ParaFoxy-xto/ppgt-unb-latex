# Design Document

## Overview

O modelo LaTeX para o PPGT será desenvolvido como uma classe LaTeX personalizada (.cls) seguindo principalmente a abordagem elegante e simplificada da classe UnB-CIC, que é mais moderna, intuitiva e fácil de usar. O design aproveitará a robustez e simplicidade da UnB-CIC, adaptando-a especificamente para as necessidades do Programa de Pós-Graduação em Transportes.

A arquitetura seguirá o padrão minimalista da CIC, onde:
- Uma única classe LaTeX (.cls) contém toda a lógica de formatação
- Interface simples e intuitiva para o usuário
- Mínimo de arquivos auxiliares necessários
- Foco na facilidade de uso e manutenção

## Architecture

### Estrutura de Arquivos

```
ppgt-unb-latex/
├── UnB-PPGT.cls                 # Classe principal (inspirada na UnB-CIC.cls)
├── monografia.tex               # Arquivo principal do documento
├── tex/                         # Capítulos e seções (seguindo padrão CIC)
│   ├── resumo.tex
│   ├── abstract.tex
│   ├── dedicatoria.tex
│   ├── agradecimentos.tex
│   ├── introducao.tex
│   ├── capitulo1.tex
│   ├── conclusao.tex
│   └── siglas.tex
├── img/                         # Imagens do documento
│   ├── unb-logo.png            # Logo da UnB (integrado na classe)
│   └── exemplo.png
├── bibliografia.bib             # Referências bibliográficas
├── README.md                    # Documentação de uso
└── Makefile                     # Automação de compilação (opcional)
```

### Componentes Principais

1. **Classe UnB-PPGT.cls**: Classe única e autocontida que herda de `report`, seguindo o padrão elegante da UnB-CIC
2. **Sistema de comandos simplificado**: Interface intuitiva inspirada na CIC para definir metadados
3. **Geração automática integrada**: Sistema embutido na classe para criar todas as páginas necessárias
4. **Logos integrados**: Recursos visuais embutidos na classe, sem necessidade de arquivos externos

## Components and Interfaces

### Classe UnB-PPGT.cls

#### Opções da Classe (seguindo padrão UnB-CIC)
```latex
% Tipos de documento
\DeclareOptionX{mestrado}     % Dissertação de mestrado
\DeclareOptionX{doutorado}    % Tese de doutorado
\DeclareOptionX{qualificacao} % Documento de qualificação

% Espaçamento (compatível com CIC)
\DeclareOptionX{singlespacing}    % Espaçamento simples
\DeclareOptionX{onehalfspacing}   % Espaçamento 1,5 (padrão)
\DeclareOptionX{doublespacing}    % Espaçamento duplo

% Modo de visualização (compatível com CIC)
\DeclareOptionX{impressao}    % Otimizado para impressão
\DeclareOptionX{hyperref}     % Com links (padrão para digital)

% Tamanho da fonte
\DeclareOptionX{10pt}         % Fonte 10pt
\DeclareOptionX{11pt}         % Fonte 11pt  
\DeclareOptionX{12pt}         % Fonte 12pt (padrão)
```

#### Comandos de Metadados (inspirados na UnB-CIC)
```latex
% Informações básicas (seguindo padrão CIC)
\title{Título do trabalho}
\subtitle{Subtítulo (opcional)}
\autor{Nome}{Sobrenome}
\orientador{Nome do orientador}{Instituição}
\coorientador{Nome do coorientador}{Instituição} % Opcional

% Informações da defesa (compatível com CIC)
\diamesano{dia}{mês}{ano}
\coordenador{Nome do coordenador}{Instituição}

% Banca examinadora (seguindo padrão CIC)
\membrobanca{Nome do membro}{Instituição}

% Palavras-chave (compatível com CIC)
\palavraschave[para CIP]{palavras para resumo}
\keywords[for CIP]{keywords for abstract}
```

#### Comandos de Estrutura
```latex
% Seções pré-textuais
\pretextual          % Inicia seção pré-textual
\textual            % Inicia seção textual
\postextual         % Inicia seção pós-textual

% Elementos específicos
\capitulo{label}{Título do Capítulo}
\apendice{label}{Título do Apêndice}
\anexo{label}{Título do Anexo}

% Referências e citações
\refCap{label}      % Referência a capítulo
\refFig{label}      % Referência a figura
\refTab{label}      % Referência a tabela
\refEq{label}       % Referência a equação
```

### Sistema de Páginas Pré-textuais

#### Capa
- Logo da UnB e identificação do PPGT
- Título e subtítulo do trabalho
- Nome do autor
- Tipo de documento (dissertação/tese)
- Local e ano

#### Folha de Rosto
- Informações institucionais completas
- Título e autor
- Texto explicativo sobre o tipo de trabalho
- Orientador e coorientador
- Local e ano

#### Folha de Aprovação
- Título e autor
- Composição da banca examinadora
- Espaços para assinaturas
- Data da defesa

#### Ficha Catalográfica
- Dados bibliográficos padronizados
- Informações para biblioteca
- Cessão de direitos

### Sistema de Formatação

#### Tipografia
- Fonte principal: Times New Roman (ou equivalente)
- Tamanho base: 12pt
- Espaçamento entre linhas: 1,5 (configurável)
- Margens: 3cm (esquerda/superior), 2cm (direita/inferior)

#### Numeração
- Páginas pré-textuais: numeração romana (i, ii, iii...)
- Páginas textuais: numeração arábica (1, 2, 3...)
- Capítulos: numeração sequencial
- Seções: numeração hierárquica (1.1, 1.1.1, etc.)

#### Elementos Flutuantes
- Figuras: centralizadas, com legenda abaixo
- Tabelas: centralizadas, com legenda acima
- Equações: centralizadas, numeradas à direita

## Data Models

### Metadados do Documento
```latex
% Estrutura interna para armazenar metadados
\def\@titulo{...}
\def\@subtitulo{...}
\def\@autor{...}
\def\@orientador{...}
\def\@coorientador{...}
\def\@datadefesa{...}
\def\@palavraschave{...}
\def\@keywords{...}
\def\@tipodocumento{...}  % mestrado/doutorado/qualificacao
```

### Configurações de Formatação
```latex
% Configurações de layout
\def\@marginesquerda{3cm}
\def\@margemdireita{2cm}
\def\@margemsuperior{3cm}
\def\@margeminferior{2cm}
\def\@espacamento{1.5}
\def\@tamanhofontebase{12pt}
```

### Lista de Membros da Banca
```latex
% Array para armazenar membros da banca
\newcounter{membrobanca}
\def\@membrobanca#1#2#3{
  \stepcounter{membrobanca}
  \expandafter\def\csname @nomemembro\themembrobanca\endcsname{#1}
  \expandafter\def\csname @instmembro\themembrobanca\endcsname{#2}
  \expandafter\def\csname @funcmembro\themembrobanca\endcsname{#3}
}
```

## Error Handling

### Validação de Entrada
- Verificação de campos obrigatórios antes da compilação
- Mensagens de erro claras para campos em falta
- Validação de formato de data
- Verificação de número mínimo de membros da banca

### Tratamento de Erros Comuns
```latex
% Exemplo de validação
\AtBeginDocument{%
  \@ifundefined{@titulo}{%
    \ClassError{UnB-PPGT}%
      {Titulo nao definido}%
      {Use o comando \protect\titulo{} para definir o titulo}%
  }{}%
  \@ifundefined{@autor}{%
    \ClassError{UnB-PPGT}%
      {Autor nao definido}%
      {Use o comando \protect\autor{} para definir o autor}%
  }{}%
}
```

### Compatibilidade
- Verificação de versão do LaTeX
- Detecção de pacotes conflitantes
- Fallbacks para recursos não disponíveis
- Suporte a diferentes compiladores (pdflatex, xelatex, lualatex)

## Testing Strategy

### Testes de Compilação
1. **Teste básico**: Documento mínimo com apenas título e autor
2. **Teste completo**: Documento com todas as seções e elementos
3. **Teste de opções**: Verificar todas as opções da classe
4. **Teste de compatibilidade**: Diferentes distribuições LaTeX

### Testes de Formatação
1. **Verificação visual**: Comparação com template Word oficial
2. **Medição de margens**: Verificação de dimensões exatas
3. **Teste de quebras**: Páginas, parágrafos e elementos flutuantes
4. **Teste de numeração**: Páginas, capítulos, figuras, tabelas

### Testes de Funcionalidade
1. **Comandos de metadados**: Todos os comandos de configuração
2. **Geração automática**: Páginas pré-textuais e listas
3. **Referências cruzadas**: Links internos e numeração
4. **Bibliografia**: Integração com BibTeX/BibLaTeX

### Testes de Usabilidade
1. **Documentação**: Clareza e completude das instruções
2. **Mensagens de erro**: Utilidade e clareza
3. **Exemplos**: Funcionamento dos exemplos fornecidos
4. **Instalação**: Processo de setup em diferentes sistemas

### Automação de Testes
- GitHub Actions para compilação automática
- Testes em múltiplas distribuições LaTeX
- Geração automática de PDFs de exemplo
- Verificação de regressões em mudanças

## Implementation Notes

### Especificidades do PPGT (baseadas no template Word oficial)

#### Estrutura Institucional
- **Universidade**: Universidade de Brasília
- **Faculdade**: Faculdade de Tecnologia  
- **Departamento**: Departamento de Engenharia Civil e Ambiental
- **Programa**: Programa de Pós-Graduação em Transportes

#### Elementos da Capa
- Logo da UnB (posicionado no topo)
- Título da dissertação/tese (centralizado, negrito, fonte grande)
- Nome do autor (centralizado, negrito)
- Tipo de documento: "DISSERTAÇÃO DE MESTRADO/TESE DE DOUTORADO EM TRANSPORTES"
- Orientador
- Número da publicação
- Local e data: "BRASÍLIA/DF: MÊS/ANO"

#### Formatação Específica
- Texto predominantemente em negrito e centralizado
- Hierarquia de tamanhos de fonte (28pt, 32pt para títulos)
- Espaçamento específico entre elementos
- Numeração romana para páginas pré-textuais

### Herança da Classe Base
A classe UnB-PPGT herda de `report` seguindo o padrão elegante da UnB-CIC, adaptando especificamente para o PPGT conforme o template Word oficial.

### Compatibilidade com Templates Existentes
O design mantém compatibilidade com comandos da UnB-CIC quando possível, facilitando migração de documentos existentes.

### Extensibilidade
A arquitetura permite adição futura de novos tipos de documento mantendo a identidade visual do PPGT.

### Performance
Otimizações para compilação rápida, especialmente importante durante a escrita do documento com recompilações frequentes.