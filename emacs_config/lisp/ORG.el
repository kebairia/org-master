;; - turn on Org Indent mode globally for all files
;; - You can also control this behaviour for each buffer by
;;   setting #+startup: indent or #+startup: noindent
;;   in the buffer metadata.
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-log-into-drawer t)
;; Improve org mode looks
(setq org-startup-indented t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-list-allow-alphabetical t
      org-fontify-quote-and-verse-blocks t
      ;; use user's label, i need that for my thesis refenrences
      org-latex-prefer-user-labels t
      org-image-actual-width '(400))
;; use '⤵' instead of '...' in headlines
(setq org-ellipsis " ›")
;; use '•' instead of '-' in lists
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 ()
                                (compose-region
                                 (match-beginning 1)
                                 (match-end 1) "•"))))))

;; Show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))
(setq
 org-appear-autolinks t
 org-appear-autosubmarkers t)

(use-package org-cliplink)

(use-package org-contrib
  :config
  (require 'ox-extra)
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))

;; ;; Adding a separator line between days in Emacs Org-mode calender view (prettier)

;;     (setq org-agenda-format-date (lambda (date) (concat "\n"
;;                                                         (make-string (window-width) 9472)
;;                                                         "\n"
;;                                                         (org-agenda-format-date-aligned date))))
(setq org-agenda-directory "~/org/gtd/"
      org-agenda-files '("~/org/gtd" ))                    ;; org-agenda-files

(setq org-agenda-dim-blocked-tasks nil                    ;; Do not dim blocked tasks
      org-agenda-span 'day                                ;; show me one day
      org-agenda-inhibit-startup t                        ;; Stop preparing agenda buffers on startup:
      org-agenda-use-tag-inheritance nil                  ;; Disable tag inheritance for agendas:
      org-agenda-show-log t
      ;;org-agenda-skip-scheduled-if-done t
      ;;org-agenda-skip-deadline-if-done t
      ;;org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled
      org-agenda-skip-scheduled-if-deadline-is-shown t     ;; skip scheduled if they are already shown as a deadline
      org-agenda-deadline-leaders '("!D!: " "D%2d: " "")
      org-agenda-scheduled-leaders '("" "S%3d: ")

      org-agenda-time-grid
      '((daily today require-timed)
        (800 1000 1200 1400 1600 1800 2000)
        "......" "----------------"))
(setq
 org-agenda-start-on-weekday 0                          ;; Weekday start on Sunday
 org-treat-S-cursor-todo-selection-as-state-change nil ;; S-R,S-L skip the note/log info[used when fixing the state]
 org-log-done 'time
 org-agenda-tags-column -130                          ;; Set tags far to the right
 org-clock-out-remove-zero-time-clocks t              ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
 org-clock-persist t                                  ;; Save the running clock and all clock history when exiting Emacs, load it on startup
 org-use-fast-todo-selection t                        ;; from any todo state to any other state; using it keys
 org-agenda-window-setup 'only-window)                 ;; Always open my agenda in fullscreen

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t %s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))
;; define org's states
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
;; sort my org-agenda preview
(setq org-agenda-sorting-strategy '((agenda habit-down
                                            time-up
                                            scheduled-down
                                            priority-down
                                            category-keep
                                            deadline-down)
                                    (todo priority-down category-keep)
                                    (tags priority-down category-keep)
                                    (search category-keep)))

;;Thanks to Erik Anderson, we can also add a hook that will log when we activate
;;a task by creating an “ACTIVATED” property the first time the task enters the NEXT state:
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)
(add-hook 'org-agenda-mode-hook                            ;; disable line-number when i open org-agenda view
           (lambda() (display-line-numbers-mode -1)))

