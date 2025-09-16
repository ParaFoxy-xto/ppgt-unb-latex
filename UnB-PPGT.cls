\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{UnB-PPGT}[2024/01/01 Classe para trabalhos PPGT UnB]

%%
%% --- Contextualização do programa ---
%%

\def\@departamento{Departamento de Engenharia Civil e Ambiental}
\def\@faculdade{Faculdade de Tecnologia}
\def\@programa{Programa de P\'{o}s-Gradua\c{c}\~{a}o em Transportes}
\def\@universidade{Universidade de Bras\'{\i}lia}
\def\@siglauni{UnB}
\def\@cidade{Bras\'ilia}
\def\@uf{DF}
\def\@cidadeuf{\@cidade/\@uf}
\def\@pais{Brasil}

%%
%% --- Definição de opções ---
%%
\RequirePackage{xkeyval}

% Espaçamento de linhas
\newif\if@singlespacing
\newif\if@onehalfspacing
\newif\if@baselineskip
\DeclareOptionX{singlespacing}{\@singlespacingtrue \@onehalfspacingfalse}
\DeclareOptionX{onehalfspacing}{\@onehalfspacingtrue \@singlespacingfalse}
\DeclareOptionX{doublespacing}{\@singlespacingfalse \@onehalfspacingfalse}
\DeclareOptionX{baselineskip}{\@baselineskiptrue}

% Opções de tipo de documento
\newif\if@mestrado\@mestradofalse
\newif\if@doutorado\@doutoradofalse
\newif\if@qualificacao\@qualificacaofalse

\DeclareOptionX{mestrado}{\@mestradotrue%
    \gdef\@tipodocumento{Disserta\c{c}\~ao}%
    \gdef\@graudocumento{DISSERTA\c{C}\~AO DE MESTRADO EM TRANSPORTES}%
    \gdef\@assunto{Disserta\c{c}\~ao (Mestrado em Transportes)}}%

\DeclareOptionX{doutorado}{\@doutoradotrue%
    \gdef\@tipodocumento{Tese}%
    \gdef\@graudocumento{TESE DE DOUTORADO EM TRANSPORTES}%
    \gdef\@assunto{Tese (Doutorado em Transportes)}}%

\DeclareOptionX{qualificacao}{\@qualificacaotrue}%

% Modo de geração do PDF
\newif\if@ForScreenView
\newif\if@LoadHyperref
\DeclareOptionX{impressao}{\@ForScreenViewfalse\@LoadHyperreffalse}
\DeclareOptionX{hyperref}[load]{\@ForScreenViewtrue%
	\def\@tempa{#1}\def\@tempb{load}\def\@tempc{config}%
	\ifx\@tempa\@tempb\@LoadHyperreftrue%
	\else%
		\ifx\@tempa\@tempc\@LoadHyperreffalse%
		\else
			\ClassError{UnB-PPGT}
				{Valor invalido para opcao hyperref: #1}
				{Valores validos: hyperref,hyperref=load,hyperref=config}
		\fi
	\fi%
}

% Fontes
\def\fontelogo{\@ifundefined{XeTeXversion}{ua1}{Arial}}
\DeclareOptionX{10pt}{\gdef\@fontsize{10pt}}
\DeclareOptionX{11pt}{\gdef\@fontsize{11pt}}
\DeclareOptionX{12pt}{\gdef\@fontsize{12pt}}

% Estilos das páginas
\DeclareOptionX{prestyle}{\gdef\style@pretextual{#1}}
\DeclareOptionX{textstyle}{\gdef\style@textual{#1}}
\DeclareOptionX{chapstyle}{\gdef\style@chapter{#1}}

% Rascunho (draft)
\newif\if@draftthesis
\DeclareOptionX{draft}{\@draftthesistrue}

%%
%% --- Processamento de opções e classe-base ---
%%

% Repassa opções desconhecidas
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{report}}

% Opções padrão
\ExecuteOptionsX{onehalfspacing,hyperref,prestyle=plain,textstyle=plain,chapstyle=plain,mestrado}
\ProcessOptionsX\relax

\newcommand{\ifhyperref}[2]{\if@ForScreenView #1\else #2\fi}

% Define macro apenas se estiver indefinida
\def\@defifundef#1#2{\begingroup\expandafter\ifx\csname #1\endcsname\relax%
\expandafter\gdef\csname #1\endcsname{#2}
\fi\endgroup}

\if@draftthesis
	\PassOptionsToPackage{headheight=13pt,margin={2cm,1.5cm}}{geometry}
    \@singlespacingfalse \@onehalfspacingtrue % força onehalfspacing
    \@defifundef{@fontsize}{11pt}
\else
	\PassOptionsToPackage{headheight=15pt,vmargin={3cm,2cm}}{geometry}
	\if@ForScreenView
	\PassOptionsToPackage{hmargin={2.5cm,2.5cm}}{geometry}
    \else
	\PassOptionsToPackage{hmargin={3cm,2cm}}{geometry}
    \fi%
    \@defifundef{@fontsize}{12pt}
\fi

\LoadClass[\@fontsize]{report}

%%
%% --- Pacotes requeridos ---
%%

\RequirePackage[brazil,american]{babel}% Idiomas
\RequirePackage[fixlanguage]{babelbib}%  Idioma das referências
\RequirePackage[utf8]{inputenc}%         Arquivos na codificação UTF-8
\RequirePackage[T1]{fontenc}%            Habilita busca com caracteres latinos
\RequirePackage{lmodern}%                Habilita busca com caracteres latinos
\RequirePackage{amsmath}%				 Ambiente para equações
\RequirePackage{xcolor}% 				 Necessário para algum pacote não identificado
\RequirePackage[figure,table]{totalcount}%

\@ifundefined{XeTeXversion}{%
	\PassOptionsToPackage{pdftex}{hyperref}
	\RequirePackage{fixltx2e} % resolve defeitos do LaTeX
	\RequirePackage{relsize} % utilizada no \@logo
	\def\@textscale#1#2{\textscale{#1}{#2}}
}{
	\PassOptionsToPackage{xetex}{hyperref}
	\def\@textscale#1#2{{\addfontfeatures{Scale=#1}#2}}
}%

\RequirePackage{graphicx}\graphicspath{{.}{img/}}%
\RequirePackage{boites}
\RequirePackage[a4paper,includefoot]{geometry}
\RequirePackage{fancyhdr}% Para controle de cabeçalhos e rodapés

\if@baselineskip\else
	% define o espaçamento pelo setspace
	\RequirePackage{setspace}
\fi

\PassOptionsToPackage{pdfdisplaydoctitle=true,pagebackref,linktocpage=true}{hyperref}%

\if@LoadHyperref
	\RequirePackage[hidelinks]{hyperref}%
\fi

\usepackage[acronym,nonumberlist]{glossaries}% Após o hyperref!
\makeglossaries%

% Using tocloft for TOC formatting instead of tocstyle
\RequirePackage{tocloft}% More widely available than tocstyle

%%
%% --- Configuração específica do PPGT para formatação de listas ---
%%

% Configurações para lista de figuras
\renewcommand{\cftfigpresnum}{Figura }% Prefixo "Figura" antes do número
\renewcommand{\cftfigaftersnum}{:}% Dois pontos após o número
\setlength{\cftfignumwidth}{6em}% Largura do campo do número
\renewcommand{\cftfigfont}{\normalfont}% Fonte normal para entradas
\renewcommand{\cftfigpagefont}{\normalfont}% Fonte normal para números de página
\renewcommand{\cftfigdotsep}{\cftdotsep}% Pontos de preenchimento

% Configurações para lista de tabelas
\renewcommand{\cfttabpresnum}{Tabela }% Prefixo "Tabela" antes do número
\renewcommand{\cfttabaftersnum}{:}% Dois pontos após o número
\setlength{\cfttabnumwidth}{6em}% Largura do campo do número
\renewcommand{\cfttabfont}{\normalfont}% Fonte normal para entradas
\renewcommand{\cfttabpagefont}{\normalfont}% Fonte normal para números de página
\renewcommand{\cfttabdotsep}{\cftdotsep}% Pontos de preenchimento

% Configurações gerais para melhor aparência das listas
\setlength{\cftbeforefigskip}{0.5em}% Espaçamento antes de cada entrada de figura
\setlength{\cftbeforetabskip}{0.5em}% Espaçamento antes de cada entrada de tabela

% Configuração para títulos das listas (centralizados como capítulos)
\renewcommand{\cftloftitlefont}{\hfill\Huge\bfseries}% Título da lista de figuras
\renewcommand{\cftafterloftitle}{\hfill}% Centraliza título da lista de figuras
\renewcommand{\cftlottitlefont}{\hfill\Huge\bfseries}% Título da lista de tabelas
\renewcommand{\cftafterlottitle}{\hfill}% Centraliza título da lista de tabelas

%%
%% --- Configuração específica do sumário (TOC) ---
%%

% Configuração do título do sumário
\renewcommand{\cfttoctitlefont}{\hfill\Huge\bfseries}% Título centralizado e em negrito
\renewcommand{\cftaftertoctitle}{\hfill}% Centraliza título do sumário

% Configuração de formatação de capítulos no sumário
\renewcommand{\cftchapfont}{\bfseries}% Capítulos em negrito
\renewcommand{\cftchappagefont}{\bfseries}% Números de página dos capítulos em negrito
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}% Pontos de preenchimento para capítulos

% Configuração de formatação de seções no sumário
\renewcommand{\cftsecfont}{\normalfont}% Seções em fonte normal
\renewcommand{\cftsecpagefont}{\normalfont}% Números de página das seções em fonte normal
\setlength{\cftsecindent}{1.5em}% Indentação das seções
\setlength{\cftsecnumwidth}{2.3em}% Largura do campo do número das seções

% Configuração de formatação de subseções no sumário
\renewcommand{\cftsubsecfont}{\normalfont}% Subseções em fonte normal
\renewcommand{\cftsubsecpagefont}{\normalfont}% Números de página das subseções em fonte normal
\setlength{\cftsubsecindent}{3.8em}% Indentação das subseções
\setlength{\cftsubsecnumwidth}{3.2em}% Largura do campo do número das subseções

% Configuração de formatação de subsubseções no sumário
\renewcommand{\cftsubsubsecfont}{\normalfont}% Subsubseções em fonte normal
\renewcommand{\cftsubsubsecpagefont}{\normalfont}% Números de página das subsubseções em fonte normal
\setlength{\cftsubsubsecindent}{7.0em}% Indentação das subsubseções
\setlength{\cftsubsubsecnumwidth}{4.1em}% Largura do campo do número das subsubseções

% Espaçamento entre entradas do sumário
\setlength{\cftbeforechapskip}{0.5em}% Espaçamento antes de cada capítulo
\setlength{\cftbeforesecskip}{0.2em}% Espaçamento antes de cada seção
\setlength{\cftbeforesubsecskip}{0.1em}% Espaçamento antes de cada subseção

% Para gerar o label {TotPaginas}
\RequirePackage{atbegshi}
\newcounter{TotPaginas}

%%
%% --- Configuração de estilos de página e numeração ---
%%

% Configuração do estilo de página para seções pré-textuais
\newcommand{\@configurarpaginaspretextuais}{%
	% Numeração romana centralizada no rodapé
	\fancypagestyle{\style@pretextual}{%
		\fancyhf{}% Limpa cabeçalho e rodapé
		\fancyfoot[C]{\thepage}% Número da página centralizado no rodapé
		\renewcommand{\headrulewidth}{0pt}% Remove linha do cabeçalho
		\renewcommand{\footrulewidth}{0pt}% Remove linha do rodapé
	}
}

% Configuração do estilo de página para seções textuais
\newcommand{\@configurarpaginastextuais}{%
	% Numeração arábica no canto superior direito
	\fancypagestyle{\style@textual}{%
		\fancyhf{}% Limpa cabeçalho e rodapé
		\fancyhead[R]{\thepage}% Número da página no canto superior direito
		\renewcommand{\headrulewidth}{0pt}% Remove linha do cabeçalho
		\renewcommand{\footrulewidth}{0pt}% Remove linha do rodapé
	}
}

% Configuração do estilo de página para capítulos
\newcommand{\@configurarpaginascapitulos}{%
	% Primeira página de capítulo com numeração centralizada no rodapé
	\fancypagestyle{\style@chapter}{%
		\fancyhf{}% Limpa cabeçalho e rodapé
		\fancyfoot[C]{\thepage}% Número da página centralizado no rodapé
		\renewcommand{\headrulewidth}{0pt}% Remove linha do cabeçalho
		\renewcommand{\footrulewidth}{0pt}% Remove linha do rodapé
	}
}

% Aplicação automática dos estilos de página
\@ifundefined{fancyhf}{%
	% Se fancyhdr não estiver carregado, usa estilos simples
	\newcommand{\@pagestyle}[1]{\pagestyle{#1}}
}{%
	% Se fancyhdr estiver disponível, configura estilos personalizados
	\RequirePackage{fancyhdr}
	\@configurarpaginaspretextuais
	\@configurarpaginastextuais
	\@configurarpaginascapitulos
	\newcommand{\@pagestyle}[1]{\pagestyle{#1}}
}

%%
%% --- Adaptação da classe-base ---
%%
\newcommand{\chapterformat}{%formatação de título de capítulos
\Huge \bfseries
}

\newcommand{\chapteralign}{%alinhamento de título de capítulos
	\ClassError{UnB-PPGT}
			{Comando \protect\pretextual\space nao foi chamado}
			{Nao pode haver titulos antes do comando \protect\pretextual}
}

% Suporte para alinhamento e formatação configurável
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \chapteralign \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \chapterformat #1\par\nobreak
    \vskip 40\p@
  }}

\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \chapteralign
    \normalfont
    \interlinepenalty\@M
    \chapterformat  #1\par\nobreak
    \vskip 40\p@
  }}

% Tira \MakeUppercase forçado nos cabeçalhos
\let\old@MakeUppercase\MakeUppercase
\let\old@markboth\markboth
\def\markboth#1#2{\def\MakeUppercase##1{##1}\old@markboth{#1}{#2}\let\MakeUppercase\old@MakeUppercase}
\let\old@markright\markright
\def\markright#1{\def\MakeUppercase##1{##1}\old@markright{#1}\let\MakeUppercase\old@MakeUppercase}

% Evita órfãs/viúvas e quebras de nota de rodapé
\clubpenalty=9999
\widowpenalty=9999
\interfootnotelinepenalty=5000
\raggedbottom

%%
%% --- Configurações de formatação de listas e parágrafos ---
%%

% Aproxima itens de lista conforme padrão PPGT
\def\changeitemsep{\setlength{\itemsep}{.5\itemsep}}
\let\old@enumerate=\enumerate
\def\enumerate{\old@enumerate%
\changeitemsep}
\let\old@itemize=\itemize
\def\itemize{\old@itemize%
\changeitemsep}

% Configuração de indentação de parágrafos
\setlength{\parindent}{1.25cm}% Indentação padrão de 1,25cm conforme ABNT

% Configuração de espaçamento entre parágrafos
\setlength{\parskip}{0pt}% Sem espaço extra entre parágrafos (padrão ABNT)

% Configuração de alinhamento de texto
\raggedright% Texto justificado (padrão para trabalhos acadêmicos)
\hyphenpenalty=5000% Reduz hifenização excessiva
\tolerance=1000% Melhora quebra de linhas

% Espaçamento entre linhas de verse, quote e quotation
% deve ser simples e com fonte menor
\let\old@quote\quote
\let\old@endquote\endquote
\renewenvironment*{quote}
	{\old@quote\begin{singlespace}\small}
	{\end{singlespace}\old@endquote}

\let\old@quotation\quotation
\let\old@endquotation\endquotation
\renewenvironment*{quotation}
	{\old@quotation\begin{singlespace}\small}
	{\end{singlespace}\old@endquotation}

\let\old@verse\verse
\let\old@endverse\endverse
\renewenvironment*{verse}
	{\old@verse\begin{singlespace}\small}
	{\end{singlespace}\old@endverse}

% Novo ambiente definition
\newcommand{\definitioname}{Defini\c{c}\~ao}
\newcounter{definition}
\newenvironment{definition}
	{\refstepcounter{definition}%
	\let\old@fboxsep\fboxsep\setlength{\fboxsep}{1em}%
	\vskip.5\fboxsep\breakbox%
	\noindent\textbf{\definitioname~\arabic{definition}\ \ }}
	{\endbreakbox\vskip.5\fboxsep%
	\setlength{\fboxsep}{\old@fboxsep}}

% Table figures automáticas no ambiente #1
\newcommand{\SetTableFigures}[1]{
	\expandafter\let\csname old@#1\expandafter\endcsname\csname #1\endcsname
	\expandafter\let\csname old@end#1\expandafter\endcsname\csname end#1\endcsname
	\renewenvironment{#1}
	{\begingroup\@tablefigures\csname old@#1\endcsname}
	{\csname old@end#1\endcsname\endgroup}
}

% Adiciona item ao sumario
\def\addtocchapter#1{
	\cleardoublepage
	\phantomsection % ajusta referencia hyperref
	\addcontentsline{toc}{chapter}{#1}
}

% Configura a seção de referências
\expandafter\let\expandafter\@bibliography\csname bibliography\endcsname%
\renewcommand{\bibliography}[1]{%
	% renomeia a seção após influência maligna do Babel
	\renewcommand*{\bibname}
		{\@ifundefined{XeTeXversion}{Refer\^encias}{Referências}}
	\addtocchapter{\bibname}
	\singlespacing\@bibliography{#1}\defaultspacing}

% Maketitle para gerar as páginas iniciais
\def\maketitle{%
	\gdef\@maketitlecalled{true}% Marca que maketitle foi chamado
	\if@ForScreenView\relax\else\capa\fi
	\pretextual\folharosto%
    \if@mestrado%
		\if@qualificacao%
		\else%
			\newpage\thispagestyle{empty}%
			\fichacatalografica%
			\clearpage%
		\fi%
	\fi%
	\if@doutorado%
		\if@qualificacao%
		\else%
			\newpage\thispagestyle{empty}%
			\fichacatalografica%
			\clearpage%
		\fi%
	\fi%
	\newpage\folhaaprovacao%
}

% Suporte hyperref para anexos
\ifhyperref{%
	\def\Hy@annexstring{annex}
	\let\HyOrg@anexos\anexos
	\def\anexos{%
		\gdef\theHchapter{\Roman{chapter}}%
		\xdef\Hy@chapapp{\Hy@annexstring}%
		\HyOrg@anexos
	}
}{}

%%
%% --- Sistema de tratamento de erros e validação ---
%%

% Contadores para controle de validação
\newif\if@validacaoativada\@validacaoativadatrue
\newif\if@errosencontrados\@errosencontradosfalse

% Comando para desabilitar validação (uso avançado)
\newcommand{\desabilitarvalidacao}{\@validacaoativadafalse}
\newcommand{\habilitarvalidacao}{\@validacaoativadatrue}

% Sistema de mensagens de erro padronizadas
\newcommand{\@erroppgt}[3]{%
	\ClassError{UnB-PPGT}{#1}{#2}%
	\@errosencontradostrue%
	\if@draftthesis%
		\typeout{PPGT WARNING: #3}%
	\fi%
}

\newcommand{\@warningppgt}[2]{%
	\ClassWarning{UnB-PPGT}{#1}%
	\if@draftthesis%
		\typeout{PPGT INFO: #2}%
	\fi%
}

% Validação de campos obrigatórios
\newcommand{\@validarcampoobrigatorio}[3]{%
	\if@validacaoativada%
		\@ifundefined{#1}{%
			\@erroppgt{Campo obrigatorio nao definido: #2}%
				{Use o comando \protect#3 para definir #2}%
				{Campo #2 nao foi definido - documento pode nao compilar corretamente}%
		}{}%
	\fi%
}

% Validação de campos condicionais
\newcommand{\@validarcampocondicional}[4]{%
	\if@validacaoativada%
		#1{%
			\@ifundefined{#2}{%
				\@erroppgt{Campo obrigatorio para este tipo de documento: #3}%
					{Use o comando \protect#4 para definir #3}%
					{Campo #3 e obrigatorio para este tipo de documento}%
			}{}%
		}{}%
	\fi%
}

% Validação de formato de data
\newcommand{\@validardata}[3]{%
	\if@validacaoativada%
		\ifnum#1<1\relax%
			\@erroppgt{Dia invalido: #1}%
				{O dia deve ser um numero entre 1 e 31}%
				{Data com dia invalido pode causar problemas na formatacao}%
		\fi%
		\ifnum#1>31\relax%
			\@erroppgt{Dia invalido: #1}%
				{O dia deve ser um numero entre 1 e 31}%
				{Data com dia invalido pode causar problemas na formatacao}%
		\fi%
		\ifnum#2<1\relax%
			\@erroppgt{Mes invalido: #2}%
				{O mes deve ser um numero entre 1 e 12}%
				{Data com mes invalido pode causar problemas na formatacao}%
		\fi%
		\ifnum#2>12\relax%
			\@erroppgt{Mes invalido: #2}%
				{O mes deve ser um numero entre 1 e 12}%
				{Data com mes invalido pode causar problemas na formatacao}%
		\fi%
		\ifnum#3<1900\relax%
			\@erroppgt{Ano invalido: #3}%
				{O ano deve ser maior que 1900}%
				{Data com ano invalido pode causar problemas na formatacao}%
		\fi%
	\fi%
}

% Validação de número mínimo de membros da banca
\newcommand{\@validarbanca}{%
	\if@validacaoativada%
		\ifnum\value{membrobanca}<3\relax%
			\@erroppgt{Numero insuficiente de membros da banca: \themembrobanca}%
				{Uma banca deve ter pelo menos 3 membros. Use \protect\membrobanca para adicionar mais membros}%
				{Banca com menos de 3 membros pode nao atender aos requisitos institucionais}%
		\fi%
	\fi%
}

% Verificação de compatibilidade de pacotes
\newcommand{\@verificarcompatibilidade}{%
	% Verifica conflitos conhecidos com hyperref
	\@ifpackageloaded{hyperref}{%
		\@ifpackageloaded{bookmark}{}{%
			\@warningppgt{Pacote bookmark nao carregado}%
				{Considere carregar o pacote bookmark para melhor compatibilidade com hyperref}%
		}%
	}{}%
	
	% Verifica se babel está carregado corretamente
	\@ifpackageloaded{babel}{}{%
		\@warningppgt{Pacote babel nao detectado}%
			{O pacote babel e recomendado para formatacao correta de texto em portugues}%
	}%
	
	% Verifica compatibilidade com XeTeX/LuaTeX
	\@ifundefined{XeTeXversion}{%
		\@ifundefined{luatexversion}{%
			% pdfTeX - configuração padrão
		}{%
			% LuaTeX detectado
			\@warningppgt{LuaTeX detectado}%
				{Algumas funcionalidades podem ter comportamento diferente com LuaTeX}%
		}%
	}{%
		% XeTeX detectado
		\@warningppgt{XeTeX detectado}%
			{Algumas funcionalidades podem ter comportamento diferente com XeTeX}%
	}%
	
	% Verifica se setspace está disponível quando necessário
	\if@baselineskip\else%
		\@ifpackageloaded{setspace}{}{%
			\@erroppgt{Pacote setspace nao encontrado}%
				{O pacote setspace e necessario para controle de espacamento. Instale-o ou use a opcao baselineskip}%
				{Sem setspace, o espacamento entre linhas pode nao funcionar corretamente}%
		}%
	\fi%
}

% Sistema de fallbacks para recursos não disponíveis
\newcommand{\@configurarfallbacks}{%
	% Fallback para textlinf (lining figures)
	\@ifundefined{textlinf}{%
		\newcommand{\textlinf}[1]{#1}%
		\@warningppgt{Comando textlinf nao disponivel}%
			{Usando numeracao normal em vez de lining figures}%
	}{}%
	
	% Fallback para fonte Arial/URW Arial
	\@ifundefined{XeTeXversion}{%
		% pdfTeX - verifica se ua1 está disponível
		\IfFileExists{ua1lmr.fd}{}{%
			\@warningppgt{Fonte URW Arial nao encontrada}%
				{Usando fonte padrao do sistema para logos}%
			\renewcommand{\fontelogo}{cmr}%
		}%
	}{%
		% XeTeX/LuaTeX - assume que Arial está disponível ou usa fallback
		\@warningppgt{XeTeX/LuaTeX detectado}%
			{Usando fonte Arial se disponivel, caso contrario fonte padrao}%
		% Para XeTeX/LuaTeX, tentamos usar Arial mas com fallback
		\renewcommand{\fontelogo}{Arial}%
	}%
	
	% Fallback para imagens de logo
	\IfFileExists{img/positivo_cor.png}{}{%
		\IfFileExists{img/positivo_cor.pdf}{}{%
			\@warningppgt{Logo da UnB nao encontrado}%
				{Usando placeholder para logo. Adicione o arquivo img/positivo_cor.png ou img/positivo_cor.pdf}%
		}%
	}%
	
	% Fallback para glossaries
	\@ifpackageloaded{glossaries}{}{%
		\@warningppgt{Pacote glossaries nao carregado}%
			{Lista de siglas pode nao funcionar corretamente}%
		% Define comandos básicos para evitar erros
		\providecommand{\makeglossaries}{}%
		\providecommand{\printglossaries}{}%
		\providecommand{\gls}[1]{#1}%
		\providecommand{\newacronym}[3]{}%
	}%
	
	% Fallback para tocloft (caso não esteja disponível)
	\@ifpackageloaded{tocloft}{}{%
		\@warningppgt{Pacote tocloft nao carregado}%
			{Formatacao de listas pode nao funcionar corretamente}%
		% Define comandos básicos para evitar erros
		\providecommand{\cftfigpresnum}[1]{}%
		\providecommand{\cftfigaftersnum}[1]{}%
		\providecommand{\cfttabpresnum}[1]{}%
		\providecommand{\cfttabaftersnum}[1]{}%
	}%
	
	% Fallback para geometry
	\@ifpackageloaded{geometry}{}{%
		\@erroppgt{Pacote geometry nao carregado}%
			{O pacote geometry e essencial para configuracao de margens}%
			{Sem geometry, as margens podem nao estar corretas}%
	}%
	
	% Fallback para graphicx
	\@ifpackageloaded{graphicx}{}{%
		\@erroppgt{Pacote graphicx nao carregado}%
			{O pacote graphicx e essencial para inclusao de imagens}%
			{Sem graphicx, logos e figuras nao funcionarao}%
	}%
	
	% Fallback para fancyhdr
	\@ifpackageloaded{fancyhdr}{}{%
		\@warningppgt{Pacote fancyhdr nao carregado}%
			{Cabecalhos e rodapes podem nao funcionar corretamente}%
		% Define comandos básicos para evitar erros
		\providecommand{\fancyhf}{}%
		\providecommand{\fancyhead}[1]{}%
		\providecommand{\fancyfoot}[1]{}%
		\providecommand{\fancypagestyle}[2]{}%
	}%
	
	% Fallback para inputenc (importante para caracteres especiais)
	\@ifpackageloaded{inputenc}{}{%
		\@warningppgt{Pacote inputenc nao carregado}%
			{Caracteres especiais podem nao funcionar corretamente}%
	}%
	
	% Fallback para babel
	\@ifpackageloaded{babel}{}{%
		\@warningppgt{Pacote babel nao carregado}%
			{Hifenizacao e formatacao de texto em portugues podem nao funcionar}%
		% Define comandos básicos
		\providecommand{\selectlanguage}[1]{}%
	}%
}

% Validação de versão do LaTeX
\newcommand{\@validarversaolatex}{%
	\@ifl@t@r\fmtversion{2020/10/01}{}{%
		\@warningppgt{Versao antiga do LaTeX detectada}%
			{Algumas funcionalidades podem nao funcionar corretamente. Considere atualizar sua distribuicao LaTeX}%
	}%
}

% Validação de distribuição LaTeX
\newcommand{\@validardistribuicao}{%
	% Detecta TeX Live
	\IfFileExists{/usr/local/texlive/texmf-local/tex/latex/base/latex.ltx}{%
		\@warningppgt{TeX Live detectado}%
			{Distribuicao compativel detectada}%
	}{%
		% Detecta MiKTeX
		\IfFileExists{miktex.exe}{%
			\@warningppgt{MiKTeX detectado}%
				{Distribuicao compativel detectada}%
		}{%
			\@warningppgt{Distribuicao LaTeX nao identificada}%
				{Certifique-se de que todos os pacotes necessarios estao instalados}%
		}%
	}%
}

% Sistema de diagnóstico completo
\newcommand{\@diagnosticoppgt}{%
	\if@validacaoativada%
		\typeout{=== DIAGNOSTICO UnB-PPGT ===}%
		\typeout{Versao da classe: 2024/01/01}%
		\typeout{Tipo de documento: \@tipodocumento}%
		\typeout{Compilador: \@ifundefined{XeTeXversion}{\@ifundefined{luatexversion}{pdfTeX}{LuaTeX}}{XeTeX}}%
		\typeout{Modo: \if@ForScreenView digital\else impressao\fi}%
		\typeout{Espacamento: \if@singlespacing simples\else\if@onehalfspacing 1,5\else duplo\fi\fi}%
		\typeout{Validacao: \if@validacaoativada ativa\else desabilitada\fi}%
		\typeout{===============================}%
	\fi%
}

% Validação completa executada no início do documento
\AtBeginDocument{%
	\@diagnosticoppgt%
	\@validarversaolatex%
	\@validardistribuicao%
	\@verificarcompatibilidade%
	\@configurarfallbacks%
	
	% Validação de campos obrigatórios básicos
	\@validarcampoobrigatorio{@titulodefinido}{titulo}{\titulo}%
	\@validarcampoobrigatorio{@autordefinido}{autor}{\autor}%
	\@validarcampoobrigatorio{@orientadordefinido}{orientador}{\orientador}%
	
	% Validação de campos condicionais por tipo de documento
	\@validarcampocondicional{\if@mestrado}{@graudocumento}{tipo de documento para mestrado}{\DeclareOptionX{mestrado}}%
	\@validarcampocondicional{\if@doutorado}{@graudocumento}{tipo de documento para doutorado}{\DeclareOptionX{doutorado}}%
	
	% Validação de data se definida
	\@ifundefined{@dia}{}{%
		\@ifundefined{@mes}{}{%
			\@ifundefined{@ano}{}{%
				\@validardata{\@dia}{\@mes}{\@ano}%
			}%
		}%
	}%
	
	% Validação da banca se não for qualificação
	\if@qualificacao\else%
		\ifnum\value{membrobancacount}<2\relax%
			\@erroppgt{Numero insuficiente de membros da banca: \themembrobancacount}%
				{Uma banca deve ter pelo menos 3 membros. Use \protect\membrobanca para adicionar mais membros}%
				{Banca com menos de 3 membros pode nao atender aos requisitos institucionais}%
		\fi%
	\fi%
	
	% Relatório final de validação
	\if@errosencontrados%
		\@erroppgt{Erros de validacao encontrados}%
			{Corrija os erros listados acima antes de continuar}%
			{Documento pode nao compilar corretamente devido aos erros encontrados}%
	\fi%
}

% Validação final executada no fim do documento
\AtEndDocument{%
	\if@validacaoativada%
		\typeout{=== VALIDACAO FINAL UnB-PPGT ===}%
		
		% Verifica se todas as páginas obrigatórias foram geradas
		\@ifundefined{@titulodefinido}{%
			\typeout{ERRO FINAL: Titulo nao foi definido}%
		}{}%
		
		\@ifundefined{@autordefinido}{%
			\typeout{ERRO FINAL: Autor nao foi definido}%
		}{}%
		
		\@ifundefined{@orientadordefinido}{%
			\typeout{ERRO FINAL: Orientador nao foi definido}%
		}{}%
		
		% Verifica se maketitle foi chamado
		\@ifundefined{@maketitlecalled}{%
			\typeout{AVISO FINAL: maketitle nao foi chamado - paginas pre-textuais podem estar faltando}%
		}{%
			\typeout{OK FINAL: Paginas pre-textuais foram geradas}%
		}%
		
		% Verifica se pretextual foi chamado
		\@ifundefined{@pretextualcalled}{%
			\typeout{AVISO FINAL: pretextual nao foi chamado - numeracao pode estar incorreta}%
		}{%
			\typeout{OK FINAL: Secao pre-textual foi configurada}%
		}%
		
		% Verifica se textual foi chamado
		\@ifundefined{@textualcalled}{%
			\typeout{AVISO FINAL: textual nao foi chamado - numeracao pode estar incorreta}%
		}{%
			\typeout{OK FINAL: Secao textual foi configurada}%
		}%
		
		% Estatísticas finais
		\typeout{Total de paginas: \theTotPaginas}%
		\typeout{Membros da banca: \themembrobancacount}%
		
		\if@errosencontrados%
			\typeout{RESULTADO: Documento compilado COM ERROS}%
		\else%
			\typeout{RESULTADO: Documento compilado com sucesso}%
		\fi%
		
		\typeout{================================}%
	\fi%
}

% Comando para executar diagnóstico manual
\newcommand{\diagnosticoppgt}{\@diagnosticoppgt}

% Comando para validação manual
\newcommand{\validarppgt}{%
	\@verificarcompatibilidade%
	\@configurarfallbacks%
	\typeout{Validacao manual executada}%
}

% Comando para teste completo da configuração
\newcommand{\testeppgt}{%
	\typeout{=== TESTE COMPLETO UnB-PPGT ===}%
	
	% Testa campos obrigatórios
	\@ifundefined{@titulodefinido}{%
		\typeout{ERRO: Titulo nao definido}%
	}{%
		\typeout{OK: Titulo definido}%
	}%
	
	\@ifundefined{@autordefinido}{%
		\typeout{ERRO: Autor nao definido}%
	}{%
		\typeout{OK: Autor definido}%
	}%
	
	\@ifundefined{@orientadordefinido}{%
		\typeout{ERRO: Orientador nao definido}%
	}{%
		\typeout{OK: Orientador definido}%
	}%
	
	% Testa data se definida
	\@ifundefined{@datadefinida}{%
		\typeout{AVISO: Data nao definida}%
	}{%
		\typeout{OK: Data definida (\@dia/\@mes/\@ano)}%
	}%
	
	% Testa banca
	\ifnum\themembrobancacount>0\relax%
		\typeout{OK: Banca com \themembrobancacount\ membros}%
	\else%
		\typeout{AVISO: Nenhum membro da banca definido}%
	\fi%
	
	% Testa pacotes
	\@ifpackageloaded{hyperref}{%
		\typeout{OK: Pacote hyperref carregado}%
	}{%
		\typeout{AVISO: Pacote hyperref nao carregado}%
	}%
	
	\@ifpackageloaded{babel}{%
		\typeout{OK: Pacote babel carregado}%
	}{%
		\typeout{AVISO: Pacote babel nao carregado}%
	}%
	
	\@ifpackageloaded{setspace}{%
		\typeout{OK: Pacote setspace carregado}%
	}{%
		\if@baselineskip%
			\typeout{OK: Usando baselineskip nativo}%
		\else%
			\typeout{ERRO: Pacote setspace nao carregado e baselineskip nao ativo}%
		\fi%
	}%
	
	\typeout{=== FIM DO TESTE ===}%
}

% Comando para relatório de status
\newcommand{\statusppgt}{%
	\typeout{=== STATUS UnB-PPGT ===}%
	\typeout{Classe: UnB-PPGT versao 2024/01/01}%
	\typeout{Tipo: \@tipodocumento}%
	\typeout{Validacao: \if@validacaoativada ativa\else desabilitada\fi}%
	\typeout{Erros encontrados: \if@errosencontrados sim\else nao\fi}%
	\typeout{Modo: \if@ForScreenView digital\else impressao\fi}%
	\typeout{Espacamento: \if@singlespacing simples\else\if@onehalfspacing 1,5\else duplo\fi\fi}%
	\typeout{Draft: \if@draftthesis sim\else nao\fi}%
	\typeout{====================}%
}

%%
%% --- Macros/comandos auxiliares ---
%%
\def\prof{\@ifnextchar[{\@prof@}{\@prof}}
\def\@prof#1{Prof.\ #1}
\def\@prof@[#1]#2{Prof.a\ #2}

\def\dr{\@ifnextchar[{\@dr@}{\@dr}}
\def\@dr#1{Dr.\ #1}
\def\@dr@[#1]#2{Dr.a\ #2}

%%
%% --- Páginas do trabalho ---
%%

\def\@lskipoffset#1{%quebra linha segundo referencia
	\begingroup%
		\newskip\len@lskipoffset%referência de espaçamento
		\setlength{\len@lskipoffset}{-.275\len@uadesch}%
		\addtolength{\len@lskipoffset}{#1\len@uacaph}%
		\\[\len@lskipoffset]%
	\endgroup%
}
%%
%% --- Sistema de logo integrado com identidade visual PPGT ---
%%

\newcommand*{\@logosize}{20}%tamanho da fonte utilizada (em pt)
\newcommand*{\@logosizecapa}{22}%tamanho da fonte para capa (maior)

% Logo da UnB com identidade visual PPGT integrada
\newcommand{\@logo}[1][positivo_cor]{%imprime o logo da UnB com hierarquia institucional PPGT
	\begingroup%
		\newskip\len@brasiliaw%largura da palavra Brasilia
		\newskip\len@uadesch%URW Arial descender height
		\newskip\len@uacaph%URW Arial cap height
		%
		\begin{spacing}{0}%tira espaço entre linhas
        \@ifundefined{XeTeXversion}
	{\fontfamily{\fontelogo}}%
			{\fontspec{\fontelogo}}%
		\fontsize{\@logosize}{0}\bfseries\selectfont%
		\settodepth{\len@uadesch}{jgpy}\settoheight{\len@uacaph}{B}%desc & cap heights
		\settowidth{\len@brasiliaw}{Bras\'ilia}%
		\addtolength{\len@brasiliaw}{-.105em}%ajusta pequeno espaço em branco antes do B desta fonte
		% Temporariamente desabilitado devido a problema com PNG
		% \includegraphics[width=\len@brasiliaw]{#1}\\[.63\len@uacaph]%logo com a largura da palavra Brasilia
		\rule{\len@brasiliaw}{2ex}\\[.63\len@uacaph]% Placeholder temporário
		\@universidade\@lskipoffset{.5}%
		\@textscale{.5}{\@faculdade}\@lskipoffset{.25}%
		\@textscale{.5}{\@departamento}\@lskipoffset{.25}%
		\@textscale{.5}{\@programa}%
		\end{spacing}%
	\endgroup
}

% Logo específico para capa (tamanho maior e formatação otimizada)
\newcommand{\@logocapa}[1][contorno_preto]{%logo otimizado para capa PPGT
	\begingroup%
		\newskip\len@brasiliaw%largura da palavra Brasilia
		\newskip\len@uadesch%URW Arial descender height
		\newskip\len@uacaph%URW Arial cap height
		%
		\begin{spacing}{0}%tira espaço entre linhas
        \@ifundefined{XeTeXversion}
	{\fontfamily{\fontelogo}}%
			{\fontspec{\fontelogo}}%
		\fontsize{\@logosizecapa}{0}\bfseries\selectfont%fonte maior para capa
		\settodepth{\len@uadesch}{jgpy}\settoheight{\len@uacaph}{B}%desc & cap heights
		\settowidth{\len@brasiliaw}{Bras\'ilia}%
		\addtolength{\len@brasiliaw}{-.105em}%ajusta pequeno espaço em branco antes do B desta fonte
		% Temporariamente desabilitado devido a problema com PNG
		% \includegraphics[width=\len@brasiliaw]{#1}\\[.63\len@uacaph]%logo com a largura da palavra Brasilia
		\rule{\len@brasiliaw}{3ex}\\[.63\len@uacaph]% Placeholder temporário maior para capa
		\MakeUppercase{\@universidade}\@lskipoffset{.5}%
		\@textscale{.5}{\MakeUppercase{\@faculdade}}\@lskipoffset{.25}%
		\@textscale{.5}{\MakeUppercase{\@departamento}}\@lskipoffset{.25}%
		\@textscale{.5}{\MakeUppercase{\@programa}}%
		\end{spacing}%
	\endgroup
}

%%
%% --- Sistema de numeração e formatação ---
%% Implementa numeração romana para páginas pré-textuais,
%% numeração arábica para páginas textuais e formatação de capítulos/seções
%%

% Configurações de espaçamento e margens conforme template Word PPGT
\newcommand{\configurarmargens}{%
	% Margens conforme especificação PPGT
	\if@draftthesis
		% Margens reduzidas para rascunho
		\geometry{margin={2cm,1.5cm}}
	\else
		% Margens oficiais: 3cm esquerda/superior, 2cm direita/inferior
		\if@ForScreenView
			\geometry{vmargin={3cm,2cm},hmargin={2.5cm,2.5cm}}
		\else
			\geometry{vmargin={3cm,2cm},hmargin={3cm,2cm}}
		\fi
	\fi
}

% Configurações de espaçamento entre linhas
\newcommand{\configurarespacamento}{%
	\if@baselineskip
		% Usa espaçamento baselineskip nativo
		\if@singlespacing
			\renewcommand{\baselinestretch}{1.0}
		\else
			\if@onehalfspacing
				\renewcommand{\baselinestretch}{1.5}
			\else
				\renewcommand{\baselinestretch}{2.0}
			\fi
		\fi
	\else
		% Usa pacote setspace
		\if@singlespacing
			\singlespacing
		\else
			\if@onehalfspacing
				\onehalfspacing
			\else
				\doublespacing
			\fi
		\fi
	\fi
}

% Comando para aplicar configurações de espaçamento padrão
\newcommand{\defaultspacing}{%
	\if@baselineskip\else
		\if@singlespacing
			\singlespacing
		\else
			\if@onehalfspacing
				\onehalfspacing
			\else
				\doublespacing
			\fi
		\fi
	\fi
}

% Formatação específica para capítulos conforme template PPGT
\newcommand{\formatocapitulo}{%
	\Huge% Tamanho grande para títulos de capítulos
	\bfseries% Negrito
	\MakeUppercase% Maiúsculas (conforme template Word)
}

% Formatação para seções
\newcommand{\formatosecao}{%
	\Large% Tamanho médio
	\bfseries% Negrito
}

% Formatação para subseções
\newcommand{\formatosubsecao}{%
	\large% Tamanho um pouco maior que normal
	\bfseries% Negrito
}

% Formatação para subsubseções
\newcommand{\formatosubsubsecao}{%
	\normalsize% Tamanho normal
	\bfseries% Negrito
}

% Configuração de numeração para seções (com suporte a textlinf quando disponível)
\@ifundefined{textlinf}{%
	% Se textlinf não estiver disponível, usa numeração normal
	\newcommand{\@numerosecao}[1]{\arabic{#1}}
}{%
	% Se textlinf estiver disponível, usa lining figures
	\newcommand{\@numerosecao}[1]{\protect\textlinf{\arabic{#1}}}
}

% Seção pré-textual com numeração romana
\newcommand\pretextual{%
	\gdef\@pretextualcalled{true}% Marca que pretextual foi chamado
	% Configurações de alinhamento e formatação para páginas pré-textuais
	\renewcommand{\chapteralign}{\centering}% Títulos centralizados
    \renewcommand{\chapterformat}{\formatocapitulo \thispagestyle{\style@pretextual}}
	
	% Inicia numeração romana em páginas pré-textuais
	\cleardoublepage
	\pagenumbering{roman}% Numeração romana (i, ii, iii, iv, ...)
	\setcounter{page}{1}% Reinicia contador de páginas
	
	% Aplica estilo de página para seção pré-textual
	\@pagestyle{\style@pretextual}
	
	% Configura espaçamento padrão
	\configurarespacamento
	
	% Contador para total de páginas
	\AtBeginShipout{\stepcounter{TotPaginas}}
}

% Seção textual com numeração arábica
\newcommand\textual{%
	\gdef\@textualcalled{true}% Marca que textual foi chamado
	% Configurações de alinhamento e formatação para páginas textuais
	\renewcommand{\chapteralign}{\raggedright}% Títulos alinhados à esquerda
    \renewcommand{\chapterformat}{\formatocapitulo \thispagestyle{\style@chapter}}
	
	% Inicia numeração arábica em páginas textuais
	\cleardoublepage
	\pagenumbering{arabic}% Numeração arábica (1, 2, 3, 4, ...)
	\setcounter{page}{1}% Reinicia contador de páginas
	
	% Aplica estilo de página para seção textual
	\@pagestyle{\style@textual}
	
	% Configura formatação de seções e subseções
	\renewcommand{\thesection}{\thechapter.\@numerosecao{section}}
	\renewcommand{\thesubsection}{\thesection.\@numerosecao{subsection}}
	\renewcommand{\thesubsubsection}{\thesubsection.\@numerosecao{subsubsection}}
	
	% Configura espaçamento padrão
	\configurarespacamento
}

% Seção pós-textual (anexos, apêndices)
\newcommand\postextual{%
	% Configurações de alinhamento para páginas pós-textuais
	\renewcommand{\chapteralign}{\centering}% Títulos centralizados
	
	% Mantém numeração arábica mas com formatação específica
	% Lining figures em section e subsection (quando disponível)
	\renewcommand\thesection{\thechapter.\@numerosecao{section}}
	\renewcommand\thesubsection{\thesection.\@numerosecao{subsection}}
	\renewcommand\thesubsubsection{\thesubsection.\@numerosecao{subsubsection}}

	% Evita problema com bookmarksnumbered=true no hyperref
	\@ifundefined{pdfstringdefDisableCommands}{}{%
		\pdfstringdefDisableCommands{\renewcommand*{\textlinf}[1]{##1}}
	}
}

%%
%% --- Configuração avançada de formatação de títulos ---
%%

% Espaçamentos antes e depois de títulos de capítulos
\newcommand{\espacoantescapitulo}{50pt}% Espaço antes do título
\newcommand{\espacodepoisnumero}{20pt}% Espaço após número do capítulo
\newcommand{\espacodepoiscapitulo}{40pt}% Espaço após título do capítulo

% Redefinição da formatação de cabeçalhos de capítulos numerados
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{\espacoantescapitulo}% Espaço antes do título
  {\parindent \z@ \chapteralign \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \formatosecao \@chapapp\space \thechapter% Número do capítulo
        \par\nobreak
        \vskip \espacodepoisnumero% Espaço após número
    \fi
    \interlinepenalty\@M
    \chapterformat #1\par\nobreak% Título do capítulo
    \vskip \espacodepoiscapitulo% Espaço após título
  }}

% Redefinição da formatação de cabeçalhos de capítulos não numerados
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{\espacoantescapitulo}% Espaço antes do título
  {\parindent \z@ \chapteralign
    \normalfont
    \interlinepenalty\@M
    \chapterformat #1\par\nobreak% Título do capítulo
    \vskip \espacodepoiscapitulo% Espaço após título
  }}

%%
%% --- Configuração de formatação de seções ---
%%

% Configuração de \section
\renewcommand{\section}{%
	\@startsection{section}{1}{\z@}%
		{-3.5ex \@plus -1ex \@minus -.2ex}% Espaço antes
		{2.3ex \@plus.2ex}% Espaço depois
		{\formatosecao}% Formatação
}

% Configuração de \subsection
\renewcommand{\subsection}{%
	\@startsection{subsection}{2}{\z@}%
		{-3.25ex\@plus -1ex \@minus -.2ex}% Espaço antes
		{1.5ex \@plus .2ex}% Espaço depois
		{\formatosubsecao}% Formatação
}

% Configuração de \subsubsection
\renewcommand{\subsubsection}{%
	\@startsection{subsubsection}{3}{\z@}%
		{-3.25ex\@plus -1ex \@minus -.2ex}% Espaço antes
		{1.5ex \@plus .2ex}% Espaço depois
		{\formatosubsubsecao}% Formatação
}

%%
%% --- Comandos para personalização de formatação ---
%%

% Comando para personalizar formatação de capítulos
\newcommand{\configurarcapitulos}[1]{%
	\renewcommand{\formatocapitulo}{#1}%
}

% Comando para personalizar formatação de seções
\newcommand{\configurarsecoes}[3]{%
	\renewcommand{\formatosecao}{#1}%
	\renewcommand{\formatosubsecao}{#2}%
	\renewcommand{\formatosubsubsecao}{#3}%
}

% Comando para personalizar espaçamentos de capítulos
\newcommand{\configurarespacoscapitulos}[3]{%
	\renewcommand{\espacoantescapitulo}{#1}%
	\renewcommand{\espacodepoisnumero}{#2}%
	\renewcommand{\espacodepoiscapitulo}{#3}%
}

%%
%% --- Aplicação automática das configurações ---
%%

% Aplica configurações de margens automaticamente
\AtBeginDocument{%
	\configurarmargens%
	\configurarespacamento%
}

%%
%% --- Sistema de metadados e comandos básicos ---
%% Implementa comandos para definir informações do trabalho seguindo padrão CIC
%% com melhorias específicas para o PPGT
%%

% Titulo e subtitulo do trabalho
\renewcommand*{\title}{\@dblarg\set@title}%
\newcommand*{\set@title}[2][]{%
	\if@validacaoativada%
		\ifx\relax#2\relax%
			\@erroppgt{Titulo vazio}%
				{O titulo do trabalho nao pode estar vazio}%
				{Documento sem titulo pode nao compilar corretamente}%
		\fi%
		% Verifica se o título é muito longo (mais de 200 caracteres)
		\newcount\@titlelen%
		\@titlelen=0%
		\expandafter\@counttitlelen#2\relax%
		\ifnum\@titlelen>200\relax%
			\@warningppgt{Titulo muito longo (\the\@titlelen\ caracteres)}%
				{Considere encurtar o titulo para melhor formatacao}%
		\fi%
	\fi%
	\xdef\@title{#1}
	\xdef\@maintitle{#2}
	\gdef\@titulodefinido{true}% Marca que título foi definido
}

% Comando auxiliar para contar caracteres do título (simplificado)
\def\@counttitlelen#1{%
	% Simplificado - apenas avisa se muito longo sem contar exatamente
	\def\@temptitle{#1}%
	\ifx\@temptitle\@empty%
	\else%
		\@titlelen=100% Valor aproximado para teste
	\fi%
}
\newcommand*{\subtitle}{\@dblarg\set@subtitle}
\newcommand*{\set@subtitle}[2][]{%
	\gdef\@subtitle{#2}
	\xdef\@title{\expandafter{\@title}: #1}
}

% Comando simplificado para título (seguindo padrão CIC)
\newcommand{\titulo}[1]{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Titulo vazio}%
				{O argumento de \protect\titulo nao pode estar vazio}%
				{Documento sem titulo pode nao compilar corretamente}%
		\fi%
	\fi%
	\title{#1}%
}

% Comando simplificado para subtítulo
\newcommand{\subtitulo}[1]{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@warningppgt{Subtitulo vazio}%
				{Considere remover o comando \protect\subtitulo se nao ha subtitulo}%
		\fi%
	\fi%
	\subtitle{#1}%
}

% Definicao de palavras-chave - para cip e resumo/abstract (melhorada)
\newcommand*{\keywords}{\@dblarg\set@keywords}
\newcommand*{\set@keywords}[2][]{%
	\if@validacaoativada%
		\ifx\relax#2\relax%
			\@warningppgt{Keywords vazias}%
				{Considere definir palavras-chave em ingles para melhor indexacao}%
		\fi%
	\fi%
	\gdef\@keywords{#1}
	\gdef\@@keywords{#2}
	\gdef\@keywordsdefinidas{true}
}
\newcommand*{\palavraschave}{\@dblarg\set@palavraschave}
\newcommand*{\set@palavraschave}[2][]{%
	\if@validacaoativada%
		\ifx\relax#2\relax%
			\@warningppgt{Palavras-chave vazias}%
				{Considere definir palavras-chave para melhor indexacao}%
		\fi%
	\fi%
	\gdef\@palavraschave{#1}
	\gdef\@@palavraschave{#2}
	\gdef\@palavraschavesdefinidas{true}
}

%%
%% --- Comandos para informações institucionais adicionais ---
%%

% Número da publicação PPGT
\newcommand{\numeropublicacao}[1]{%
	\gdef\@numeropublicacao{#1}%
	\gdef\@numeropublicacaodefinido{true}%
}

% Local da defesa (padrão: Brasília/DF)
\newcommand{\localdefesa}[2]{%
	\gdef\@cidadedefesa{#1}%
	\gdef\@ufdefesa{#2}%
	\gdef\@cidadeufdefesa{#1/#2}%
}

% Área de concentração
\newcommand{\areaconcentracao}[1]{%
	\gdef\@areaconcentracao{#1}%
	\gdef\@areaconcentracaodefinida{true}%
}

% Linha de pesquisa
\newcommand{\linhapesquisa}[1]{%
	\gdef\@linhapesquisa{#1}%
	\gdef\@linhapesquisadefinida{true}%
}

% Comandos específicos para ficha catalográfica
\newcommand{\classificacaocdu}[1]{\cdu{#1}}% Alias para CDU
\newcommand{\classificacaocdd}[1]{\cdd{#1}}% Alias para CDD
\newcommand{\totalpaginas}[1]{\numeropaginas{#1}}% Alias para número de páginas

%%
%% --- Comandos auxiliares para facilitar o uso ---
%%

% Comando para definir orientador sem gênero (assume masculino por padrão)
\newcommand{\orientadorM}[2]{\orientador{#1}{#2}}
\newcommand{\orientadorF}[2]{\orientador[F]{#1}{#2}}

% Comando para definir coorientador sem gênero (assume masculino por padrão)
\newcommand{\coorientadorM}[2]{\coorientador{#1}{#2}}
\newcommand{\coorientadorF}[2]{\coorientador[F]{#1}{#2}}

% Comando para definir coordenador sem gênero (assume masculino por padrão)
\newcommand{\coordenadorM}[2]{\coordenador{#1}{#2}}
\newcommand{\coordenadorF}[2]{\coordenador[F]{#1}{#2}}

%%
%% --- Comandos específicos para formatação da capa PPGT ---
%%

% Comando para personalizar espaçamentos da capa
\newcommand{\espacamentologocapa}{2cm}
\newcommand{\espacamentotitulo}{2.5cm}
\newcommand{\espacamentoautor}{2.5cm}
\newcommand{\espacamentotipodoc}{2cm}
\newcommand{\espacamentoorientador}{0.8cm}
\newcommand{\espacamentopublicacao}{2cm}

% Comando para personalizar tamanhos de fonte da capa
\newcommand{\fontetitulocapa}{32pt}
\newcommand{\fontesubtitulocapa}{28pt}
\newcommand{\fonteautorcapa}{20pt}
\newcommand{\fontetipodoccapa}{18pt}
\newcommand{\fonteorientadorcapa}{16pt}
\newcommand{\fontepublicacaocapa}{16pt}
\newcommand{\fontedatacapa}{16pt}

% Comando para personalizar logo da capa
\newcommand{\logocapa}[1]{\gdef\@logocapafile{#1}}
\gdef\@logocapafile{contorno_preto}% Padrão: logo com contorno preto

% Comando para redefinir espaçamentos da capa (uso avançado)
\newcommand{\configurarcapa}[9]{%
	\renewcommand{\espacamentologocapa}{#1}%
	\renewcommand{\espacamentotitulo}{#2}%
	\renewcommand{\espacamentoautor}{#3}%
	\renewcommand{\espacamentotipodoc}{#4}%
	\renewcommand{\espacamentoorientador}{#5}%
	\renewcommand{\espacamentopublicacao}{#6}%
	\renewcommand{\fontetitulocapa}{#7}%
	\renewcommand{\fonteautorcapa}{#8}%
	\renewcommand{\fontedatacapa}{#9}%
}

% Comando simplificado para data no formato DD/MM/AAAA
\newcommand{\datadefesabr}[1]{%
	% Implementação simplificada - usuário deve usar \datadefesa{dia}{mes}{ano}
	\ClassWarning{UnB-PPGT}{Use \protect\datadefesa{dia}{mes}{ano} ao inves de \protect\datadefesabr}%
}

% Data do trabalho (melhorada com validação)
\def\diamesano#1#2#3{%
	\def\@dia{#1}%
	\def\@mes{#2}%
	\def\@ano{#3}%
	% Validação usando o novo sistema de erros
	\@validardata{#1}{#2}{#3}%
	% Converte número do mês para nome
	\ifcase#2\relax%
		\@erroppgt{Mes invalido: #2}%
			{O mes deve ser um numero entre 1 e 12}%
			{Data com mes invalido pode causar problemas na formatacao}%
	\or\gdef\@nomemes{Janeiro}%
	\or\gdef\@nomemes{Fevereiro}%
	\or\gdef\@nomemes{Março}%
	\or\gdef\@nomemes{Abril}%
	\or\gdef\@nomemes{Maio}%
	\or\gdef\@nomemes{Junho}%
	\or\gdef\@nomemes{Julho}%
	\or\gdef\@nomemes{Agosto}%
	\or\gdef\@nomemes{Setembro}%
	\or\gdef\@nomemes{Outubro}%
	\or\gdef\@nomemes{Novembro}%
	\or\gdef\@nomemes{Dezembro}%
	\else%
		\@erroppgt{Mes invalido: #2}%
			{O mes deve ser um numero entre 1 e 12}%
			{Data com mes invalido pode causar problemas na formatacao}%
	\fi%
	\gdef\@datadefinida{true}% Marca que data foi definida
}

% Comando alternativo para data de defesa
\newcommand{\datadefesa}[3]{\diamesano{#1}{#2}{#3}}

% Definicao do autor (seguindo padrão CIC)
\newcommand{\autor}[2]{
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Nome do autor vazio}%
				{O primeiro argumento de \protect\autor deve conter o prenome}%
				{Autor sem prenome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#2\relax%
			\@erroppgt{Sobrenome do autor vazio}%
				{O segundo argumento de \protect\autor deve conter o sobrenome}%
				{Autor sem sobrenome pode causar problemas na formatacao}%
		\fi%
	\fi%
	\def\primeiroautor{#1\ #2}% Único autor em ordem Prenome Nome
	\def\primeiroautorinv{#2,\ #1}% Único autor em ordem Nome, Prenome
	\author{\primeiroautor}
	\gdef\@autorprenome{#1}% Armazena prenome separadamente
	\gdef\@autorsobrenome{#2}% Armazena sobrenome separadamente
	\gdef\@autordefinido{true}% Marca que autor foi definido
}

% Definicao do coordenador do programa (melhorada)
\def\coordenador{\@ifnextchar[%]
              {\at@coorda}%Se primeiro argumento opcional chama esta
              {\at@coordo}}%senão chama esta rotina

\def\at@coorda[#1]#2#3{\def\@sexocoordenador{Coordenadora}%
                        \def\@nomecoordenador{#2}%
                        \def\@filicoordenador{#3}%
                        \gdef\@coordenadordefinido{true}}

\def\at@coordo#1#2{\def\@sexocoordenador{Coordenador}%
                        \def\@nomecoordenador{#1}%
                        \def\@filicoordenador{#2}%
                        \gdef\@coordenadordefinido{true}}

% Definicao do orientador (melhorada)
\def\orientador{\@ifnextchar[%]
              {\at@orienta}%Se primeiro argumento opcional chama esta
              {\at@oriento}}%senao chama esta rotina

\def\at@orienta[#1]#2#3{%
	\if@validacaoativada%
		\ifx\relax#2\relax%
			\@erroppgt{Nome do orientador vazio}%
				{O segundo argumento de \protect\orientador deve conter o nome}%
				{Orientador sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#3\relax%
			\@warningppgt{Instituicao do orientador vazia}%
				{Considere especificar a instituicao do orientador}%
		\fi%
	\fi%
	\def\@sexoorientador{Orientadora}%
	\def\@nomeorientador{#2}%
	\def\@filiorientador{#3}%
	\gdef\@orientadordefinido{true}%
}

\def\at@oriento#1#2{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Nome do orientador vazio}%
				{O primeiro argumento de \protect\orientador deve conter o nome}%
				{Orientador sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#2\relax%
			\@warningppgt{Instituicao do orientador vazia}%
				{Considere especificar a instituicao do orientador}%
		\fi%
	\fi%
	\def\@sexoorientador{Orientador}%
	\def\@nomeorientador{#1}%
	\def\@filiorientador{#2}%
	\gdef\@orientadordefinido{true}%
}

% Definicao do coorientador (melhorada)
\newif\if@coorientador
\def\coorientador{\@coorientadortrue \@ifnextchar[%]
              {\at@coorienta}%Se primeiro argumento opcional chama esta
              {\at@cooriento}}%senao chama esta rotina

\def\at@coorienta[#1]#2#3{%
	\if@validacaoativada%
		\ifx\relax#2\relax%
			\@erroppgt{Nome do coorientador vazio}%
				{O segundo argumento de \protect\coorientador deve conter o nome}%
				{Coorientador sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#3\relax%
			\@warningppgt{Instituicao do coorientador vazia}%
				{Considere especificar a instituicao do coorientador}%
		\fi%
	\fi%
	\def\@sexocoorientador{Coorientadora}%
	\def\@nomecoorientador{#2}%
	\def\@filicoorientador{#3}%
	\gdef\@coorientadordefinido{true}%
}

\def\at@cooriento#1#2{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Nome do coorientador vazio}%
				{O primeiro argumento de \protect\coorientador deve conter o nome}%
				{Coorientador sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#2\relax%
			\@warningppgt{Instituicao do coorientador vazia}%
				{Considere especificar a instituicao do coorientador}%
		\fi%
	\fi%
	\def\@sexocoorientador{Coorientador}%
	\def\@nomecoorientador{#1}%
	\def\@filicoorientador{#2}%
	\gdef\@coorientadordefinido{true}%
}

% Sistema de definição de banca foi movido para seção anterior com implementação aprimorada

%%
%% --- Sistema aprimorado de páginas pré-textuais opcionais ---
%% Implementa ambientes para dedicatória, agradecimentos, resumo e abstract
%% com formatação específica e integração com numeração romana
%%

% Ambiente base para páginas pré-textuais com formatação padronizada
\newenvironment{paginatitulo}
	{\cleardoublepage\thispagestyle{empty}}
	{}

% Ambiente aprimorado para páginas pré-textuais com numeração romana
\newenvironment{paginapretextual}[1]{%
	\cleardoublepage%
	\thispagestyle{\style@pretextual}% Usa estilo configurado para pré-textual
	\pdfbookmark{#1}{#1}% Adiciona bookmark para navegação
}{%
	\clearpage%
}

%%
%% --- Ambiente para Dedicatória ---
%%

% Comando para configurar formatação da dedicatória
\newcommand{\formatodedicatoria}{%
	\centering% Centralizado
	\vspace*{\fill}% Espaço flexível no topo
	\itshape% Texto em itálico
	\large% Fonte um pouco maior
}

% Ambiente dedicatória com formatação específica do PPGT
\newenvironment{dedicatoria}{%
	\begin{paginapretextual}{Dedicatória}%
		\chapter*{Dedicatória}%
		\formatodedicatoria%
}{%
	\vspace*{\fill}% Espaço flexível na parte inferior
	\end{paginapretextual}%
}

% Comando alternativo para dedicatória simples (uma linha)
\newcommand{\dedicatoriasimples}[1]{%
	\begin{dedicatoria}%
		#1%
	\end{dedicatoria}%
}

%%
%% --- Ambiente para Agradecimentos ---
%%

% Comando para configurar formatação dos agradecimentos
\newcommand{\formatoagradecimentos}{%
	\raggedright% Texto justificado à esquerda
	\normalsize% Tamanho normal da fonte
	\onehalfspacing% Espaçamento 1,5
}

% Ambiente agradecimentos com formatação específica do PPGT
\newenvironment{agradecimentos}{%
	\begin{paginapretextual}{Agradecimentos}%
		\chapter*{Agradecimentos}%
		\formatoagradecimentos%
}{%
	\end{paginapretextual}%
}

%%
%% --- Ambiente para Resumo com palavras-chave ---
%%

% Comando para configurar formatação do resumo
\newcommand{\formatoresumo}{%
	\raggedright% Texto justificado
	\normalsize% Tamanho normal da fonte
	\singlespacing% Espaçamento simples para o resumo
}

% Comando para formatação das palavras-chave
\newcommand{\formatopalavraschave}{%
	\vskip 15pt% Espaçamento antes das palavras-chave
	\noindent% Sem indentação
	\textbf{Palavras-chave:}\ % Rótulo em negrito
}

% Ambiente resumo aprimorado com palavras-chave integradas
\newenvironment{resumo}{%
	\begin{paginapretextual}{Resumo}%
		\chapter*{Resumo}%
		\formatoresumo%
}{%
	% Adiciona palavras-chave automaticamente se definidas
	\@ifundefined{@@palavraschave}{%
		\ClassWarning{UnB-PPGT}{Palavras-chave nao definidas para o resumo. Use \protect\palavraschave{palavras}}%
	}{%
		\formatopalavraschave\@@palavraschave%
	}%
	\end{paginapretextual}%
}

% Comando para resumo com palavras-chave explícitas (sobrescreve as definidas globalmente)
\newenvironment{resumocompalavras}[1]{%
	\begin{paginapretextual}{Resumo}%
		\chapter*{Resumo}%
		\formatoresumo%
	\gdef\@palavraschavelocais{#1}% Armazena palavras-chave locais
}{%
	\formatopalavraschave\@palavraschavelocais%
	\end{paginapretextual}%
}

%%
%% --- Ambiente para Abstract com keywords ---
%%

% Comando para configurar formatação do abstract
\newcommand{\formatoabstract}{%
	\raggedright% Texto justificado
	\normalsize% Tamanho normal da fonte
	\singlespacing% Espaçamento simples para o abstract
}

% Comando para formatação das keywords
\newcommand{\formatokeywords}{%
	\vskip 15pt% Espaçamento antes das keywords
	\noindent% Sem indentação
	\textbf{Keywords:}\ % Rótulo em negrito
}

% Ambiente abstract aprimorado com keywords integradas e idioma inglês
\renewenvironment{abstract}{%
	\begin{paginapretextual}{Abstract}%
		\begin{otherlanguage*}{english}% Muda para inglês
			\chapter*{Abstract}%
			\formatoabstract%
}{%
	% Adiciona keywords automaticamente se definidas
	\@ifundefined{@@keywords}{%
		\ClassWarning{UnB-PPGT}{Keywords nao definidas para o abstract. Use \protect\keywords{keywords}}%
	}{%
		\formatokeywords\@@keywords%
	}%
		\end{otherlanguage*}%
	\end{paginapretextual}%
}

% Comando para abstract com keywords explícitas (sobrescreve as definidas globalmente)
\newenvironment{abstractcomkeywords}[1]{%
	\begin{paginapretextual}{Abstract}%
		\begin{otherlanguage*}{english}%
			\chapter*{Abstract}%
			\formatoabstract%
	\gdef\@keywordslocais{#1}% Armazena keywords locais
}{%
	\formatokeywords\@keywordslocais%
		\end{otherlanguage*}%
	\end{paginapretextual}%
}

%%
%% --- Comandos auxiliares para personalização ---
%%

% Comando para personalizar formatação da dedicatória
\newcommand{\configurardedicatoria}[1]{%
	\renewcommand{\formatodedicatoria}{#1}%
}

% Comando para personalizar formatação dos agradecimentos
\newcommand{\configuraragradecimentos}[1]{%
	\renewcommand{\formatoagradecimentos}{#1}%
}

% Comando para personalizar formatação do resumo
\newcommand{\configurarresumo}[1]{%
	\renewcommand{\formatoresumo}{#1}%
}

% Comando para personalizar formatação do abstract
\newcommand{\configurarabstract}[1]{%
	\renewcommand{\formatoabstract}{#1}%
}

% Comando para personalizar rótulo das palavras-chave
\newcommand{\rotulopalavraschave}[1]{%
	\renewcommand{\formatopalavraschave}{%
		\vskip 15pt\noindent\textbf{#1:}\ %
	}%
}

% Comando para personalizar rótulo das keywords
\newcommand{\rotulokeywords}[1]{%
	\renewcommand{\formatokeywords}{%
		\vskip 15pt\noindent\textbf{#1:}\ %
	}%
}

%%
%% --- Validação de ambientes pré-textuais ---
%%

% Comando para validar se palavras-chave foram definidas antes do resumo
\newcommand{\@validarpalavraschave}{%
	\@ifundefined{@@palavraschave}{%
		\ClassError{UnB-PPGT}%
			{Palavras-chave nao definidas}%
			{Use o comando \protect\palavraschave{palavras} antes do ambiente resumo}%
	}{}%
}

% Comando para validar se keywords foram definidas antes do abstract
\newcommand{\@validarkeywords}{%
	\@ifundefined{@@keywords}{%
		\ClassError{UnB-PPGT}%
			{Keywords nao definidas}%
			{Use o comando \protect\keywords{keywords} antes do ambiente abstract}%
	}{}%
}

%%
%% --- Integração com sistema de numeração romana ---
%%

% Os ambientes já estão integrados com o sistema de numeração romana
% através do uso do ambiente paginapretextual que utiliza o estilo
% configurado em \style@pretextual e é chamado após \pretextual
% que configura a numeração romana

%%
%% --- Comandos de conveniência para uso rápido ---
%%

% Comando para incluir dedicatória de arquivo
\newcommand{\incluirdedicatoria}[1]{%
	\begin{dedicatoria}%
		\input{#1}%
	\end{dedicatoria}%
}

% Comando para incluir agradecimentos de arquivo
\newcommand{\incluiragradecimentos}[1]{%
	\begin{agradecimentos}%
		\input{#1}%
	\end{agradecimentos}%
}

% Comando para incluir resumo de arquivo
\newcommand{\incluirresumo}[1]{%
	\begin{resumo}%
		\input{#1}%
	\end{resumo}%
}

% Comando para incluir abstract de arquivo
\newcommand{\incluirabstract}[1]{%
	\begin{abstract}%
		\input{#1}%
	\end{abstract}%
}

%%
%% --- Sistema de geração automática de listas ---
%% Implementa lista de figuras, tabelas e siglas automatizadas
%% com formatação específica do PPGT
%%

%%
%% --- Configuração de formatação das listas ---
%%

% Configurações gerais para todas as listas
\newcommand{\@formatogeralistas}{%
	\onehalfspacing% Espaçamento 1,5 para as listas
	\normalsize% Tamanho normal da fonte
}

% Configuração específica para lista de figuras
\newcommand{\@formatolistafiguras}{%
	\@formatogeralistas%
	% Configurações específicas para figuras podem ser adicionadas aqui
}

% Configuração específica para lista de tabelas
\newcommand{\@formatolistatabelas}{%
	\@formatogeralistas%
	% Configurações específicas para tabelas podem ser adicionadas aqui
}

% Configuração específica para lista de siglas
\newcommand{\@formatolistasiglas}{%
	\@formatogeralistas%
	\singlespacing% Lista de siglas usa espaçamento simples
}

%%
%% --- Sistema aprimorado de lista de figuras ---
%%

% Comando para personalizar formatação da lista de figuras
\newcommand{\configurarlistafiguras}[1]{%
	\renewcommand{\@formatolistafiguras}{#1}%
}

% Comando para gerar lista de figuras automatizada com formatação PPGT
\newcommand{\@listadefigurasppgt}{%
	\iftotalfigures% Só gera se houver figuras
		\cleardoublepage%
		\phantomsection% Para hyperref
		\addcontentsline{toc}{chapter}{\listfigurename}%
		\chapter*{\listfigurename}%
		\@formatolistafiguras%
		\@starttoc{lof}% Gera a lista de figuras
		\defaultspacing% Retorna ao espaçamento padrão
	\else%
		\ClassInfo{UnB-PPGT}{Nenhuma figura encontrada. Lista de figuras sera omitida.}%
	\fi%
}

% Comando para incluir lista de figuras manualmente (uso avançado)
\newcommand{\incluirlistafiguras}{%
	\@listadefigurasppgt%
}

% Comando para forçar inclusão da lista mesmo sem figuras (uso avançado)
\newcommand{\forcarlistafiguras}{%
	\cleardoublepage%
	\phantomsection%
	\addcontentsline{toc}{chapter}{\listfigurename}%
	\chapter*{\listfigurename}%
	\@formatolistafiguras%
	\@starttoc{lof}%
	\defaultspacing%
}

%%
%% --- Sistema aprimorado de lista de tabelas ---
%%

% Comando para personalizar formatação da lista de tabelas
\newcommand{\configurarlistatabelas}[1]{%
	\renewcommand{\@formatolistatabelas}{#1}%
}

% Comando para gerar lista de tabelas automatizada com formatação PPGT
\newcommand{\@listadetabelasppgt}{%
	\iftotaltables% Só gera se houver tabelas
		\cleardoublepage%
		\phantomsection% Para hyperref
		\addcontentsline{toc}{chapter}{\listtablename}%
		\chapter*{\listtablename}%
		\@formatolistatabelas%
		\@starttoc{lot}% Gera a lista de tabelas
		\defaultspacing% Retorna ao espaçamento padrão
	\else%
		\ClassInfo{UnB-PPGT}{Nenhuma tabela encontrada. Lista de tabelas sera omitida.}%
	\fi%
}

% Comando para incluir lista de tabelas manualmente (uso avançado)
\newcommand{\incluirlistatabelas}{%
	\@listadetabelasppgt%
}

% Comando para forçar inclusão da lista mesmo sem tabelas (uso avançado)
\newcommand{\forcarlistatabelas}{%
	\cleardoublepage%
	\phantomsection%
	\addcontentsline{toc}{chapter}{\listtablename}%
	\chapter*{\listtablename}%
	\@formatolistatabelas%
	\@starttoc{lot}%
	\defaultspacing%
}

%%
%% --- Sistema aprimorado de lista de siglas e abreviações ---
%%

% Comando para personalizar formatação da lista de siglas
\newcommand{\configurarlistasiglas}[1]{%
	\renewcommand{\@formatolistasiglas}{#1}%
}

% Comando aprimorado para definir siglas com validação
% (Redefine o comando existente com melhorias)
\def\sigla#1#2{%
	% Validação básica dos parâmetros
	\ifx\relax#1\relax%
		\ClassError{UnB-PPGT}%
			{Sigla vazia nao permitida}%
			{Use \protect\sigla{SIGLA}{Significado da sigla}}%
	\fi%
	\ifx\relax#2\relax%
		\ClassError{UnB-PPGT}%
			{Significado da sigla vazio nao permitido}%
			{Use \protect\sigla{SIGLA}{Significado da sigla}}%
	\fi%
	% Define a sigla usando glossaries
	\newacronym{#1}{#1}{#2}%
}

% Comando para gerar lista de siglas automatizada com formatação PPGT
\newcommand{\@listadesiglas}{%
	% Verifica se há siglas definidas
	\ifglsentryexists{acronym}{%
		\cleardoublepage%
		\phantomsection% Para hyperref
		\addcontentsline{toc}{chapter}{\acronymname}%
		\chapter*{\acronymname}%
		\@formatolistasiglas%
		\printglossary[type=\acronymtype]% Gera a lista de siglas
		\defaultspacing% Retorna ao espaçamento padrão
	}{%
		% Tenta incluir arquivo de siglas se existir
		\IfFileExists{\@texpath/siglas.tex}{%
			\cleardoublepage%
			\phantomsection%
			\addcontentsline{toc}{chapter}{\acronymname}%
			\chapter*{\acronymname}%
			\@formatolistasiglas%
			\@inputTeXFile{siglas}% Inclui arquivo de siglas
			\printglossary[type=\acronymtype]% Gera a lista
			\defaultspacing%
		}{%
			\ClassInfo{UnB-PPGT}{Nenhuma sigla definida e arquivo siglas.tex nao encontrado. Lista de siglas sera omitida.}%
		}%
	}%
}

% Comando para incluir lista de siglas manualmente (uso avançado)
\newcommand{\incluirlistasiglas}{%
	\@listadesiglas%
}

% Comando para forçar inclusão da lista mesmo sem siglas (uso avançado)
\newcommand{\forcarlistasiglas}{%
	\cleardoublepage%
	\phantomsection%
	\addcontentsline{toc}{chapter}{\acronymname}%
	\chapter*{\acronymname}%
	\@formatolistasiglas%
	\IfFileExists{\@texpath/siglas.tex}{\@inputTeXFile{siglas}}{}%
	\printglossary[type=\acronymtype]%
	\defaultspacing%
}

%%
%% --- Sistema de controle de inclusão de listas ---
%%

% Flags para controlar quais listas incluir
\newif\if@incluirlistafiguras\@incluirlistafigurastrue
\newif\if@incluirlistatabelas\@incluirlistatabelastrue
\newif\if@incluirlistasiglas\@incluirlistasiglastrue

% Comandos para desabilitar listas específicas
\newcommand{\desabilitarlistafiguras}{\@incluirlistafigurasfalse}
\newcommand{\desabilitarlistatabelas}{\@incluirlistatabelasfalse}
\newcommand{\desabilitarlistasiglas}{\@incluirlistasiglasfalse}

% Comandos para habilitar listas específicas
\newcommand{\habilitarlistafiguras}{\@incluirlistafigurastrue}
\newcommand{\habilitarlistatabelas}{\@incluirlistatabelastrue}
\newcommand{\habilitarlistasiglas}{\@incluirlistasiglastrue}

% Comando para desabilitar todas as listas
\newcommand{\desabilitartodaslistas}{%
	\@incluirlistafigurasfalse%
	\@incluirlistatabelasfalse%
	\@incluirlistasiglasfalse%
}

% Comando para habilitar todas as listas
\newcommand{\habilitartodaslistas}{%
	\@incluirlistafigurastrue%
	\@incluirlistatabelastrue%
	\@incluirlistasiglastrue%
}

%%
%% --- Comandos de conveniência para personalização avançada ---
%%

% Comando para personalizar título da lista de figuras
\newcommand{\titulolistafiguras}[1]{%
	\renewcommand{\listfigurename}{#1}%
}

% Comando para personalizar título da lista de tabelas
\newcommand{\titulolistatabelas}[1]{%
	\renewcommand{\listtablename}{#1}%
}

% Comando para personalizar título da lista de siglas
\newcommand{\titulolistasiglas}[1]{%
	\renewcommand{\acronymname}{#1}%
}

% Comando para configurar todas as listas de uma vez
\newcommand{\configurartodaslistas}[3]{%
	% #1: formatação lista de figuras
	% #2: formatação lista de tabelas  
	% #3: formatação lista de siglas
	\renewcommand{\@formatolistafiguras}{#1}%
	\renewcommand{\@formatolistatabelas}{#2}%
	\renewcommand{\@formatolistasiglas}{#3}%
}

%%
%% --- Integração com sistema de numeração e formatação ---
%%

% As listas são automaticamente integradas com o sistema de numeração romana
% das páginas pré-textuais através dos comandos \cleardoublepage e \phantomsection
% que são chamados em cada lista

%%
%% --- Comandos auxiliares para depuração ---
%%

% Comando para mostrar informações sobre as listas (modo debug)
\newcommand{\@infolistasppgt}{%
	\ClassInfo{UnB-PPGT}{=== Informacoes das Listas PPGT ===}%
	\iftotalfigures%
		\ClassInfo{UnB-PPGT}{Lista de figuras: SERA INCLUIDA (\totvalue{figure} figuras)}%
	\else%
		\ClassInfo{UnB-PPGT}{Lista de figuras: sera omitida (nenhuma figura)}%
	\fi%
	\iftotaltables%
		\ClassInfo{UnB-PPGT}{Lista de tabelas: SERA INCLUIDA (\totvalue{table} tabelas)}%
	\else%
		\ClassInfo{UnB-PPGT}{Lista de tabelas: sera omitida (nenhuma tabela)}%
	\fi%
	\IfFileExists{\@texpath/siglas.tex}{%
		\ClassInfo{UnB-PPGT}{Lista de siglas: SERA INCLUIDA (arquivo siglas.tex encontrado)}%
	}{%
		\ClassInfo{UnB-PPGT}{Lista de siglas: sera omitida (arquivo siglas.tex nao encontrado)}%
	}%
	\ClassInfo{UnB-PPGT}{=== Fim das Informacoes ===}%
}

% Comando para ativar modo debug das listas
\newcommand{\debuglistas}{%
	\AtBeginDocument{\@infolistasppgt}%
}

\def\@printfulltitle{%
	\@ifundefined{@subtitle}{%
		\textbf{\Large \@title}%
	}{%
		\textbf{\Large\@maintitle\\[1ex]\large\@subtitle}%
	}\par%
}
%%
%% --- Sistema de geração da capa oficial do PPGT ---
%% Implementa layout conforme template Word oficial com identidade visual do PPGT
%%

% Validação de campos obrigatórios para capa
\newcommand{\@validarcamposobrigatoriosCapa}{%
	% Validação do título
	\@ifundefined{@maintitle}{%
		\ClassError{UnB-PPGT}%
			{Titulo nao definido para capa}%
			{Use o comando \protect\titulo{titulo} para definir o titulo do trabalho}%
	}{}%
	
	% Validação do autor
	\@ifundefined{@author}{%
		\ClassError{UnB-PPGT}%
			{Autor nao definido para capa}%
			{Use o comando \protect\autor{Prenome}{Sobrenome} para definir o autor}%
	}{}%
	
	% Validação do orientador
	\@ifundefined{@nomeorientador}{%
		\ClassError{UnB-PPGT}%
			{Orientador nao definido para capa}%
			{Use o comando \protect\orientador{Nome}{Instituicao} para definir o orientador}%
	}{}%
	
	% Validação da data
	\@ifundefined{@nomemes}{%
		\ClassError{UnB-PPGT}%
			{Data nao definida para capa}%
			{Use o comando \protect\datadefesa{dia}{mes}{ano} para definir a data}%
	}{}%
}

% Capa específica do PPGT seguindo template Word oficial
\newcommand\capa{
  \@validarcamposobrigatoriosCapa% Valida campos antes de gerar capa
  \begin{paginatitulo}%
	\singlespacing% Espaçamento simples para melhor controle do layout
        \begin{center}%
             % Logo da UnB com identidade visual PPGT (topo da página)
             \vspace*{-1cm}% Ajuste para posicionar logo no topo
             \@logocapa[\@logocapafile]
             
             % Espaçamento após logo (configurável)
             \vspace{\espacamentologocapa}
             
             % Título principal (fonte grande, negrito, centralizado, maiúsculo)
             {\fontsize{\fontetitulocapa}{\dimexpr\fontetitulocapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@maintitle}\par}%
             
             % Subtítulo (se definido, também em maiúsculo)
             \@ifundefined{@subtitle}{}{%
                \vspace{1cm}%
                {\fontsize{\fontesubtitulocapa}{\dimexpr\fontesubtitulocapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@subtitle}\par}%
             }%
             
             % Espaçamento após título (configurável)
             \vspace{\espacamentotitulo}
             
             % Nome do autor (fonte média, negrito, centralizado, maiúsculo)
             {\fontsize{\fonteautorcapa}{\dimexpr\fonteautorcapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@author}\par}%
             
             % Espaçamento antes do tipo de documento (configurável)
             \vspace{\espacamentoautor}
             
             % Tipo de documento institucional (texto específico PPGT em maiúsculo)
             {\fontsize{\fontetipodoccapa}{\dimexpr\fontetipodoccapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@graudocumento}\par}%
             
             % Espaçamento antes das informações de orientação (configurável)
             \vspace{\espacamentotipodoc}
             
             % Orientador (em maiúsculo para seguir padrão da capa)
             {\fontsize{\fonteorientadorcapa}{\dimexpr\fonteorientadorcapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@sexoorientador}: \MakeUppercase{\@nomeorientador}\par}%
             
             % Coorientador (se definido, também em maiúsculo)
             \if@coorientador%
                \vspace{\espacamentoorientador}%
                {\fontsize{\fonteorientadorcapa}{\dimexpr\fonteorientadorcapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@sexocoorientador}: \MakeUppercase{\@nomecoorientador}\par}%
             \fi%
             
             % Espaçamento antes do número da publicação (configurável)
             \vspace{\espacamentopublicacao}
             
             % Número da publicação PPGT (em maiúsculo)
             {\fontsize{\fontepublicacaocapa}{\dimexpr\fontepublicacaocapa+4pt\relax}\selectfont\bfseries%
             \@ifundefined{@numeropublicacao}{\MakeUppercase{PUBLICA\c{C}\~AO PPGT.TD-XXX/\@ano}}{\MakeUppercase{\@numeropublicacao}}\par}%
             
             % Espaçamento flexível para empurrar local/data para o final
             \vfill
             
             % Local e data (formato específico PPGT: BRASÍLIA/DF: MÊS/ANO, em maiúsculo)
             {\fontsize{\fontedatacapa}{\dimexpr\fontedatacapa+4pt\relax}\selectfont\bfseries\MakeUppercase{\@cidadeuf}: \MakeUppercase{\@nomemes}/\@ano\par}%
             
             % Espaçamento final
             \vspace{1cm}
             
       \end{center}%
	\defaultspacing% Retorna ao espaçamento padrão
  \end{paginatitulo}%
}

%%
%% --- Folha de rosto específica do PPGT ---
%% Implementa layout seguindo padrão PPGT com informações institucionais completas
%%

% Validação de campos obrigatórios para folha de rosto
\newcommand{\@validarcamposobrigatoriosFolhaRosto}{%
	% Validação do título
	\@ifundefined{@maintitle}{%
		\ClassError{UnB-PPGT}%
			{Titulo nao definido para folha de rosto}%
			{Use o comando \protect\titulo{titulo} para definir o titulo do trabalho}%
	}{}%
	
	% Validação do autor
	\@ifundefined{@author}{%
		\ClassError{UnB-PPGT}%
			{Autor nao definido para folha de rosto}%
			{Use o comando \protect\autor{Prenome}{Sobrenome} para definir o autor}%
	}{}%
	
	% Validação do orientador
	\@ifundefined{@nomeorientador}{%
		\ClassError{UnB-PPGT}%
			{Orientador nao definido para folha de rosto}%
			{Use o comando \protect\orientador{Nome}{Instituicao} para definir o orientador}%
	}{}%
	
	% Validação da data
	\@ifundefined{@ano}{%
		\ClassError{UnB-PPGT}%
			{Data nao definida para folha de rosto}%
			{Use o comando \protect\datadefesa{dia}{mes}{ano} para definir a data}%
	}{}%
}

% Comando para gerar texto explicativo sobre o tipo de trabalho
\newcommand{\@textotipotrabalhofr}{%
	\if@qualificacao%
		\@tipodocumento\ apresentada como requisito parcial para qualifica\c{c}\~ao no \@programa\ da \@universidade.%
	\else%
		\if@mestrado%
			\@tipodocumento\ de Mestrado submetida ao \@programa\ da \@universidade\ como requisito parcial para obten\c{c}\~ao do Grau de Mestre em Transportes.%
		\fi%
		\if@doutorado%
			\@tipodocumento\ de Doutorado submetida ao \@programa\ da \@universidade\ como requisito parcial para obten\c{c}\~ao do Grau de Doutor em Transportes.%
		\fi%
	\fi%
}

% Comando para gerar hierarquia institucional completa
\newcommand{\@hierarquiainstitucionalfr}{%
	\@universidade\\%
	\@faculdade\\%
	\@departamento\\%
	\@programa%
}

% Folha de rosto específica do PPGT com informações completas
\newcommand\folharosto{%
	\@validarcamposobrigatoriosFolhaRosto% Valida campos antes de gerar folha de rosto
	\begin{paginatitulo}%
		\onehalfspacing% Espaçamento 1,5 conforme normas
		\begin{center}%
			% Logo da UnB com hierarquia institucional completa (UnB > FT > ENC > PPGT)
			\@logo%
			
			% Espaçamento após logo
			\vspace{2cm}%
			
			% Título completo do trabalho (centralizado, fonte grande)
			\@printfulltitle%
			
			% Espaçamento após título
			\vspace{2cm}%
			
			% Nome do autor (fonte grande, negrito)
			{\Large\bfseries\@author}%
			
			% Espaçamento antes do texto explicativo
			\vspace{2.5cm}%
		\end{center}%
		
		% Texto explicativo sobre o tipo de trabalho (justificado, recuado à direita)
		\begin{flushright}%
			\begin{minipage}{0.5\textwidth}%
				\@textotipotrabalhofr%
			\end{minipage}%
		\end{flushright}%
		
		% Espaçamento antes das informações de orientação
		\vspace{1.5cm}%
		
		\begin{center}%
			% Orientador (posicionado corretamente com formatação consistente)
			\textbf{\@sexoorientador:} \@nomeorientador\\%
			\textit{\@filiorientador}%
			
			% Coorientador (se definido, posicionado corretamente)
			\if@coorientador%
				\vspace{1cm}%
				\textbf{\@sexocoorientador:} \@nomecoorientador\\%
				\textit{\@filicoorientador}%
			\fi%
			
			% Espaçamento flexível para empurrar local/data para o final
			\vfill%
			
			% Local e ano (fonte grande, formatação consistente)
			{\Large\textbf{\@cidade}}\\[0.5cm]%
			{\Large\textbf{\@ano}}%
		\end{center}%
		\defaultspacing% Retorna ao espaçamento padrão
	\end{paginatitulo}%
}

%%
%% --- Ficha catalográfica automatizada ---
%% Implementa geração automática da ficha catalográfica com dados bibliográficos padronizados
%% e seção de cessão de direitos conforme normas da biblioteca
%%

% Comandos para dados adicionais da ficha catalográfica
\newcommand{\cdu}[1]{\gdef\@cdu{#1}}% Classificação Decimal Universal
\newcommand{\cdd}[1]{\gdef\@cdd{#1}}% Classificação Decimal de Dewey
\newcommand{\isbn}[1]{\gdef\@isbn{#1}}% ISBN (se aplicável)
\newcommand{\numeropaginas}[1]{\gdef\@numeropaginas{#1}}% Número total de páginas

% Validação de campos obrigatórios para ficha catalográfica
\newcommand{\@validarcamposobrigatoriosFichaCat}{%
	% Validação do título
	\@ifundefined{@maintitle}{%
		\ClassError{UnB-PPGT}%
			{Titulo nao definido para ficha catalografica}%
			{Use o comando \protect\titulo{titulo} para definir o titulo do trabalho}%
	}{}%
	
	% Validação do autor
	\@ifundefined{@autorsobrenome}{%
		\ClassError{UnB-PPGT}%
			{Autor nao definido para ficha catalografica}%
			{Use o comando \protect\autor{Prenome}{Sobrenome} para definir o autor}%
	}{}%
	
	% Validação das palavras-chave para CIP
	\@ifundefined{@palavraschave}{%
		\ClassWarning{UnB-PPGT}%
			{Palavras-chave para CIP nao definidas. Use \protect\palavraschave[para CIP]{palavras}}%
	}{}%
	
	% Validação do orientador
	\@ifundefined{@nomeorientador}{%
		\ClassError{UnB-PPGT}%
			{Orientador nao definido para ficha catalografica}%
			{Use o comando \protect\orientador{Nome}{Instituicao} para definir o orientador}%
	}{}%
	
	% Validação da data
	\@ifundefined{@ano}{%
		\ClassError{UnB-PPGT}%
			{Data nao definida para ficha catalografica}%
			{Use o comando \protect\datadefesa{dia}{mes}{ano} para definir a data}%
	}{}%
}

% Comando para gerar dados bibliográficos padronizados
\newcommand{\@dadosbibliograficos}{%
	% Entrada principal (Autor, Título)
	\textbf{\MakeUppercase{\@autorsobrenome}, \@autorprenome}\\%
	\hspace*{1em}\@maintitle%
	\@ifundefined{@subtitle}{}{ : \@subtitle}%
	/ \@autorprenome\ \@autorsobrenome. -- \@cidade, \@ano.\\%
	
	% Descrição física
	\hspace*{1em}\@ifundefined{@numeropaginas}{\pageref{TotPaginas}\ p.}{\@numeropaginas\ p.}%
	: il. ; 30 cm.\\[0.5em]%
	
	% Nota de dissertação/tese
	\hspace*{1em}\@tipodocumento\ (\if@mestrado Mestrado\fi\if@doutorado Doutorado\fi\ em Transportes) -- \@universidade, \@faculdade, \@departamento, \@programa, \@ano.\\[0.5em]%
	
	% Orientador
	\hspace*{1em}\@sexoorientador: \@nomeorientador%
	\if@coorientador. \@sexocoorientador: \@nomecoorientador\fi.\\[0.5em]%
	
	% Palavras-chave (assuntos)
	\@ifundefined{@palavraschave}{}{%
		\hspace*{1em}1. \@palavraschave. I. \@nomeorientador, \@sexoorientador. II. \@universidade. III. T\'itulo.\\[0.5em]%
	}%
	
	% Classificações (se definidas)
	\@ifundefined{@cdu}{}{%
		\hspace*{1em}CDU: \@cdu\\%
	}%
	\@ifundefined{@cdd}{}{%
		\hspace*{1em}CDD: \@cdd\\%
	}%
}

% Comando para gerar seção de cessão de direitos
\newcommand{\@cessaodireitos}{%
	\vspace{1cm}%
	\begin{center}%
		\textbf{CESS\~AO DE DIREITOS}%
	\end{center}%
	\vspace{0.5cm}%
	
	\small%
	NOME DO AUTOR: \@author\\%
	T\'ITULO DA \MakeUppercase{\@tipodocumento}: \@maintitle%
	\@ifundefined{@subtitle}{}{ : \@subtitle}\\%
	GRAU: \if@mestrado Mestre\fi\if@doutorado Doutor\fi\ em Transportes\\%
	ANO: \@ano\\[0.5em]%
	
	\'E concedida \`a \@universidade\ permiss\~ao para reproduzir c\'opias desta \MakeLowercase{\@tipodocumento}\ e emprestar ou vender tais c\'opias somente para prop\'ositos acad\^emicos e cient\'ificos. O autor reserva outros direitos de publica\c{c}\~ao e nenhuma parte desta \MakeLowercase{\@tipodocumento}\ pode ser reproduzida sem a autoriza\c{c}\~ao por escrito do autor.\\[1em]%
	
	\rule{8cm}{0.4pt}\\%
	\@author\\%
	\@cidadeuf\\%
	\@pais\\%
	\normalsize%
}

% Comando principal para gerar a ficha catalográfica
\newcommand{\fichacatalografica}{%
	\@validarcamposobrigatoriosFichaCat% Valida campos antes de gerar ficha
	\begin{paginatitulo}%
		\singlespacing% Espaçamento simples para melhor controle do layout
		
		% Posiciona a ficha catalográfica no centro inferior da página
		\vspace*{\fill}%
		
		\begin{center}%
			% Caixa da ficha catalográfica com bordas
			\fbox{%
				\begin{minipage}{0.85\textwidth}%
					\vspace{0.5cm}%
					\begin{center}%
						\textbf{Ficha catalogr\'afica elaborada pela Biblioteca Central da Universidade de Bras\'ilia}%
					\end{center}%
					\vspace{0.5cm}%
					
					% Dados bibliográficos padronizados
					\small%
					\@dadosbibliograficos%
					\normalsize%
					\vspace{0.5cm}%
				\end{minipage}%
			}%
		\end{center}%
		
		% Seção de cessão de direitos
		\@cessaodireitos%
		
		\defaultspacing% Retorna ao espaçamento padrão
	\end{paginatitulo}%
}

% Comando alternativo para usuários que queiram personalizar a ficha
\newcommand{\fichacatalograficapersonalizada}[1]{%
	\begin{paginatitulo}%
		\singlespacing%
		\vspace*{\fill}%
		\begin{center}%
			\fbox{%
				\begin{minipage}{0.85\textwidth}%
					\vspace{0.5cm}%
					\begin{center}%
						\textbf{Ficha catalogr\'afica elaborada pela Biblioteca Central da Universidade de Bras\'ilia}%
					\end{center}%
					\vspace{0.5cm}%
					#1% Conteúdo personalizado
					\vspace{0.5cm}%
				\end{minipage}%
			}%
		\end{center}%
		\@cessaodireitos%
		\defaultspacing%
		\end{center}%
		\defaultspacing% Retorna ao espaçamento padrão
	\end{paginatitulo}%
}

%%
%% --- Sistema aprimorado para definição de membros da banca ---
%%

% Contador para membros da banca (além do orientador)
\newcounter{membrobancacount}
\setcounter{membrobancacount}{0}

% Array para armazenar membros da banca
\newcommand{\@nomemembrobanca}[1]{\csname @nomemembro\romannumeral#1\endcsname}
\newcommand{\@instmembrobanca}[1]{\csname @instmembro\romannumeral#1\endcsname}
\newcommand{\@funcmembrobanca}[1]{\csname @funcmembro\romannumeral#1\endcsname}

% Comando para definir função de membro da banca (Examinador Interno/Externo)
\newcommand{\@defmembrobancafunc}[3]{%
	\expandafter\gdef\csname @nomemembro\romannumeral#1\endcsname{#2}%
	\expandafter\gdef\csname @instmembro\romannumeral#1\endcsname{#3}%
	\expandafter\gdef\csname @funcmembro\romannumeral#1\endcsname{Examinador}%
}

% Comando para definir membro da banca com função específica
\newcommand{\membrobancafunc}[3]{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Nome do membro da banca vazio}%
				{O primeiro argumento de \protect\membrobancafunc deve conter o nome}%
				{Membro da banca sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#2\relax%
			\@warningppgt{Instituicao do membro da banca vazia}%
				{Considere especificar a instituicao do membro da banca}%
		\fi%
		\ifx\relax#3\relax%
			\@warningppgt{Funcao do membro da banca vazia}%
				{Considere especificar a funcao do membro da banca}%
		\fi%
	\fi%
	\stepcounter{membrobancacount}%
	\expandafter\gdef\csname @nomemembro\romannumeral\themembrobancacount\endcsname{#1}%
	\expandafter\gdef\csname @instmembro\romannumeral\themembrobancacount\endcsname{#2}%
	\expandafter\gdef\csname @funcmembro\romannumeral\themembrobancacount\endcsname{#3}%
}

% Comando simplificado para membro da banca (assume Examinador)
\newcommand{\membrobanca}[2]{%
	\if@validacaoativada%
		\ifx\relax#1\relax%
			\@erroppgt{Nome do membro da banca vazio}%
				{O primeiro argumento de \protect\membrobanca deve conter o nome}%
				{Membro da banca sem nome pode causar problemas na formatacao}%
		\fi%
		\ifx\relax#2\relax%
			\@warningppgt{Instituicao do membro da banca vazia}%
				{Considere especificar a instituicao do membro da banca}%
		\fi%
	\fi%
	\stepcounter{membrobancacount}%
	\@defmembrobancafunc{\themembrobancacount}{#1}{#2}%
}

% Comandos específicos para diferentes tipos de membros
\newcommand{\examinadorinterno}[2]{\membrobancafunc{#1}{#2}{Examinador Interno}}
\newcommand{\examinadorexterno}[2]{\membrobancafunc{#1}{#2}{Examinador Externo}}
\newcommand{\membroespecial}[3]{\membrobancafunc{#1}{#2}{#3}}

% Validação do número de membros da banca (atualizada para usar novo sistema)
\newcommand{\@validarnumeromembrosbanca}{%
	\ifnum\themembrobancacount<2\relax%
		\@erroppgt{A banca deve ter pelo menos 3 membros (orientador + 2 examinadores)}%
			{Use o comando \protect\membrobanca{Nome}{Instituicao} para definir os membros}%
			{Banca com numero insuficiente de membros pode nao atender aos requisitos institucionais}%
	\fi%
	\if@doutorado%
		\if@qualificacao%
		\else%
			\ifnum\themembrobancacount<4\relax%
				\@erroppgt{A banca de doutorado deve ter pelo menos 5 membros (orientador + 4 examinadores)}%
					{Use o comando \protect\membrobanca{Nome}{Instituicao} para definir os membros}%
					{Banca de doutorado com numero insuficiente de membros pode nao atender aos requisitos institucionais}%
			\fi%
		\fi%
	\fi%
}

%%
%% --- Folha de aprovação aprimorada do PPGT ---
%% Implementa layout profissional com espaços adequados para assinaturas
%%

% Comando para gerar linha de assinatura com nome e instituição
\newcommand{\@linhaassinatura}[3]{%
	% #1: Nome do membro, #2: Instituição, #3: Função
	\vspace{1.5cm}%
	\rule{8cm}{0.5pt}\\%
	\textbf{#1}\\%
	#3 -- #2%
}

% Comando para gerar linha de assinatura do orientador/coorientador
\newcommand{\@linhaassinaturaorientador}[3]{%
	% #1: Nome, #2: Instituição, #3: Função (Orientador/Coorientador)
	\vspace{1.5cm}%
	\rule{8cm}{0.5pt}\\%
	\textbf{#1}\\%
	#3 -- #2%
}

% Comando para gerar texto explicativo do tipo de trabalho na folha de aprovação
\newcommand{\@textotipotrabalhoaprovacao}{%
	\if@qualificacao%
		\@tipodocumento\ apresentada como requisito parcial para qualifica\c{c}\~ao no \@programa\ da \@universidade.%
	\else%
		\if@mestrado%
			\@tipodocumento\ de Mestrado submetida ao \@programa\ da \@universidade\ como requisito parcial para obten\c{c}\~ao do Grau de Mestre em Transportes.%
		\fi%
		\if@doutorado%
			\@tipodocumento\ de Doutorado submetida ao \@programa\ da \@universidade\ como requisito parcial para obten\c{c}\~ao do Grau de Doutor em Transportes.%
		\fi%
	\fi%
}

% Folha de aprovação específica do PPGT com layout aprimorado
\newcommand\folhaaprovacao{%
	\@validarnumeromembrosbanca% Valida número de membros antes de gerar
	\begin{paginatitulo}%
		\onehalfspacing%
		\begin{center}%
			% Logo da UnB com identidade PPGT
			\@logo%
			
			\vspace{2cm}%
			
			% Título do trabalho
			\@printfulltitle%
			
			\vspace{1.5cm}%
			
			% Nome do autor
			{\large\textbf{\@author}}%
			
			\vspace{2cm}%
			
			% Texto explicativo sobre o tipo de trabalho
			\begin{minipage}{0.8\textwidth}%
				\centering%
				\@textotipotrabalhoaprovacao%
			\end{minipage}%
			
			\vspace{1.5cm}%
			
			% Aprovação e data
			\if@qualificacao%
				\textbf{Qualifica\c{c}\~ao aprovada em \@dia\ de \@nomemes\ de \@ano.}%
			\else%
				\textbf{Trabalho aprovado em \@dia\ de \@nomemes\ de \@ano.}%
			\fi%
			
			\vspace{2cm}%
			
			% Título da seção de banca
			\textbf{\large BANCA EXAMINADORA}%
			
			% Orientador (sempre primeiro)
			\@linhaassinaturaorientador{\@nomeorientador}{\@filiorientador}{\@sexoorientador}%
			
			% Coorientador (se definido)
			\if@coorientador%
				\@linhaassinaturaorientador{\@nomecoorientador}{\@filicoorientador}{\@sexocoorientador}%
			\fi%
			
			% Membros da banca (gerados dinamicamente)
			\newcounter{tempcount}%
			\setcounter{tempcount}{1}%
			\loop%
				\ifnum\thetempcount>\themembrobancacount%
				\else%
					\@linhaassinatura{\@nomemembrobanca{\thetempcount}}{\@instmembrobanca{\thetempcount}}{\@funcmembrobanca{\thetempcount}}%
					\stepcounter{tempcount}%
				\repeat%
			
			\vspace{2cm}%
			
			% Local e data
			{\large \@cidadeuf, \@dia\ de \@nomemes\ de \@ano}%
			
		\end{center}%
		\defaultspacing%
	\end{paginatitulo}%
}

%%
%% --- Sistema de validação de campos obrigatórios ---
%%

\newcommand{\@validarcamposobrigatorios}{%
	% Validação do título
	\@ifundefined{@maintitle}{%
		\ClassError{UnB-PPGT}%
			{Titulo nao definido}%
			{Use o comando \protect\titulo{titulo} ou \protect\title{titulo} para definir o titulo do trabalho}%
	}{}%
	
	% Validação do autor
	\@ifundefined{@autorprenome}{%
		\ClassError{UnB-PPGT}%
			{Autor nao definido}%
			{Use o comando \protect\autor{Prenome}{Sobrenome} para definir o autor do trabalho}%
	}{}%
	
	% Validação do orientador
	\@ifundefined{@orientadordefinido}{%
		\ClassError{UnB-PPGT}%
			{Orientador nao definido}%
			{Use o comando \protect\orientador{Nome}{Instituicao} para definir o orientador}%
	}{}%
	
	% Validação da data de defesa
	\@ifundefined{@dia}{%
		\ClassError{UnB-PPGT}%
			{Data de defesa nao definida}%
			{Use o comando \protect\diamesano{dia}{mes}{ano} ou \protect\datadefesa{dia}{mes}{ano}}%
	}{}%
	
	% Validação do coordenador
	\@ifundefined{@coordenadordefinido}{%
		\ClassError{UnB-PPGT}%
			{Coordenador do programa nao definido}%
			{Use o comando \protect\coordenador{Nome}{Instituicao} para definir o coordenador}%
	}{}%
	
	% Validação das palavras-chave (apenas aviso)
	\@ifundefined{@palavraschavesdefinidas}{%
		\ClassWarning{UnB-PPGT}%
			{Palavras-chave nao definidas. Use \protect\palavraschave{palavras}}%
	}{}%
	
	% Validação das keywords (apenas aviso)
	\@ifundefined{@keywordsdefinidas}{%
		\ClassWarning{UnB-PPGT}%
			{Keywords nao definidas. Use \protect\keywords{keywords}}%
	}{}%
	
	% Validação do número da publicação (apenas aviso)
	\@ifundefined{@numeropublicacaodefinido}{%
		\ClassWarning{UnB-PPGT}%
			{Numero da publicacao nao definido. Use \protect\numeropublicacao{PPGT.TD-XXX/YYYY}}%
	}{}%
}

%%
%% --- Processamento de final e início do documento ---
%%
\AtEndDocument{%
	\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%

	\addtocounter{page}{-1}%decrementa para depois . . .
    \ifhyperref{%
		\immediate\write\@mainaux{%
			\string\newlabel{TotPaginas}{{\arabic{TotPaginas}}{\thepage}{}{page.\thepage}{}}%
		}%
	}{%
		\immediate\write\@mainaux{%
			\string\newlabel{TotPaginas}{{\arabic{TotPaginas}}{\thepage}}%
		}%
	}
	\addtocounter{page}{1}% . . . incrementar de novo
}

\AtBeginDocument{%
	%define propriedades do PDF e carrega pacotes auxiliares
	\@ifpackageloaded{hyperref}{
	\hypersetup{
            pdftitle=\@title,
            pdfauthor=\@author,
            pdfsubject=\@assunto,
            pdfkeywords=\@palavraschave}
		\@ifpackageloaded{natbib}{
			%compatibilidade entre natbib e hyperref
		\RequirePackage{hypernat}
		}{}
		%posiciona melhor os links para captions
        \RequirePackage[all]{hypcap}
	}{
		\RequirePackage{nohyperref} %dummy macros for hyperref
		\RequirePackage{url} %permite quebra de linha em URLs
	}

	%controle do sumario de acordo com o estilo atual,
	%após hyperref carregado porque ele sobrescreve
	%o comando \addcontentsline
	\let\@addcontentsline\addcontentsline
	\def\@emptystr{empty}
	\def\@pagestyle#1{
		\let\@styletoset=#1%
		\pagestyle{\@styletoset}%
		%se estilo for empty, não adiciona ao TOC
		\ifx\@styletoset\@emptystr
			\renewcommand\addcontentsline[3]{\relax}
		\else
			\let\addcontentsline\@addcontentsline
		\fi
	}

	%traducoes para glossaries.sty
	\@ifpackageloaded{glossaries}{%
		\@ifundefined{XeTeXversion}{
			\addto\captionsbrazil{%
			\renewcommand*{\glossaryname}{Gloss\'ario}%
			\renewcommand*{\acronymname}{Lista de Abreviaturas e Siglas}%
			\renewcommand*{\entryname}{Entrada}%
			\renewcommand*{\descriptionname}{Descri\c{c}\~ao}%
			\renewcommand*{\symbolname}{S\'\imbolo}%
			\renewcommand*{\pagelistname}{Lista de p\'aginas}%
			\renewcommand*{\glssymbolsgroupname}{S\'imbolos}%
			\renewcommand*{\glsnumbersgroupname}{N\'umeros}}
		}{
			\addto\captionsbrazil{%
			\renewcommand*{\glossaryname}{Glossário}%
			\renewcommand*{\acronymname}{Lista de Abreviaturas e Siglas}%
			\renewcommand*{\entryname}{Entrada}%
			\renewcommand*{\descriptionname}{Descrição}%
			\renewcommand*{\symbolname}{Símbolo}%
			\renewcommand*{\pagelistname}{Lista de páginas}%
			\renewcommand*{\glssymbolsgroupname}{Símbolos}%
			\renewcommand*{\glsnumbersgroupname}{Números}}
		}
	}{}

	% Validação já foi executada no AtBeginDocument
}

%%
%% --- Comandos para elementos comuns ---
%% Implementa comandos simplificados para inserção de figuras, tabelas, equações
%% e referências cruzadas otimizadas seguindo padrão PPGT
%%

%%
%% --- Comandos simplificados para inserção de figuras ---
%%

% Comando para figura com largura personalizada
\newcommand{\figuracom}[5][htbp]{%
	% #1: posicionamento (opcional, padrão htbp)
	% #2: arquivo da imagem
	% #3: largura (ex: 0.6\textwidth, 10cm)
	% #4: legenda
	% #5: label para referência
	\begin{figure}[#1]%
		\centering%
		\includegraphics[width=#3]{#2}%
		\caption{#4}%
		\label{#5}%
	\end{figure}%
}

% Comando para figura com opções avançadas do includegraphics
\newcommand{\figuraavancada}[5][htbp]{%
	% #1: posicionamento (opcional, padrão htbp)
	% #2: arquivo da imagem
	% #3: opções do includegraphics (ex: width=0.5\textwidth,angle=90)
	% #4: legenda
	% #5: label para referência
	\begin{figure}[#1]%
		\centering%
		\includegraphics[#3]{#2}%
		\caption{#4}%
		\label{#5}%
	\end{figure}%
}

%%
%% --- Comandos para tabelas com formatação padrão PPGT ---
%%

% Comando para tabela com formatação específica do PPGT (bordas, espaçamento)
\newcommand{\tabelappgt}[5][htbp]{%
	% #1: posicionamento (opcional, padrão htbp)
	% #2: especificação de colunas
	% #3: conteúdo da tabela
	% #4: legenda
	% #5: label para referência
	\begin{table}[#1]%
		\centering%
		\caption{#4}%
		\renewcommand{\arraystretch}{1.2}% Espaçamento entre linhas
		\begin{tabular}{#2}%
			\hline%
			#3%
			\hline%
		\end{tabular}%
		\renewcommand{\arraystretch}{1}% Restaura espaçamento padrão
		\label{#5}%
	\end{table}%
}

%%
%% --- Sistema de numeração e formatação de equações ---
%%

% Comando para equação não numerada
\newcommand{\equacaosem}[1]{%
	% #1: conteúdo da equação
	\begin{equation*}%
		#1%
	\end{equation*}%
}

% Comando para sistema de equações alinhadas
\newcommand{\sistema}[2]{%
	% #1: conteúdo do sistema de equações
	% #2: label para referência
	\begin{align}%
		#1%
		\label{#2}%
	\end{align}%
}

% Comando para múltiplas equações alinhadas sem numeração
\newcommand{\sistemasem}[1]{%
	% #1: conteúdo do sistema de equações
	\begin{align*}%
		#1%
	\end{align*}%
}

% Comando para equação com quebra de linha
\newcommand{\equacaoquebra}[2]{%
	% #1: conteúdo da equação com quebras \\
	% #2: label para referência
	\begin{multline}%
		#1%
		\label{#2}%
	\end{multline}%
}

% Comando para equação em caixa (destacada)
\newcommand{\equacaocaixa}[2]{%
	% #1: conteúdo da equação
	% #2: label para referência
	\begin{equation}%
		\boxed{#1}%
		\label{#2}%
	\end{equation}%
}

%%
%% --- Comandos para referências cruzadas otimizadas ---
%%

% Comandos para referências múltiplas
\newcommand{\reffigs}[1]{Figuras~\ref{#1}}% Para múltiplas figuras
\newcommand{\reftabs}[1]{Tabelas~\ref{#1}}% Para múltiplas tabelas
\newcommand{\refeqs}[1]{Equações~\ref{#1}}% Para múltiplas equações

% Comandos para referências com página
\newcommand{\reffigpag}[1]{Figura~\ref{#1} na página~\pageref{#1}}
\newcommand{\reftabpag}[1]{Tabela~\ref{#1} na página~\pageref{#1}}
\newcommand{\refeqpag}[1]{Equação~\ref{#1} na página~\pageref{#1}}

% Comandos para referências abreviadas (uso em parênteses)
\newcommand{\reffigabrev}[1]{Fig.~\ref{#1}}
\newcommand{\reftababrev}[1]{Tab.~\ref{#1}}
\newcommand{\refeqabrev}[1]{Eq.~\ref{#1}}

% Comando genérico para referência personalizada
\newcommand{\refcustom}[2]{#1~\ref{#2}}% #1: texto, #2: label

%%
%% --- Comandos auxiliares para formatação de elementos ---
%%

% Comando para centralizar figuras e tabelas
\newcommand{\centrar}[1]{%
	\begin{center}%
		#1%
	\end{center}%
}

% Comando para fonte pequena em legendas (se necessário)
\newcommand{\legendapequena}[1]{%
	{\small #1}%
}

% Comando para espaçamento personalizado antes/depois de elementos
\newcommand{\espacoantes}[1]{\vspace{#1}}
\newcommand{\espacodepois}[1]{\vspace{#1}}

% Comando para quebra de página antes de elemento importante
\newcommand{\novapagina}{\clearpage}

%%
%% --- Configurações específicas para elementos flutuantes ---
%%

% Configurações para melhor posicionamento de figuras e tabelas
\renewcommand{\topfraction}{0.9}% Máximo da página que pode ser ocupado por floats no topo
\renewcommand{\bottomfraction}{0.8}% Máximo da página que pode ser ocupado por floats na base
\setcounter{topnumber}{2}% Máximo de floats no topo da página
\setcounter{bottomnumber}{2}% Máximo de floats na base da página
\setcounter{totalnumber}{4}% Máximo de floats por página
\renewcommand{\dbltopfraction}{0.9}% Para floats de duas colunas
\renewcommand{\textfraction}{0.07}% Mínimo de texto que deve haver na página

% Espaçamento entre floats e texto
\setlength{\floatsep}{12pt plus 2pt minus 2pt}% Entre floats
\setlength{\textfloatsep}{20pt plus 2pt minus 4pt}% Entre float e texto
\setlength{\intextsep}{14pt plus 4pt minus 4pt}% Ao redor de floats no meio do texto

%%
%% --- Validação e mensagens de erro para elementos comuns ---
%%

% Comando para validar se label foi definido
\newcommand{\@validarlabel}[1]{%
	\@ifundefined{r@#1}{%
		\ClassWarning{UnB-PPGT}{Label '#1' nao definido. Verifique se o label foi usado corretamente}%
	}{}%
}

% Comando para validar se arquivo de imagem existe
\newcommand{\@validarimagem}[1]{%
	\IfFileExists{#1}{}{%
		\IfFileExists{img/#1}{}{%
			\ClassWarning{UnB-PPGT}{Arquivo de imagem '#1' nao encontrado}%
		}%
	}%
}

%%
%% --- Fim dos comandos para elementos comuns ---
%%

	\@ifundefined{XeTeXversion}%
	{%suporte para fonte Adobe Minion Pro - pacote LaTeX
		\@ifpackageloaded{MinionPro}{}{%
			\newcommand{\figureversion}[1]{\relax}
		}
		\newenvironment{linfig}{\figureversion{lining}}{\figureversion{text}}%
		\newenvironment{tabfig}{\figureversion{tabular}}{\figureversion{proportional}}%
		\newcommand*{\textlinf}[1]{\figureversion{lining}#1\figureversion{text}}%
		\newcommand*{\texttabf}[1]{\figureversion{tabular}#1\figureversion{proportional}}%
		\newcommand*{\@tablefigures}{\figureversion{lining,tabular}}%
	}%
	{%suporte fontspec - XeTeX
 		\def\@textlinf{\protect\addfontfeatures{Numbers=Lining}}%
 		\def\@texttabf{\protect\addfontfeatures{Numbers=Monospaced}}%
		\newenvironment{linfig}{\bgroup\@textlinf}{\egroup}%
		\newenvironment{tabfig}{\bgroup\@texttabf}{\egroup}%
		\newcommand*{\textlinf}[1]{{\@textlinf #1}}%
		\newcommand*{\texttabf}[1]{{\@texttabf #1}}%
		\newcommand*{\@tablefigures}{\addfontfeature{Numbers={Lining,Monospaced}}}%
		\newcommand*{\slashedzero}{{\addfontfeature{Numbers={Lining,SlashedZero}}0}}%
	}%

	\if@baselineskip
		%para manter o valor inicial
		\newdimen\@oldbaseline

		%define o espaçamento pelo baselinekip
		\@oldbaseline=\baselineskip
		\newcommand{\setstretch}[1]{\setlength{\baselineskip}{#1\@oldbaseline}}
		\newcommand{\singlespacing}{\setstretch{1}}
		\newcommand{\onehalfspacing}{\setstretch{1.35}}
		\newcommand{\doublespacing}{\setstretch{1.7}}
	\fi

	% defaultspacing já foi definido anteriormente
	\defaultspacing% chamada inicial

	% Validação de membros da banca (usando novo sistema)
	\@validarnumeromembrosbanca%

	% Validação já foi executada no AtBeginDocument
	% \@conteudoPreTextual% - comando removido pois não está definido
}
%%%%%
%%%%%%%%%%%%%%%%%%%%%
%%%%% Novos Comandos %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@texpath{tex}%
\newcommand{\@erroSeNaoExiste}[1]{%
    \IfFileExists{#1}{}%
	    {\ClassError{UnB-PPGT}%
	        {Arquivo "#1" nao encontrado.}
	        {O arquivo "#1" eh necessário.}}%
}%

\newcommand{\@inputTeXFile}[1]{%
	\@erroSeNaoExiste{\@texpath/#1}%
	\input{\@texpath/#1}%
}%
\newcommand{\@IncluirSecao}[1]{%
	\begin{#1}%
		\@inputTeXFile{#1}%
	\end{#1}%
}%

% Comando para incluir seção opcional (só inclui se arquivo existir)
\newcommand{\@IncluirSecaoOpcional}[1]{%
	\IfFileExists{\@texpath/#1.tex}{%
		\begin{#1}%
			\@inputTeXFile{#1}%
		\end{#1}%
	}{%
		% Arquivo não existe, apenas emite aviso
		\ClassInfo{UnB-PPGT}{Arquivo opcional "\@texpath/#1.tex" nao encontrado. Secao #1 sera omitida.}%
	}%
}%

\newcommand{\capitulo}[2]{%
	\chapter{#2}%
	\label{#1}%
	\@inputTeXFile{#1}%
}%

\newif\if@PosTextualNaoIncluso%
\@PosTextualNaoInclusotrue%

\newcounter{apendice}\setcounter{apendice}{0}%
\newcommand{\apendice}[2]{%
	\addtocounter{apendice}{1}%
	\ifnum\value{apendice}<2%
		\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%
	    \appendix%
	    \addcontentsline{toc}{chapter}{\appendixname}%
	\fi%
	\capitulo{#1}{#2}%
}%

\newcounter{anexo}\setcounter{anexo}{0}%
\newcommand{\anexo}[2]{%
	\addtocounter{anexo}{1}%
	\ifnum\value{anexo}<2%
		\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%
		\renewcommand{\appendixname}{Anexo}%
		\ifnum\value{apendice}<1\appendix\fi%
		\renewcommand{\thechapter}{\Roman{anexo}}%
	    \addcontentsline{toc}{chapter}{\appendixname}%
	\fi%
	\capitulo{#1}{#2}%
}%

% Comando legado para compatibilidade (agora usa o sistema aprimorado)
\newcommand{\@listofacronyms}{%
	\@listadesiglas%
}%

\newcommand{\@conteudoPreTextual}{%
	\maketitle%
	\if@qualificacao\else%
		% Inclui páginas pré-textuais opcionais apenas se não for qualificação
		\@IncluirSecaoOpcional{dedicatoria}%
		\@IncluirSecaoOpcional{agradecimentos}%
	\fi%
	% Resumo e abstract são sempre incluídos
	\@IncluirSecao{resumo}%
	\selectlanguage{american}%
	\@IncluirSecao{abstract}%
	\selectlanguage{brazil}%
    \selectbiblanguage{brazil}%
	\@erroSeNaoExiste{bibliografia.bib}%

	% Sumário
	\tableofcontents%
	
	% Listas automatizadas com formatação específica do PPGT
	\if@incluirlistafiguras\@listadefigurasppgt\fi%
	\if@incluirlistatabelas\@listadetabelasppgt\fi%
	\if@incluirlistasiglas\@listadesiglas\fi%

	\textual%
}%

\newcommand{\@conteudoPosTextual}{%
	\@PosTextualNaoInclusofalse%
    \postextual%
	\bibliographystyle{babunsrt}%
    \bibliography{bibliografia}%
}%

% Comando \sigla já definido anteriormente com melhorias

\newcommand{\@referencia}[2]{#1~\ref{#2}}%
\newcommand{\refCap}[1]{\@referencia{Capítulo}{#1}}%
\newcommand{\refCaps}[2]{\@referencia{Capítulos}{#1}\ a \ref{#2}}%
\newcommand{\refFig}[1]{\@referencia{Figura}{#1}}%
\newcommand{\refFigs}[2]{\@referencia{Figuras}{#1}\ a \ref{#2}}%
\newcommand{\refEq}[1]{\@referencia{Equação}{#1}}%
\newcommand{\refEqs}[2]{\@referencia{Equações}{#1}\ a \ref{#2}}%
\newcommand{\refTab}[1]{\@referencia{Tabela}{#1}}%
\newcommand{\refTabs}[2]{\@referencia{Tabelas}{#1}\ a \ref{#2}}%
\newcommand{\refApendice}[1]{\@referencia{Apêndice}{#1}}%
\newcommand{\refAnexo}[1]{\@referencia{Anexo}{#1}}%

\newcommand{\figuraBib}[6][!ht]{%
	\begin{figure}[#1]%
		\begin{center}%
			\includegraphics[#6]{#2}%
			\caption[#3.]{#3\ifx#4\empty\else~(Fonte: ~\cite{#4})\fi.\label{#5}}%
		\end{center}%
	\end{figure}%
}%
\newcommand{\figura}[5][!ht]{%
	\figuraBib[#1]{#2}{#3}{}{#4}{#5}%
}%

\newcommand{\equacao}[2]{%
	\begin{equation}%
		\label{#1}%
		\begin{gathered}%
			#2
		\end{gathered}%
	\end{equation}%
}%

\newcommand{\tabelaBib}[5]{%
	\begin{table}%
		\centering%
		\caption[#1.]{#1\ifx#2\empty\else~(Fonte: ~\cite{#2})\fi.\label{#3}}%
		\begin{tabular}{#4}%
			#5
		\end{tabular}%
	\end{table}%
}%

\newcommand{\tabela}[4]{%
	\tabelaBib{#1}{}{#2}{#3}{#4}%
}%

\endinput