(setq evil-want-keybinding nil)                   
;; put this before loading evil to work
(setq evil-want-C-i-jump nil)
(straight-use-package 'evil)
;; this statement is required to enable evil/evil-colleciton mode
(evil-mode 1)
(setq evil-want-abbrev-expand-on-insert-exit nil)

;; after evil
(straight-use-package
 '(evil-collection
   :type git
   :host github :repo "emacs-evil/evil-collection"))
(evil-collection-init)

(straight-use-package '(evil-org-mode
                        :type git
                        :host github
                        :repo "Somelauw/evil-org-mode"))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
;; config

;; (add-hook 'org-mode-hook 'evil-org-mode)
;; (add-hook 'evil-org-mode-hook
;;           (lambda () (evil-org-set-key-theme)))
;; (require 'evil-org-agenda)
;; (evil-org-agenda-set-keys)
;; (setq                                             ;;automatically use evil for ibuffer and dired
;; evil-emacs-state-modes
;; (delq 'ibuffer-mode evil-emacs-state-modes))

(straight-use-package 'evil-leader)
;; needs to be enabled before M-x evil-mode!
;; :config
(evil-leader-mode 1)
(global-evil-leader-mode 1)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'org-export-dispatch
  "a" 'zk/switch-to-agenda
  "d" 'deft
  "g" 'magit-status
  "i" 'org-roam-node-insert
  "f" 'org-roam-capture
  "D" 'org-roam-dailies-capture-today
  "l" 'org-roam-buffer-toggle
  "z" 'term
  "c" 'org-capture
  "b" 'bookmark-jump
  "L" 'org-insert-link
  "q" 'kill-current-buffer
  "F" 'pdf-links-action-perform
  "s" 'secret-mode
  "n" 'org-noter
  "m i" 'org-noter-insert-note
  "m p" 'org-noter-insert-precise-note
  "m k" 'org-noter-sync-prev-note
  "m j" 'org-noter-sync-next-note
  "m s" 'org-noter-create-skeleton
  "m q" 'org-noter-kill-session
  "r c" 'org-ref-clean-bibtex-entry
  "r s" 'org-ref-bibtex-sort-order
  "r b" 'org-ref-bibliography
  "r g" 'org-ref-add-glossary-entry
  "r a" 'org-ref-add-acronym-entry
)
;; "r" 'consult-recent-file
;;"l" 'org-store-link
;;"s" 'zk/gen-scratch-buffer
;; )
