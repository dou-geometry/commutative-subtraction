%%% Compile Command
% ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*
% or by chain
% uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*

\documentclass[11pt,a4paper,dvipdfmx]{ujarticle}
\usepackage{preamble}

\author{}
\title{\jp{可換的な引き算}}
\和暦

\begin{document}
\maketitle
\tableofcontents

\begin{code}
module Op where
\end{code}

\begin{comment} % Following is not shown in LaTeX doc
\begin{code}
notImplemented = undefined -- Comment out this line in production
\end{code}
\end{comment}

\section{Implementation of Subtraction}

\begin{code}
data R = R Double deriving Show
\end{code}

Defining subtraction as following, hence satisfying $a-b=b-a$.

\begin{code}
instance Num R where
    (-) (R a) (R b) = case a>=b of
                True -> R $ a-b
                False -> R $ b-a
    fromInteger a = R $ abs x 
                    where x = fromIntegral a::Double
    signum (R a)
            | a==0 = 0
            | otherwise = 1
    abs a = a
    (*) _ _ = notImplemented
\end{code}

\section{Implementation of Addition}

\subsection{Non-commutative Addition}

Now let's try to implement (+) normally

\begin{spec}
    (+) (R a) (R b) = R (a+b)
\end{spec}

But such implementation yields a wierd behaviour where (let a>b) then

\begin{math}
    b+(a-b)=a \\
    a+(a-b)\neq b
\end{math}

Which makes the operation non-commutative.

\subsection{Commutative Addition}

So Let's first find a way to

\newpage

Extended Definition of Real Number Space

\begin{code}
data R1 = R1 R Bool deriving Show
data R2 = R2 R Double deriving Show
\end{code}

\begin{code}
instance Num R1 where
    (-) a b = notImplemented
\end{code}

\begin{code}
    abs (R1 a _) = R1 a False
    fromInteger a
                | a>=0 = R1 (R x) False
                | a <0 = R1 (R x) True
                    where x = fromIntegral a::Double
    signum (R1 (R a) d)
                | a==0 = 0
                | d==True = -1
                | d==False = 1
    (+) a b = notImplemented
    (*) _ _ = notImplemented
\end{code}


\appendix

\end{document}
