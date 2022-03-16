
\ProvidesClass{ucalgmthesis}[2019/10/24
  University of Calgary Memoir Thesis Class]

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

%% Options for spacing (default is 1.5 spacing)

% All pages must be double or one-and-one-half spaced (Note: this
% includes your Abstract, Acknowledgments, Dedications, etc.).  You
% can use single-line spacing if you have a long Table of Contents,
% List of Tables, List of Figures, or for long quotes in the body of
% your thesis). Use \verb|memoir|'s \verb|SingleSpace| environment to
% typeset, e.g., a quotation single spaced.

\DeclareOption{singlespaced}{\AtEndOfClass{\SingleSpacing}}
\DeclareOption{onehalfspaced}{\AtEndOfClass{\OnehalfSpacing}}
\DeclareOption{doublespaced}{\AtEndOfClass{\DoubleSpacing}}

% Options for typefaces

              
% options for headings
\DeclareOption{plain}{\AtBeginDocument{\pagestyle{plain}}}
\DeclareOption{headers}{\AtBeginDocument{\pagestyle{ucalgaryruled}}}


\DeclareOption{fullpage}{
  \AtEndOfClass{\fullpagethesis}}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% By default, typeset with one half spacing, no running heads

\ExecuteOptions{singlespaced,plain}

\PassOptionsToClass{12pt}{memoir}
\ProcessOptions

% now load memoir

\LoadClass{memoir}

\newcommand*{\fixmdhrulefill}{\def\hrulefill{\leavevmode\leaders \hrule height \rulethickness \hfill\kern\z@}}

% \makethesistitle formats the title page

\newcommand{\makethesistitle}{
  \begin{titlingpage*}
    \begin{center}\begin{DoubleSpace}
      UNIVERSITY OF CALGARY \\
      \vfill
      {\@title \par}
      \vfill        
      by \\
      \vfill
      {\@author \par}
      \vfill
      {A \@thesis} \par
      SUBMITTED TO THE FACULTY OF GRADUATE STUDIES \par
      IN PARTIAL FULFILLMENT OF THE REQUIREMENTS FOR THE \par
      {DEGREE OF \@degree}
      \vfill
      \@dept \par
      \vfill
      {CALGARY, ALBERTA \par}
      {{\@monthname}, {\@gradyear} \par}
      \vfill
      {\copyright\ {\@author}~{\@gradyear} \par}
    \end{DoubleSpace}\end{center}
  \end{titlingpage*}
}

\newcommand{\dedication}[1]{%
  {\clearpage\thispagestyle{plain}\mbox{}\vfill
    \phantomsection
    \addcontentsline{toc}{chapter}{Dedication}%
    \centering #1 \par\vfill\clearpage}}

% Commands for the thesis title page

\def\dept#1{\gdef\@dept{\uppercase{#1}}}
\let\prog\dept % compatibility with ucalgthes class
\def\degree#1{\gdef\@degree{\uppercase{#1}}}
\def\monthname#1{\gdef\@monthname{#1}}
\def\gradyear#1{\gdef\@gradyear{#1}}
\let\thesisyear\gradyear
\def\thesis#1{\gdef\@thesis{\uppercase{#1}}}
\thesis{Thesis}

% Ruled pagestyle according to rules: folio centered in footer,
% headers with a rule. Chapter number and title flush right.  Also
% works twosided, in which case the verso headers hold the chapter
% title and the recto headers the section title.

\copypagestyle{ucalgaryruled}{ruled}
\if@twoside
    \makeevenhead{ucalgaryruled}{\leftmark}{}{}
    \makeoddhead{ucalgaryruled}{}{}{\rightmark}
\else
    \makeoddhead{ucalgaryruled}{}{}{\leftmark}
\fi

\makeoddfoot{ucalgaryruled}{}{\thepage}{}
\makeevenfoot{ucalgaryruled}{}{\thepage}{}

% Since the TOC must include everything in the front matter, the
% default TOC style looks odd. We reduce the space between chapter
% entries and add dotted leaders also to chapters.

\setlength{\cftbeforechapterskip}{1pt plus 0pt}

\renewcommand{\cftchapterleader}{\normalfont\cftdotfill{\cftsectiondotsep}}
\renewcommand{\contentsname}{Table of Contents}

% we need toc, lof, lot to begin on a new page

\def\tocheadstart{\clearpage}
\def\lofheadstart{\clearpage}
\def\lotheadstart{\clearpage}