;; (define-key global-map (kbd "C-c c") 'org-capture)
;; (define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-agenda-block-separator  9472)                  ;; use 'straight line' as a block-agenda divider
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda ""
                  ((org-agenda-span 'day)
                   (org-deadline-warning-days 365)))

          (todo "NEXT"
                ((org-agenda-overriding-header "In Progress")
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-files '("~/org/gtd/someday.org"
                                     "~/org/gtd/projects.org"
                                     "~/org/gtd/next.org"))
                 ))
          (todo "TODO"
                ((org-agenda-overriding-header "inbox")
                 (org-agenda-files '("~/org/gtd/inbox.org"))))

          (todo "TODO"
                ((org-agenda-overriding-header "Emails")
                 (org-agenda-files '("~/org/gtd/emails.org"))))

          (todo "TODO"
                ((org-agenda-overriding-header "Projects")
                 (org-agenda-files '("~/org/gtd/projects.org")))
                )

          (todo "TODO"
                ((org-agenda-overriding-header "One-off Tasks")
                 (org-agenda-files '("~/org/gtd/next.org"))
                 (org-agenda-skip-function '(org-agenda-skip-entry-if
                                             'deadline 'scheduled))))
          nil))))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 48)
(setq org-habit-show-habits-only-for-today t)

;; Refiling [need reading]
;;tell org-mode we want to specify a refile target using the file path.
(setq org-refile-use-outline-path 'file
 org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-targets '(("~/org/gtd/next.org" :level . 0)
                           ("~/org/ideas.org" :level . 1)
                           ("~/org/links.org" :level . 1)
                           ("~/org/gtd/someday.org" :regexp . "\\(?:\\(?:Task\\|idea\\|p\\(?:\\(?:os\\|rojec\\)t\\)\\)s\\)")
                           ("projects.org" :regexp . "\\(?:Tasks\\)"))) 
;;("someday.org" :level . 0)

(setq org-capture-templates
      `(("i" "Inbox" entry  (file "~/org/gtd/inbox.org")
         ,(concat "* TODO %?\n"
                  "/Entered on/ %U"))
        ("l" "Link" entry (file+headline "~/org/gtd/inbox.org" "Links")
         ,(concat "* TODO %a %?\n"
                  "/Entered on/ %U") :immediate-finish t)
        ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
         "** %<%H:%M> %?\n")
        ("e" "email" entry (file+headline "~/org/gtd/emails.org" "Emails")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")

        ;; ("m" "mood" entry (file "~/org/mood.org" )
        ;;  ,(concat "* %? \n %^{MOOD} \n"
        ;;           "/Entered on/ %U") :immediate-finish t)
        ))

(straight-use-package 'org-bullets)
;; enable org-bullets with org-mode
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;; change org-bullets faces
(setq org-bullets-bullet-list
      '("▶" "⚫" "◆" "◉" "○" "◇" "▸"))
;;     ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
;;     ;;; Small
;;     ;; ► • ★ ▸

(require 'org-protocol)

(setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)" "CANCELED")))
(setq org-todo-keyword-faces
  '(
    ("TODO" . (:foreground "brown2" :weight bold))
    ("READ" . (:foreground "brown2" :weight bold))

    ("NEXT" . (:foreground "#00b0d1"  :weight bold ))
    ("READING" . (:foreground "#00b0d1"  :weight bold ))

    ("DONE" . (:foreground "#16a637" :weight bold))

    ("HOLD" . (:foreground "orange"  :weight bold))

    ("CANCELED" . (:foreground "gray" :background "red1" :weight bold))
  ))

;; (setq org-ref-default-bibliography '("~/dox/wrk/pfe/docs/thesis_infra/lib/refs.bib")
(use-package org-ref
  :after org
  :config
  (setq org-ref-default-bibliography '("~/org/bib/refs.bib")
        org-ref-bibliography-notes "~/org/bib/refs.bib"
        org-ref-pdf-directory "~/org/bib/papers"
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
        bibtex-completion-pdf-field "file"
        bibtex-completion-pdf-symbol ""
        bibtex-completion-display-formats
        '((t . "${title:46} ${author:20} ${year:4} ${=type=:4}${=has-pdf=:1}${=has-note=:1}"))))

  (defun org-ref-open-in-scihub ()
    "Open the bibtex entry at point in a browser using the url field or doi field.
Not for real use, just here for demonstration purposes."
    (interactive)
    (let ((doi (org-ref-get-doi-at-point)))
      (when doi
        (if (string-match "^http" doi)
            (browse-url doi)
          (browse-url (format "http://sci-hub.se/%s" doi)))
        (message "No url or doi found"))))

;; variables that control bibtex key format for auto-generation
;; I want firstauthor-year-title-words
;; this usually makes a legitimate filename to store pdfs under.
(setq bibtex-autokey-year-length 4
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-year-title-separator "-"
      bibtex-autokey-titleword-separator "-"
      bibtex-autokey-titlewords 2
      bibtex-autokey-titlewords-stretch 1
      bibtex-autokey-titleword-length 5)

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

  ;; Mimore class is a latex class for writing articles.
  (add-to-list 'org-latex-classes
               '("mimore"
                 "\\documentclass{mimore}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; Mimosis class is a latex class for writing articles.
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
  (add-to-list 'org-latex-classes
               '("tufte-book"
                 "\\documentclass{tufte-book}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

;; Coloured LaTeX using Minted
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted")))
;; org-latex-pdf-process
;; '("latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -bibtex -output-directory=%o -f %f"))
(setq org-latex-pdf-process
      '("latexmk -f -pdf -%latex --shell-escape -recorder -bibtex -output-directory=%o %f"))
(setq bibtex-dialect 'biblatex)

;; syntex-highlighting
(use-package htmlize)
;;Don’t include a footer...etc in exported HTML document.
(setq org-html-postamble nil)
(setq org-src-window-setup 'current-window)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends '(ascii beamer html icalendar latex odt)))

(eval-after-load "org"
  (use-package ob-async
    :ensure t
    :init (require 'ob-async)))
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-confirm-babel-evaluate nil
      org-src-tab-acts-natively t)
;; (require 'org-tempo)
;; (add-to-list 'org-structure-template-alist '("s" . "src sh"))
;; (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
;; (add-to-list 'org-structure-template-alist '("p" . "src python"))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (emacs-lisp . t)
   (R . t)
   ))

(defun zk/switch-to-agenda ()
     (interactive)
     (org-agenda nil "g"))
;; PS: check out the original code from here:
;; https://github.com/gjstein/emacs.d/blob/master/config/gs-org.el

;;clocking-out changes NEXT to HOLD
;;clocking-in changes HOLD to NEXT
(setq org-clock-in-switch-to-state 'zk/clock-in-to-next)
(setq org-clock-out-switch-to-state 'zk/clock-out-to-hold)
(defun zk/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
   Skips capture tasks, projects, and subprojects.
   Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO")))
      "NEXT")
     ((and (member (org-get-todo-state) (list "HOLD")))
      "NEXT")
      )))
(defun zk/clock-out-to-hold (kw)
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "NEXT")))  "HOLD")
      )))
