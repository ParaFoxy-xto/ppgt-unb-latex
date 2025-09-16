# Requirements Document

## Introduction

Este documento especifica os requisitos para o desenvolvimento de um modelo LaTeX para dissertações e teses do Programa de Pós-Graduação em Transportes (PPGT) da Universidade de Brasília. O modelo deve seguir a estrutura definida no template Word oficial do PPGT e ser inspirado nos modelos LaTeX existentes da CIC UnB e FGA UnB, garantindo conformidade com as normas acadêmicas da UnB e especificidades do programa PPGT.

## Requirements

### Requirement 1

**User Story:** Como estudante do PPGT, eu quero um modelo LaTeX que siga exatamente a estrutura do template Word oficial, para que minha dissertação/tese esteja em conformidade com as normas do programa.

#### Acceptance Criteria

1. WHEN o usuário compila o documento THEN o sistema SHALL gerar um PDF que segue a estrutura visual e de conteúdo do template Word do PPGT
2. WHEN o usuário utiliza os comandos de metadados THEN o sistema SHALL posicionar as informações nas páginas corretas conforme o template Word
3. IF o documento for uma dissertação THEN o sistema SHALL aplicar as formatações específicas para mestrado
4. IF o documento for uma tese THEN o sistema SHALL aplicar as formatações específicas para doutorado

### Requirement 2

**User Story:** Como estudante do PPGT, eu quero comandos simples para definir informações do trabalho (título, autor, orientador, etc.), para que eu possa configurar facilmente os metadados da minha dissertação/tese.

#### Acceptance Criteria

1. WHEN o usuário define o título THEN o sistema SHALL exibir o título na capa, folha de rosto e outras páginas conforme necessário
2. WHEN o usuário define autor, orientador e coorientador THEN o sistema SHALL posicionar essas informações corretamente em todas as páginas relevantes
3. WHEN o usuário define a data de defesa THEN o sistema SHALL formatar e exibir a data conforme o padrão do PPGT
4. WHEN o usuário define membros da banca THEN o sistema SHALL criar automaticamente a folha de aprovação com as assinaturas

### Requirement 3

**User Story:** Como estudante do PPGT, eu quero que o modelo gere automaticamente todas as páginas pré-textuais obrigatórias, para que eu não precise me preocupar com a formatação manual dessas seções.

#### Acceptance Criteria

1. WHEN o usuário compila o documento THEN o sistema SHALL gerar automaticamente a capa oficial do PPGT
2. WHEN o usuário compila o documento THEN o sistema SHALL gerar a folha de rosto com as informações corretas
3. WHEN o usuário compila o documento THEN o sistema SHALL gerar a folha de aprovação com espaços para assinaturas da banca
4. WHEN o usuário compila o documento THEN o sistema SHALL gerar a ficha catalográfica com os dados bibliográficos
5. WHEN o usuário inclui dedicatória, agradecimentos, resumo e abstract THEN o sistema SHALL formatá-los conforme as normas

### Requirement 4

**User Story:** Como estudante do PPGT, eu quero que o modelo formate automaticamente listas (figuras, tabelas, siglas), para que essas seções sigam o padrão visual do programa.

#### Acceptance Criteria

1. WHEN o documento contém figuras THEN o sistema SHALL gerar automaticamente a lista de figuras
2. WHEN o documento contém tabelas THEN o sistema SHALL gerar automaticamente a lista de tabelas
3. WHEN o usuário define siglas e abreviações THEN o sistema SHALL gerar automaticamente a lista de siglas
4. WHEN as listas são geradas THEN o sistema SHALL aplicar a formatação específica do PPGT

### Requirement 5

**User Story:** Como estudante do PPGT, eu quero comandos específicos para elementos comuns em trabalhos de transportes (equações, figuras, tabelas, referências), para que eu possa inserir facilmente esses elementos com a formatação correta.

#### Acceptance Criteria

1. WHEN o usuário insere uma figura THEN o sistema SHALL aplicar a formatação padrão do PPGT para figuras
2. WHEN o usuário insere uma tabela THEN o sistema SHALL aplicar a formatação padrão do PPGT para tabelas
3. WHEN o usuário insere uma equação THEN o sistema SHALL numerá-la e formatá-la conforme as normas
4. WHEN o usuário faz referências cruzadas THEN o sistema SHALL criar links corretos e formatação adequada

### Requirement 6

**User Story:** Como estudante do PPGT, eu quero que o modelo seja compatível com diferentes tipos de trabalho (dissertação de mestrado, tese de doutorado, qualificação), para que eu possa usar o mesmo template em diferentes fases do programa.

#### Acceptance Criteria

1. WHEN o usuário especifica o tipo como dissertação THEN o sistema SHALL aplicar terminologia e formatação específica para mestrado
2. WHEN o usuário especifica o tipo como tese THEN o sistema SHALL aplicar terminologia e formatação específica para doutorado
3. WHEN o usuário especifica qualificação THEN o sistema SHALL omitir páginas não necessárias para qualificação
4. WHEN o tipo é alterado THEN o sistema SHALL ajustar automaticamente todas as referências textuais relevantes

### Requirement 7

**User Story:** Como estudante do PPGT, eu quero que o modelo inclua a identidade visual oficial do programa, para que meu trabalho tenha a apresentação institucional adequada.

#### Acceptance Criteria

1. WHEN o documento é compilado THEN o sistema SHALL incluir o logotipo oficial da UnB na posição correta
2. WHEN o documento é compilado THEN o sistema SHALL usar as cores institucionais conforme especificado
3. WHEN o documento é compilado THEN o sistema SHALL incluir as informações institucionais corretas do PPGT
4. WHEN o documento é compilado THEN o sistema SHALL manter a hierarquia visual: UnB > Faculdade > PPGT

### Requirement 8

**User Story:** Como estudante do PPGT, eu quero que o modelo seja fácil de usar e bem documentado, para que eu possa utilizá-lo sem conhecimento avançado de LaTeX.

#### Acceptance Criteria

1. WHEN o usuário acessa a documentação THEN o sistema SHALL fornecer exemplos claros de uso de todos os comandos
2. WHEN o usuário utiliza o template THEN o sistema SHALL incluir comentários explicativos no código
3. WHEN o usuário comete erros comuns THEN o sistema SHALL fornecer mensagens de erro claras e sugestões
4. WHEN o usuário precisa de ajuda THEN o sistema SHALL incluir um arquivo README com instruções completas