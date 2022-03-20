
;;; add by wky

(menu-bar-mode -1) ;; M-x tmm-menubar ; to visit menu options
;(global-hl-line-mode 1)

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

;;; installed packages
;  ace-window         20200606.1259 installed             Quickly switch windows.
;  afternoon-theme    20140104.1859 installed             Dark color theme with a deep blue background
;  ag                 20201031.2202 installed             A front-end for ag ('the silver searcher'), the C ack replacement.
;  counsel            20211230.1909 installed             Various completion functions using Ivy
;  dired-single       20211101.2319 installed             Reuse the current dired buffer to visit a directory
;  elpy               20220220.2059 installed             Emacs Python Development Environment
;  evil               20220309.2216 installed             Extensible Vi layer for Emacs.
;  j-mode             20171224.1856 installed             Major mode for editing J programs
;  magit              20220319.1030 installed             A Git porcelain inside Emacs.
;  sicp               20200512.1137 installed             Structure and Interpretation of Computer Programs in info format
;  undo-tree          0.8.2         installed             Treat undo history as a tree
;  vlf                20191126.2250 installed             View Large Files
;  w3m                20211122.335  installed             an Emacs interface to w3m

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
