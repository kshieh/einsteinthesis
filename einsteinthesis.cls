%% einsteinthesis.cls 2016-05-30
%% Copyright (C) 1988-2016 Daniel Gildea, BBF, Ethan Munson, Paul Vojta,
%% Kevin Shieh.
%
% This work is a modified version of UCBTHESIS to conform to the guidelines
% for a Ph.D. thesis in the Graduate Division of Medical Sciences at the
% Albert Einstein College of Medicine.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work consists of the files einsteinthesis.cls, README,
% thesis.tex, abbreviations.tex, abstract.tex, chap1.tex, chap2.tex, and
% references.bib.

%%% ====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "einsteinthesis.cls",
%%%     version         = "1.0",
%%%     date            = "30 May 2016",
%%%     license         = "LPPL",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX, einsteinthesis",
%%%     docstring       = "This file is the main file for the einsteinthesis
%%%                        class, which is intended to meet the requirements
%%%                        for Ph.D. theses at the Albert Einstein College of
%%%                        Medicine.
%%%			   It is based off of the UCBTHESIS class.
%%%  }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{einsteinthesis}[2016/05/30 v1.0 Albert Einstein College of Medicine Thesis Class]

%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%
% Option values are now declared first thing.  Defaults are set to
% 12 point, onesided, phd (i.e., not masters), final (i.e., not draft) mode
% Only the phd/masters options are handled in this file (other than changing
% default values).

\newcommand\@masters{}
\DeclareOption{phd}{\renewcommand\@masters{0}}
\DeclareOption{masters}{\renewcommand\@masters{1}}
\ExecuteOptions{phd}

%  The thesis may be one- or two-sided.

