;; some shortcuts -- files
;; (set-register ?i (cons 'file "~/.config/emacs/init.org" ))
;; (set-register ?b (cons 'file "~/org/books.org" ))
(global-set-key (kbd "C-c C") (lambda() (interactive)(find-file "~/.config/emacs/init.org")))
(global-set-key (kbd "C-c b") (lambda() (interactive)(find-file "~/org/books.org")))
(global-set-key (kbd "C-c r") (lambda() (interactive)(find-file "~/org/refs.org")))
(global-set-key (kbd "C-c I") (lambda() (interactive)(find-file "~/org/gtd/inbox.org")))
(global-set-key (kbd "C-c L") (lambda() (interactive)(find-file "~/org/links.org")))
(global-set-key (kbd "<f12>") (lambda() (interactive)(find-file "~/org/conf/org.pdf")))
;; (global-set-key (kbd "C-c E") (lambda() (interactive)(find-file "~/org/gtd/emails.org")))
;; Reload buffer with <F5>
(global-set-key [f5] '(lambda () (interactive) (revert-buffer nil t nil)))

(global-set-key (kbd "<f12>" ) 'flyspell-auto-correct-previous-word)
(defun zk/split-go-right()
  (interactive)
  (split-window-horizontally)
  (windmove-right))
(defun zk/split-go-down()
  (interactive)
  (split-window-vertically)
  (windmove-down))
;; try to go to the other window automaticly
(global-set-key (kbd "C-c i") 'zk/split-go-right)
(global-set-key (kbd "C-c m") 'zk/split-go-down)

;; Move between buffer
(global-set-key (kbd "M-n") 'switch-to-next-buffer)
(global-set-key (kbd "M-p") 'switch-to-prev-buffer)
;; winner mode
;; (winner-mode +1)
;; (define-key winner-mode-map (kbd "M-p") #'winner-undo)
;; (define-key winner-mode-map (kbd "M-n") #'winner-redo)

   ;; Move between Windows
   (global-set-key (kbd "C-c k") 'windmove-up)
   (global-set-key (kbd "C-c j") 'windmove-down)
   (global-set-key (kbd "C-c l") 'windmove-right)
   (global-set-key (kbd "C-c h") 'windmove-left)

   ;; Resize windows
   (global-set-key (kbd "C-M-l") 'shrink-window-horizontally)
   (global-set-key (kbd "C-M-h") 'enlarge-window-horizontally)
   (global-set-key (kbd "C-M-j") 'shrink-window)
   (global-set-key (kbd "C-M-k") 'enlarge-window)

   (global-set-key (kbd "M-o") 'delete-other-windows)
   (global-set-key (kbd "C-x p") 'zk/org-agenda-process-inbox-item)

(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-c s") 'zk/set-save-bookmark)
;; set a bookmark then save it on the bookmark file 
 (defun zk/set-save-bookmark()
   (interactive)
   (bookmark-set)
   (bookmark-save))
