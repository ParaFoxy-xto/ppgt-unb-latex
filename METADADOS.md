# Sistema de Metadados - UnB-PPGT

Este documento descreve o sistema de metadados implementado na classe LaTeX UnB-PPGT para dissertações e teses do Programa de Pós-Graduação em Transportes da UnB.

## Comandos Obrigatórios

### Título do Trabalho
```latex
\titulo{Título Principal do Trabalho}
\subtitulo{Subtítulo (opcional)}
```

### Autor
```latex
\autor{Prenome}{Sobrenome}
```

### Orientação
```latex
% Orientador (obrigatório)
\orientador{Prof. Dr. Nome do Orientador}{Instituição}

% Coorientador (opcional)
\coorientador{Prof. Dr. Nome do Coorientador}{Instituição}
```

### Coordenação do Programa
```latex
\coordenador{Prof. Dr. Nome do Coordenador}{Instituição}
```

### Data da Defesa
```latex
\datadefesa{dia}{mês}{ano}
% Exemplo: \datadefesa{15}{12}{2024}
```

## Comandos Opcionais

### Número da Publicação
```latex
\numeropublicacao{PPGT.TD-XXX/YYYY}
% Exemplo: \numeropublicacao{PPGT.TD-001/2024}
```

### Palavras-chave
```latex
\palavraschave{palavra1, palavra2, palavra3}
\keywords{keyword1, keyword2, keyword3}
```

### Informações Acadêmicas
```latex
\areaconcentracao{Nome da Área de Concentração}
\linhapesquisa{Nome da Linha de Pesquisa}
```

## Comandos com Gênero Explícito

Para casos onde é necessário especificar o gênero:

```latex
% Orientadores
\orientadorM{Prof. Dr. Nome}{Instituição}  % Masculino
\orientadorF{Prof.ª Dr.ª Nome}{Instituição}  % Feminino

% Coorientadores
\coorientadorM{Prof. Dr. Nome}{Instituição}  % Masculino
\coorientadorF{Prof.ª Dr.ª Nome}{Instituição}  % Feminino

% Coordenadores
\coordenadorM{Prof. Dr. Nome}{Instituição}  % Masculino
\coordenadorF{Prof.ª Dr.ª Nome}{Instituição}  % Feminino
```

## Sistema de Validação

A classe implementa um sistema de validação que verifica:

### Campos Obrigatórios (Erro de Compilação)
- Título do trabalho
- Autor
- Orientador
- Data de defesa
- Coordenador do programa

### Campos Recomendados (Aviso)
- Palavras-chave em português
- Keywords em inglês
- Número da publicação

## Exemplo Completo

```latex
\documentclass[mestrado]{UnB-PPGT}

% Metadados obrigatórios
\titulo{Análise de Sistemas de Transporte Urbano}
\autor{João}{Silva}
\orientador{Prof. Dr. Maria Santos}{Universidade de Brasília}
\coordenador{Prof. Dr. Ana Costa}{Universidade de Brasília}
\datadefesa{15}{12}{2024}

% Metadados opcionais
\numeropublicacao{PPGT.TD-001/2024}
\palavraschave{transporte, mobilidade, Brasília}
\keywords{transport, mobility, Brasília}

\begin{document}
% Conteúdo do documento
\end{document}
```

## Mensagens de Erro Comuns

### "Titulo nao definido"
Use `\titulo{Seu Título}` no preâmbulo.

### "Autor nao definido"
Use `\autor{Prenome}{Sobrenome}` no preâmbulo.

### "Orientador nao definido"
Use `\orientador{Nome}{Instituição}` no preâmbulo.

### "Data de defesa nao definida"
Use `\datadefesa{dia}{mes}{ano}` no preâmbulo.

### "Coordenador do programa nao definido"
Use `\coordenador{Nome}{Instituição}` no preâmbulo.

## Validação de Data

O sistema valida automaticamente:
- Dia entre 1 e 31
- Mês entre 1 e 12
- Ano maior que 1900

Os nomes dos meses são convertidos automaticamente para português nas páginas do documento.