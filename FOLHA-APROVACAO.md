# Sistema de Folha de Aprovação - PPGT UnB

## Visão Geral

O sistema de folha de aprovação foi implementado para atender aos requisitos do Programa de Pós-Graduação em Transportes da UnB, fornecendo uma interface simples e flexível para definir membros da banca examinadora e gerar automaticamente a folha de aprovação com espaços adequados para assinaturas.

## Funcionalidades Implementadas

### ✅ Requisitos Atendidos

- **Requisito 3.3**: Gera automaticamente a folha de aprovação com espaços para assinaturas da banca
- **Requisito 2.4**: Quando o usuário define membros da banca, cria automaticamente a folha de aprovação com as assinaturas

### 🔧 Características Técnicas

1. **Sistema para definir membros da banca**: Comandos flexíveis para diferentes tipos de membros
2. **Layout da folha de aprovação**: Design profissional seguindo padrões do PPGT
3. **Espaços para assinaturas**: Linhas adequadas com nome, função e instituição
4. **Formatação para diferentes números de membros**: Suporte automático para 3-5 membros

## Comandos Disponíveis

### Comandos Básicos

```latex
% Membro básico da banca (função: "Examinador")
\membrobanca{Prof. Dr. Nome Sobrenome}{Instituição}

% Orientador (obrigatório)
\orientador{Prof. Dr. Nome Sobrenome}{Instituição}

% Coorientador (opcional)
\coorientador{Prof. Dr. Nome Sobrenome}{Instituição}
```

### Comandos Específicos

```latex
% Examinador interno
\examinadorinterno{Prof. Dr. Nome Sobrenome}{Instituição}

% Examinador externo
\examinadorexterno{Prof. Dr. Nome Sobrenome}{Instituição}

% Membro com função específica
\membroespecial{Prof. Dr. Nome Sobrenome}{Instituição}{Função Específica}
```

## Exemplo de Uso

```latex
\documentclass[mestrado]{UnB-PPGT}

% Metadados básicos
\titulo{Título da Dissertação}
\autor{Nome}{Sobrenome}
\orientador{Prof. Dr. Orientador}{UnB}
\datadefesa{15}{12}{2024}
\coordenador{Prof. Dr. Coordenador}{UnB}

% Definindo a banca (mínimo 2 membros além do orientador)
\membrobanca{Prof. Dr. Primeiro Membro}{USP}
\membrobanca{Prof. Dr. Segundo Membro}{UFMG}

% Opcional: coorientador
\coorientador{Prof. Dr. Coorientador}{UFRJ}

% Opcional: membros específicos
\examinadorexterno{Prof. Dr. Externo}{UFSC}

\begin{document}
\maketitle  % Gera automaticamente a folha de aprovação
% ou use \folhaaprovacao diretamente
\end{document}
```

## Validações Implementadas

### Número Mínimo de Membros

- **Mestrado**: Mínimo 3 membros (orientador + 2 examinadores)
- **Doutorado**: Mínimo 5 membros (orientador + 4 examinadores)
- **Qualificação**: Mínimo 3 membros (orientador + 2 examinadores)

### Mensagens de Erro

O sistema fornece mensagens claras quando:
- Número insuficiente de membros da banca
- Campos obrigatórios não definidos
- Configurações inválidas

## Layout da Folha de Aprovação

A folha de aprovação gerada inclui:

1. **Cabeçalho**: Logo da UnB com hierarquia institucional do PPGT
2. **Título**: Título completo do trabalho
3. **Autor**: Nome do autor
4. **Texto explicativo**: Descrição do tipo de trabalho
5. **Data de aprovação**: Data formatada da defesa
6. **Banca examinadora**: Lista com espaços para assinaturas
   - Orientador (sempre primeiro)
   - Coorientador (se definido)
   - Membros da banca (em ordem de definição)
7. **Local e data**: Brasília/DF, data completa

## Estrutura das Assinaturas

Cada membro da banca tem:
- Linha para assinatura (8cm)
- Nome em negrito
- Função e instituição

Exemplo:
```
_________________________________
Prof. Dr. João Silva
Examinador Externo -- USP
```

## Compatibilidade

- ✅ Dissertações de mestrado
- ✅ Teses de doutorado  
- ✅ Documentos de qualificação
- ✅ Com e sem coorientador
- ✅ Diferentes números de membros (3-5)

## Arquivos de Teste

- `test-folha-aprovacao.tex`: Teste básico da funcionalidade
- `exemplo-folha-aprovacao.tex`: Exemplo completo de uso
- `test-banca-commands.tex`: Teste dos comandos da banca

## Implementação Técnica

### Estrutura Interna

- **Contador**: `membrobancacount` para controlar número de membros
- **Arrays**: Sistema de armazenamento para nome, instituição e função
- **Validação**: Verificação automática de requisitos mínimos
- **Layout**: Formatação profissional com espaçamentos adequados

### Comandos Internos

- `\@validarnumeromembrosbanca`: Validação de membros
- `\@linhaassinatura`: Geração de linha de assinatura
- `\@linhaassinaturaorientador`: Linha específica para orientador
- `\@textotipotrabalhoaprovacao`: Texto explicativo do trabalho

## Status da Implementação

- ✅ **Concluído**: Sistema para definir membros da banca
- ✅ **Concluído**: Layout da folha de aprovação
- ✅ **Concluído**: Espaços para assinaturas da banca  
- ✅ **Concluído**: Formatação para diferentes números de membros
- ✅ **Concluído**: Validação e mensagens de erro
- ✅ **Concluído**: Documentação e exemplos

## Próximos Passos

A implementação da tarefa 5 está completa. O sistema atende a todos os requisitos especificados e está pronto para uso.