\newcommand\thes@sidedness{-1}
\DeclareOption{oneside}
  {\renewcommand\thes@sidedness{1}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{twoside}
  {\renewcommand\thes@sidedness{2}\PassOptionsToClass{\CurrentOption}{memoir}}

%  Changing the default point size from 10pt to 12pt uses a similar procedure,
%  but it's messier.

\newcommand\thes@ptsize{0}
\DeclareOption{9pt}
  {\renewcommand\thes@ptsize{9}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{10pt}
  {\renewcommand\thes@ptsize{10}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{11pt}
  {\renewcommand\thes@ptsize{11}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{12pt}
  {\renewcommand\thes@ptsize{12}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{14pt}
  {\renewcommand\thes@ptsize{14}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{17pt}
  {\renewcommand\thes@ptsize{17}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{20pt}
  {\renewcommand\thes@ptsize{20}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{25pt}
  {\renewcommand\thes@ptsize{25}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{30pt}
  {\renewcommand\thes@ptsize{30}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{36pt}
  {\renewcommand\thes@ptsize{36}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{48pt}
  {\renewcommand\thes@ptsize{48}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{60pt}
  {\renewcommand\thes@ptsize{60}\PassOptionsToClass{\CurrentOption}{memoir}}
\DeclareOption{*pt}
  {\renewcommand\thes@ptsize{99}\PassOptionsToClass{\CurrentOption}{memoir}}

% Other options are passed on to the memoir class.

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% The \ProcessOptions command causes the execution of every option command
% FOO which is declared and for which the user typed the FOO option in his
% \documentclass.  For every undeclared option BAR there will be a warning
% message. (BBF 10/31/94)

\ProcessOptions\relax

% Take care of changed defaults

\ifnum\thes@sidedness<0
  \PassOptionsToClass{oneside}{memoir}
  \renewcommand\thes@sidedness{1}
\fi

\ifnum\thes@ptsize=0
  \PassOptionsToClass{12pt}{memoir}
  \renewcommand\thes@ptsize{12}
\fi

% Now load the memoir class, and configure it appropriately.

\LoadClass{memoir}

%\setlrmarginsandblock{1in}{*}{*}
%  \@tempdima=1in  \advance\@tempdima 25pt \advance\@tempdima\normalbaselineskip
%  \@tempdimb=.75in  \advance\@tempdimb 30pt
%\setulmarginsandblock{\@tempdima}{\@tempdimb}{*}
%\setlrmarginsandblock{1.5in}{1in}{*}
%\setulmarginsandblock{1in}{1in}{*}
%\setlength{\topmargin}{2in}

\AtBeginDocument{\checkandfixthelayout}

% The Grad. Division requires that "Placement of page numbers must be
% consistent throughout."

\pagestyle{simple}
\aliaspagestyle{book}{simple}
\aliaspagestyle{part}{simple}
\aliaspagestyle{chapter}{simple}
\aliaspagestyle{title}{simple}

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.

\newcommand\ssp{\SingleSpacing}
\newcommand\dsp{\setSpacing{1.37}}

% Table of contents, lists of figures, and lists of tables should always
% be single-spaced.  If one wants them to be double-spaced instead (in a
% double-spaced document), the original macros are available as
% \memoirtableofcontents, \memoirlistoffigures, and \memoirlistoftables.

\let\memoirtableofcontents=\tableofcontents
\renewcommand\tableofcontents{\begin{SingleSpace}\memoirtableofcontents
  \end{SingleSpace}}

\let\memoirlistoffigures=\listoffigures
\renewcommand\listoffigures{\begin{SingleSpace}\memoirlistoffigures
  \end{SingleSpace}}

\let\memoirlistoftables=\listoftables
\renewcommand\listoftables{\begin{SingleSpace}\memoirlistoftables
  \end{SingleSpace}}

% \smallssp is used to produce tabular environments in the small font.
% This is required because single-spacing requires a change in font size.
% \scriptsizessp is a still smaller version of the same thing.
% Removed 09/2011

% \def\smallssp{\small\SingleSpacing}
% \def\scriptsizessp{\scriptsize\SingleSpacing}


%  Masters theses may not be called dissertations
%

\newcommand\@dissertation{\ifnum\@masters=0
  dissertation
\else
  thesis
\fi}


% PREPARING A FOREIGN LANGUAGE VERSION:
%
% This document class is for documents prepared in the English language.
% To prepare a version for another language, various English words must
% be replaced.  Many of the English words that require replacement are
% indicated in the documentation for the memoir class, currently in
% Section 18.20, Words and Phrases.
%
% Other English words that need replacement can be found in the macros
% supporting the title and approval pages.
%

% acknowledge environment:
\newcommand\acknowledgename{Acknowledgments}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.

% The year the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% The semester (Fall or Spring) the degree will be officially conferred
\def\degreesemester#1{\gdef\@degreesemester{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The Joint Institution of your degree (optional, and rare)
\def\jointinstitution#1{\gdef\@jointinst{#1}}

% All previous degrees: one per line in chronological order
% This is no longer used, but is provided for backwards compatibility.
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}\gdef\@chairtitle{Chair}}

% The name of your committee's secondary chair (for chair + co-chair)
\def\cochair#1{\gdef\@cochair{#1}}

% The names of your committee's co-chairs (for two equal co-chairs)
\def\cochairs#1#2{\gdef\@chair{#1}\gdef\@cochair{#2}\gdef\@chairtitle{Co-chair}}

% The names of your other committee members, one per line
\def\othermembers#1{\gdef\@othermembers{#1}}

% The number of committee members
\def\@numberofmembers{3}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

% The name of your degree's designated emphasis (optional, and rare)
\def\emphasis#1{\gdef\@emphasis{#1}}

% The name of the university
\def\university#1{\gdef\@university{#1}}

% The date the thesis is submitted
\def\degreedate#1{\gdef\@degreedate{#1}}

% The alwayssingle environment ensures that front matter is always
% single column even in a double-column document.

\newenvironment{alwayssingle}
  {\if@twocolumn\@restonecoltrue\onecolumn \else \@restonecolfalse\newpage \fi}
  {\if@restonecol \twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros.

% Set the font that will be used in the front matter headings
\def\fmfont{\fontsize\@xiipt{14.5}\selectfont}
\def\fmsmallfont{\fontsize\@xiipt{14pt}\selectfont}

\def\maketitle{
{\ssp
  \makeatletter
    \setlength{\@tempdima}{28pt}\advance\@tempdima-\baselineskip
    \parskip=\@tempdima minus 4pt
  \makeatother
\begin{alwayssingle}
  \hrule height 0pt
  % Fix things so that they're vertically centered
  % \@tempdima = 2 * ((\stockheight-\textheight) / 2 - \uppermargin) - \topskip
    \@tempdima=\stockheight
    \advance\@tempdima-\textheight
    \advance\@tempdima-2\uppermargin
    \advance\@tempdima-\topskip
    \vspace{\@tempdima}
  \vfill
  \let\footnotesize\small
  \let\footnoterule\relax
  \thispagestyle{empty}			% Hide page number

  \begin{center}
    \fmfont
    %\textbf{\@title}\par
    \MakeUppercase{\@title}\par
    \vspace{20pt minus 4pt}
    by\par
    \vspace{20pt minus 4pt}
    {\@author}\par
    \vspace{36pt minus 8pt}
    \begin{tabularx}{\textwidth}{X X}
    	Candidate & Thesis Advisor:\\
    	\\\\\\
    	\line(1,0){150} & \line(1,0){150}\\
    	Signature & Signature\\
    	\\\\
    	\underline{Student} & \underline{Mentor}\\
    	Name & Name\\
    	\\\\
    	& \underline{Mentor's Title}\\
    	& Title
    \end{tabularx}\par
    \vspace{28pt minus 8 pt}
    Submitted in partial fulfillment of the requirements for the\\
    degree of \ifdefined\@jointinst
    Joint {\@degree}\\with {\@jointinst}\\
    \else
    {\@degree}\\
    \fi
    in the Graduate Division of Medical Sciences\par
    \vspace{10pt minus 4pt}
    {\expandafter{\@university}}\\
    {\@degreedate}
    \vspace{10pt minus 5pt}
  \end{center}
  \vfill
  \hrule height 0pt
\end{alwayssingle}

\setcounter{footnote}{0}
}}

% APPROVALPAGE
%
% The \approvalpage macro emits a UC-approved approval page ready for
% your committee's signature.  It is not an automatic part of the
% output because it only needs to be printed out once (and should not
% be present in the electronically submitted part).  It requires that
% the \year, \author, \title, and \campus macros have been defined.

\def\approvalpage{%
\ifnum\@masters=0
  \ifdraftdoc\else
    \ClassWarning{ucbthesis}%
      {The final submitted version should not have an approval page}%
\fi\fi

\begin{alwayssingle}
\thispagestyle{empty}

\fmfont \noindent
The \@dissertation of {\@author}, titled {\@title}, is approved:

\vfil
{\baselineskip=36pt
\settowidth\@tempdima{\ifdefined\@cochair Co-chair\else\@chairtitle\fi\quad}
\hbox to\textwidth{\raise 3pt\hbox to\@tempdima{\@chairtitle\hfil}%
  \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\hbox to\textwidth{\raise 3pt\hbox to\@tempdima{\ifdefined\@cochair Co-chair\fi
    \hfil}%
  \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\hbox to\textwidth{\hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\ifnum \@numberofmembers > 3
\hbox to\textwidth{\hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\fi
\ifnum \@numberofmembers > 4
\hbox to\textwidth{\hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\fi
\ifnum \@numberofmembers > 5
\hbox to\textwidth{\hskip\@tempdima \leaders\hrule\hskip 0pt plus .75fill\qquad
  \raise 3pt\hbox{Date}\quad \leaders\hrule\hskip 0pt plus .25fill}
\fi
}
\vfil
\begin{center}
{\fmfont {\@university}}
\end{center}
\end{alwayssingle}
}

% COPYRIGHTPAGE
%
% While it's technically optional, you probably want a copyright page.
% This is a macro, not an environment, because it can be generated
% with the \title, \author, and \year macros.

\def\copyrightpage{
\begin{alwayssingle}
\thispagestyle{empty}
\begin{center}
{\fmfont
{\bfseries\@title}\par
\vspace{1in}
Copyright \@degreeyear\par
by\par
\@author}
\end{center}
\end{alwayssingle}}


% ABSTRACT
%
% The ABSTRACT requires definition  of the \title, \author, \degree,
% \field, \campus, and \chair macros.

% The abstract title must be in capital letters.
\renewcommand{\abstractname}{ABSTRACT}

\def\abstract{
\begin{alwayssingle}
\begin{center}
{\fmfont
{\bfseries \abstractname}\par
\vspace{.5in}
\@title\par
\vspace{.1in}
\@author}
\vspace{.1in}
\end{center}}

\def\endabstract{\par\vfil\null\end{alwayssingle}
}

% The abstract is no longer signed (12/2009)
%
% \def\abstractsignature{
% \hspace*{\fill}
% \begin{minipage}[t]{3.25in}
% \addtolength{\baselineskip}{-.5\baselineskip}
% \vspace{1.7cm}
% \rule{3.2in}{.5pt}\\
% \@chair\\
% Dissertation Committee Chair
% \end{minipage}}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
  {\begin{alwayssingle}}
  {\end{alwayssingle}}

% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}
  {\begin{alwayssingle}
    \begin{center}
    {\large \bfseries \acknowledgename}
    \end{center}
  }
  {\end{alwayssingle}}

% LIST OF ABBREVIATIONS
%
% The List of Abbreviations should go at the end of the thesis, just before
% the appendix.
\newenvironment{abbreviations}
  {\begin{alwayssingle}
    \pagestyle{simple}
    \begin{center}
    {\large \bfseries List of Abbreviations}
    \end{center}
  }
  {\end{alwayssingle}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting with number 1). Afterward, the
% main matter should be in Arabic numerals, starting with number 1.

\renewenvironment{frontmatter}
  {\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
  {\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}


% Rename environments to allow them to switch back to double spacing

\ifnum\@masters>1

  % These were taken from memoir.cls 2010/09/19
  \newenvironment{memoirquotation}%
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}%
               {\endlist}

  \newenvironment{memoirquote}%
               {\list{}{\rightmargin\leftmargin}%
                \item[]}%
               {\endlist}

  \newenvironment{memoirverse}[1][\linewidth]{%
    \refstepcounter{verse}%
    \setcounter{poemline}{0}\refstepcounter{poemline}%
    \setcounter{vslineno}{1}%
    \let\\=\@vscentercr
    \list{}{\itemsep     \z@
          \itemindent  -\vindent
          \listparindent\itemindent
          \leftmargin   \vleftmargin
          \parsep       \stanzaskip
          \ifdim #1<\linewidth%   %% short line
            \rightmargin        \z@
            \leftmargin         \linewidth
            \advance\leftmargin -#1\relax
            \advance\leftmargin -0.5\leftmargin
            \advance\leftmargin \vindent
          \else
            \ifdim #1>\linewidth%  %% long line
              \rightmargin \z@
              \leftmargin  \vindent
            \else%                   %% default
              \rightmargin \leftmargin
              \advance\leftmargin \vindent
            \fi
          \fi}
    \item[]}{\endlist}

  \ifdraftdoc\else

    \renewenvironment{quotation}%
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \SingleSpacing\item[]}%
               {\endlist}

    \renewenvironment{quote}%
               {\list{}{\rightmargin\leftmargin}%
                \SingleSpacing\item[]}%
               {\endlist}

    \renewenvironment{verse}[1][\linewidth]{%
      \refstepcounter{verse}%
      \setcounter{poemline}{0}\refstepcounter{poemline}%
      \setcounter{vslineno}{1}%
      \let\\=\@vscentercr
      \list{}{\itemsep     \z@
          \itemindent  -\vindent
          \listparindent\itemindent
          \leftmargin   \vleftmargin
          \parsep       \stanzaskip
          \ifdim #1<\linewidth%   %% short line
            \rightmargin        \z@
            \leftmargin         \linewidth
            \advance\leftmargin -#1\relax
            \advance\leftmargin -0.5\leftmargin
            \advance\leftmargin \vindent
          \else
            \ifdim #1>\linewidth%  %% long line
              \rightmargin \z@
              \leftmargin  \vindent
            \else%                   %% default
              \rightmargin \leftmargin
              \advance\leftmargin \vindent
            \fi
          \fi}
    \SingleSpacing\item[]}{\endlist}

  \fi
\fi

% smalltabular and smalltabular* are alternative tabular environments
% in the \small font.  They are required because single-spacing implies a
% change of font to a particular size.
% EVM, 7/20/93
% Removed 09/2011

% \def\smalltabular{\par\small\SingleSpacing\let\@halignto\@empty\@tabular}
% \let\endsmalltabular = \endtabular

% \@namedef{smalltabular*}#1{\par\small\SingleSpacing
%  \setlength\dimen@{#1}%
%    \edef\@halignto{to\the\dimen@}\@tabular}
% \expandafter \let \csname endsmalltabular*\endcsname = \endtabular

% \scriptsizetabular and \scriptsizetabular* are analogs of \smalltabular

% \def\scriptsizetabular{\par\scriptsize\SingleSpacing
%   \let\@halignto\@empty\@tabular}
% \let\endscriptsizetabular = \endtabular

% \@namedef{scriptsizetabular*}#1{\par\scriptsize\SingleSpacing
%  \setlength\dimen@{#1}%
%    \edef\@halignto{to\the\dimen@}\@tabular}
% \expandafter \let \csname endscriptsizetabular*\endcsname = \endtabular

\endinput
