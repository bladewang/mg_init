
;;; add by wky

(menu-bar-mode -1)
(global-hl-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char
              diff-switches "-u")

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;; (set-face-background 'hl-line "color-19")
(set-face-background 'hl-line "blue")
(set-face-foreground 'hl-line "white")

;; (set-face-background 'region "color-160")
(set-face-background 'region "red")
(set-face-foreground 'region "white")

;;; config melpa
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

;;; for emacsclient
;;; alias em='emacsclient -t -a "emacs -Q -l ~/mg_init/init.el " '
(server-start)

;;; keys binding
; (global-set-key (kbd "C-SPC") nil)
; (global-set-key (kbd "C-@") 'set-mark-command)
(put 'upcase-region 'disabled nil)

;; learned from xahlee
(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))) ; was dired-up-directory
(require 'view)
(define-key view-mode-map (kbd "e") 'View-scroll-line-forward)

;;; use below codes after package-install undoo-tree, ace-window, ivy, counsel, elpy
(global-undo-tree-mode)
(global-set-key (kbd "M-o") 'ace-window)
(ivy-mode)
(setq python-shell-interpreter "python3")
;; when editing .py file (elpy-enalbe)
(load-theme 'afternoon 1)
