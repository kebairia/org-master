(use-package org-roam
  ;; use org-roam v2
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "/home/zakaria/dox/braindump/org-files"))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n G" . org-roam-ui-mode)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n r" . org-roam-ref-add)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         :map org-roam-dailies-map
         ("y" . org-roam-dailies-capture-yesterday)
         ("t" . org-roam-dailies-capture-tomorrow)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-dailies-directory "/home/zakaria/dox/braindump/org-files/daily")
  ;; If using org-roam-protocol
  (load "~/.config/emacs/straight/repos/org-roam/extensions/org-roam-dailies.el")
  (load "~/.config/emacs/straight/repos/org-roam/extensions/org-roam-graph.el") 
  (load "~/.config/emacs/straight/repos/org-roam/extensions/org-roam-protocol.el") 
  (require 'org-roam-protocol))

;;Configuring the Org-roam buffer display
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))
;; Garbage Collection
(setq org-roam-db-gc-threshold most-positive-fixnum)


;;   )

(use-package org-roam-ui
  :straight
  (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam
  ;; :hook
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme nil
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; (setq org-roam-ui-custom-theme
;;       '((bg . "#1d2021")
;;         (bg-alt . "#282a36")
;;         (fg . "#f8f8f2")
;;         (fg-alt . "#6272a4")
;;         (red . "#ff5555")
;;         (orange . "#f1fa8c")
;;         (yellow ."#ffb86c")
;;         (green . "#50fa7b")
;;         (cyan . "#8be9fd")
;;         (blue . "#ff79c6")
;;         (violet . "#8be9fd")
;;         (magenta . "#bd93f9")))

(setq org-roam-graph-viewer
      (lambda (file)
        (let ((org-roam-graph-viewer "/usr/bin/brave"))
          (org-roam-graph--open (concat "file://///" file)))))

;; disable linum-mode (line number)
(add-hook 'deft
          '(lambda () (linum-mode nil)))
(use-package deft
  :commands (deft)
  :custom       (deft-directory "~/org/notes" )
  (deft-recursive t)
  (deft-extensions '("org" "md" "txt") )
  (deft-use-filename-as-title t)
  (deft-file-naming-rules
    '((noslash . "-")
      (nospace . "-")
      (case-fn . downcase))
    deft-org-mode-title-prefix t
    deft-text-mode 'org-mode))
