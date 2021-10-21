;; User name
(setq user-full-name "Kebairia Zakaria")
;; User mail address
(setq user-mail-address "4.kebairia@gmail.com")
;; No startup  screen
(setq inhibit-startup-screen t)
;; No startup message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
;; No message in scratch buffer
(setq initial-scratch-message nil)
;; Initial buffer 
(setq initial-buffer-choice nil)
;; No frame title
(setq frame-title-format nil)
;; No file dialog
(setq use-file-dialog nil)
;; No dialog box
(setq use-dialog-box nil)
;; No popup windows
(setq pop-up-windows nil)
;; No empty line indicators
(setq indicate-empty-lines nil)
;; No cursor in inactive windows
(setq cursor-in-non-selected-windows nil)
;; fundamental mode is initial mode
;;(setq initial-major-mode 'fundamental-mode)
;; Text mode is default major mode
;;(setq default-major-mode 'text-mode)
;; Moderate font lock
(setq font-lock-maximum-decoration nil)
;; No limite on font lock
(setq font-lock-maximum-size nil)

;; No line breat space points
(setq auto-fill-mode nil)

;; column indicator to 100
(setq display-fill-column-indicator-column 100)
;; Fill column at 80
;; (setq fill-column 80)

;; No confirmation for visiting non-existent files
(setq confirm-nonexistent-file-or-buffer nil)

;; Completion style, see
;; gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
(setq completion-styles '(basic substring))

;; Mouse active in terminal
(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line))
;; modeline at top
(setq-default header-line-format mode-line-format)
;; No scroll bars
(scroll-bar-mode 0)
;; No toolbar
(tool-bar-mode 0)
;; No menu bar
(menu-bar-mode -1)
;; (if (display-graphic-p)
;;     (menu-bar-mode t) ;; When nil, focus problem on OSX
;;   (menu-bar-mode -1))
;; Navigate windows using shift+direction
(windmove-default-keybindings)
;; Paren mode
(show-paren-mode 1)
;; Electric pair mode
(electric-pair-mode 1)
;; Tab behavior
(setq tab-always-indent 'complete)
;; (global-company-mode)
;; (define-key company-mode-map [remap indent-for-tab-command]
;;   #'company-indent-or-complete-common)
;; Pixel scroll (as opposed to char scrool)
(pixel-scroll-mode t)
;; y/n for  answering yes/no questions
(fset 'yes-or-no-p 'y-or-n-p)
;; use ssh by default in tramp
(setq tramp-default-method "ssh")

;; No tabs
;;(setq-default indent-tabs-mode nil)

;; Tab.space equivalence
(setq tab-width 4)

;; Size of temporary buffers
(temp-buffer-resize-mode)
(setq temp-buffer-max-height 8)

;; Minimum window height
(setq window-min-height 1)

;; Buffer encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;; Default shell in term
(setq-default shell-file-name "/bin/zsh")
(setq explicit-shell-file-name "/bin/zsh")
;; activate eterm-256color-mode when starting term
(add-hook 'term-mode-hook #'eterm-256color-mode)

;; Kill term buffer when exiting
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

;; display line number in text/prog & fundamental modes
(setq display-line-numbers 'relative)    ; Enable relative number
(setq-default
 display-line-numbers-current-absolute t ; Enable the line nubmers
 display-line-numbers-width 2
 display-line-numbers-widen t)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'fundamental-mode-hook #'display-line-numbers-mode)
;; enable `narrow-to-region` functionality
(put 'narrow-to-region 'disabled nil)
