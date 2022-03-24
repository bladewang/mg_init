
(setq gc-cons-threshold (* 50 1000 1000)) 

(menu-bar-mode -1) ;; M-x tmm-menubar ; to visit menu options
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char
              diff-switches "-u")

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;;; config melpa
(require 'package)
(add-to-list
  'package-archives
  '("melpa"    . "http://melpa.org/packages/")
  t)
;;    ("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;    ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(use-package counsel
  :ensure t
  :config
  (counsel-mode)
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :bind
  ("C-M-s" . 'swiper-isearch))

(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-auto-save-history nil)
  :config
  (global-undo-tree-mode))

(use-package ace-window
  :ensure t
  :bind
  ("M-o" . 'ace-window))

(use-package elpy
  ;; to activate, M-: (elpy-enable)
  :ensure t
  :commands elpy-enable
  :init
  (setq python-shell-interpreter "python3"))

(use-package view
  :bind
  (:map view-mode-map
   ("e" . 'View-scroll-line-forward)))

;; learned from xahlee ;; or just (require 'dired-single) than M-x dired-single-magic-buffer
;; press "o" to open file in another window
;(require 'dired )
;(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
;(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))) ; was dired-up-directory
(use-package dired
  :bind (:map dired-mode-map
	      ("RET" . 'dired-find-alternate-file)
	      ("^" . (lambda () (interactive) (find-alternate-file "..")))))

(defvar my/packages
  '(ag                    ;A front-end for ag ('the silver searcher'), the C ack replacement.
    ;ace-window            ;Quickly switch windows.
    ;undo-tree             ;Treat undo history as a tree
    wgrep-ag              ;Writable ag buffer and apply the changes to files
    dired-single          ;Reuse the current dired buffer to visit a directory
    evil                  ;Extensible Vi layer for Emacs.
    afternoon-theme       ;Dark color theme with a deep blue background
    monokai-theme         ;A fruity color theme for Emacs.
    ;use-package           ;A configuration macro for simplifying your .emacs
    ;counsel               ;Various completion functions using Ivy
    magit                 ;A Git porcelain inside Emacs.
    sicp                  ;Structure and Interpretation of Computer Programs in info format
    ;elpy                  ;Emacs Python Development Environment
    j-mode                ;Major mode for editing J programs
    vlf                   ;View Large Files
    w3m                   ;an Emacs interface to w3m
    qrencode              ;QRCode encoder
    ))


(dolist (pkg my/packages)
  (when (not (package-installed-p pkg))
    (package-install pkg)))

;;; for emacsclient
;;; alias em='emacsclient -t -a "emacs -Q -l ~/mg_init/init.el " '
(server-start)

(put 'upcase-region 'disabled nil)

(load-theme 'afternoon 1)


(setq gc-cons-threshold (* 2 1000 1000))


