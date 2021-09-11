;;-------------------------
;; MANDATORY PACKAGES
;;-------------------------

;; installing and configure STRAIGHT
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; use use-package along with straight
(straight-use-package 'use-package)
;; make `use-package` to automatically install all of your packages 
;; without the need for adding `:straight t`.
(setq straight-use-package-by-default t)

;; Installing ORG
(use-package org)

;; Installing and configure ORG-CONTRIB 
(use-package org-contrib
  :config
  (require 'ox-extra)
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))

;; Installing ORG-REF
(use-package 'org-ref)

#+SETUPFILE: ./lib/thesis.setup

#+INCLUDE:          ./lib/code.inc
#+CALL:             init()

(eval-after-load "org"
  (use-package ob-async
    :ensure t
    :init (require 'ob-async)))
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil
      org-src-tab-acts-natively t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (emacs-lisp . t)
   (R . t)
   ))

(use-package org-ref
  :config
  (setq reftex-default-bibliography '("/path/to/your/bibliography"))
  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes "/path/to/your/bib/notes"
        org-ref-default-bibliography '("/path/to/your/bibliography")
        org-ref-pdf-directory "/path/to/your/papers"
        bibtex-dialect                    'biblatex
        ;; Optimize for 80 character frame display
        bibtex-completion-display-formats
        '((t . "${title:46} ${author:20} ${year:4} ${=type=:3}${=has-pdf=:1}${=has-note=:1}"))
        bibtex-completion-bibliography   "/path/to/your/bibliography"
        bibtex-completion-library-path    "/path/to/your/bib/notes"
        bibtex-completion-pdf-symbol ""
        bibtex-completion-notes-symbol ""
        ))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("elsarticle"
                 "\\documentclass{elsarticle}
   [NO-DEFAULT-PACKAGES]
   [PACKAGES]
   [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("mimosis"
                 "\\documentclass{mimosis}
   [NO-DEFAULT-PACKAGES]
   [PACKAGES]
   [EXTRA]
  \\newcommand{\\mboxparagraph}[1]{\\paragraph{#1}\\mbox{}\\\\}
  \\newcommand{\\mboxsubparagraph}[1]{\\subparagraph{#1}\\mbox{}\\\\}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\mboxparagraph{%s}" . "\\mboxparagraph*{%s}")
                 ("\\mboxsubparagraph{%s}" . "\\mboxsubparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '( "koma-article"
                  "\\documentclass{scrartcl}"
                  ( "\\section{%s}" . "\\section*{%s}" )
                  ( "\\subsection{%s}" . "\\subsection*{%s}" )
                  ( "\\subsubsection{%s}" . "\\subsubsection*{%s}" )
                  ( "\\paragraph{%s}" . "\\paragraph*{%s}" )
                  ( "\\subparagraph{%s}" . "\\subparagraph*{%s}" )))
  )

;; Coloured LaTeX using Minted
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("latexmk -pdflatex='xelatex -shell-escape -interaction nonstopmode' -pdf -bibtex -output-directory=%o -f %f"))

;; syntex-highlighting
(use-package htmlize)
;;Don’t include a footer...etc in exported HTML document.
(setq org-html-postamble nil)
(setq org-src-window-setup 'current-window)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(custom-set-variables
 '(org-export-backends '(ascii beamed html calendar latex DOT)))

(defun enable-writing-minor-modes ()
  "Enable flyspell and visual line mode for calling from mode hooks"
  (visual-line-mode 1)
  (flyspell-mode 1))

(use-package org
  :hook (org-mode . enable-writing-minor-modes))

#+TITLE:            my org thesis
#+SUBTITLE:         it is great to use Emacs
#+LATEX_CLASS:      mimosis
#+latex_header:     \KOMAoptions{headings=small,fontsize=12,DIV=12}
#+SETUPFILE:        ./lib/thesis.setup
#+INCLUDE:          ./lib/gls_ac.setup
#+INCLUDE:          ./lib/code.inc
#+CALL:             init()
#+EXCLUDE_TAGS:     journal noexport ignore
#+EXPORT_FILE_NAME: org-master.pdf
# ---------------------------------------------------------------------
#+INCLUDE: "./title.org"
#+latex_header: \pagenumbering{arabic}

#+begin_export latex
 \listoffigures
 \listoftables
\printglossaries
\appendix
#+end_export
#+begin_export latex
 \bibliographystyle{unsrt}
 \bibliography{./lib/refs.bib}{}
#+end_export


* Build :noexport:

# Bind derivatives change variable values *locally* on export.

These two are because I'm defining the title and toc manually using latex, so I don't want org-latex to take care of that.
#+BIND: org-latex-title-command ""
#+BIND: org-latex-toc-command ""
This is so that src code blocks get src highlighting from the minted package.
#+BIND: org-latex-listings minted
This beautifies table borders. It will only work if the booktabs package is loaded, which I do in the setup file.
#+BIND: org-latex-tables-booktabs t
And this configuration increases the default width of images, so that they are larger and more readable on print.
#+BIND: org-latex-image-default-width ".97\\linewidth"
