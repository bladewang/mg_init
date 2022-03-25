
(setq gc-cons-threshold (* 50 1000 1000)) 

(setq inhibit-startup-screen t)
(menu-bar-mode -1) ;; to visit menu options,  M-x tmm-menubar
(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode t)

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

;(require 'benchmark-init)
;; To disable collection of benchmark data after init is done.
;(add-hook 'after-init-hook 'benchmark-init/deactivate)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(use-package counsel
  :ensure t
  :commands counsel-mode
  :config
  (ivy-mode)
  (setq ivy-use-virtual-buffers        t
	ivy-count-format      "(%d/%d) "
	enable-recursive-minibuffers   t
	minibuffer-depth-indicate-mode t)
  :bind
  ("C-M-s" . 'swiper-isearch))

(use-package undo-tree
  :ensure t
  :defer t
  :init
  (setq undo-tree-auto-save-history nil)
  :commands undo-tree-visualize
  :config
  (global-undo-tree-mode)
  :bind
  ("C-x u" . undo-tree-visualize))

(use-package ace-window
  :ensure t
  :defer t
  :bind
  ("M-o" . 'ace-window))

(use-package elpy
  ;; to activate, M-: (elpy-enable)
  :ensure t
  :commands elpy-enable
  :init
  (setq python-shell-interpreter "python3"))

(use-package view
  :defer t
  :bind
  (:map view-mode-map
   ("e" . 'View-scroll-line-forward)))

;; learned from xahlee ;; or just (require 'dired-single) than M-x dired-single-magic-buffer
;; press "o" to open file in another window
;(require 'dired )
;(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
;(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))) ; was dired-up-directory
(use-package dired
  :defer t
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  :bind (:map dired-mode-map
	      ("RET" . 'dired-find-alternate-file)
	      ("^" . (lambda () (interactive) (find-alternate-file "..")))))

(defvar my/packages
  '(ag                    ;A front-end for ag ('the silver searcher'), the C ack replacement.
    ;ace-window            ;Quickly switch windows.
    ;undo-tree             ;Treat undo history as a tree
    wgrep-ag              ;Writable ag buffer and apply the changes to files
    zoom                  ;Fixed and automatic balanced window layout
    pyim                  ;A Chinese input method support quanpin, shuangpin, wubi, cangjie and rime.
    pyim-basedict         ;The default pinyin dict of pyim
    dired-single          ;Reuse the current dired buffer to visit a directory
    evil                  ;Extensible Vi layer for Emacs.
    afternoon-theme       ;Dark color theme with a deep blue background
    monokai-theme         ;A fruity color theme for Emacs.
    darktooth-theme       ; the darkness... it watches
    gruvbox-theme         ;retro-groove colour theme for Emacs
    moe-theme             ;colorful eye-candy theme. Moe, moe, kyun!
    ample-theme           ;Dark Theme for Emacs
    cyberpunk-theme       ;Cyberpunk Color Theme
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

(load-theme 'darktooth 1)


(setq gc-cons-threshold (* 2 1000 1000))


