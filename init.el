;; for Emacs 2.9
(setq gc-cons-threshold (* 50 1000 1000))

(setq inhibit-startup-screen t)
(menu-bar-mode -1) ;; to visit menu options,  M-x tmm-menubar

(tool-bar-mode -1)
(scroll-bar-mode -1)


(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode t)
(put 'upcase-region 'disabled nil)

(defvar default-font "Iosevka Term-16.0:weight=light")
(add-to-list 'default-frame-alist `(font . ,default-font))

(setq-default auto-save-default  nil
              make-backup-files  nil
              linum-format  "%4d "
              ediff-forward-word-function  'forward-char
              diff-switches "-u")

;; when height of screen size > 160 rows, try to split the screen vertically
;; for a large 16:9 monitor
(setq split-height-threshold 160)

;; set ediff control panel not to split apart from main gui frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; (setq-default default-case-fold-search nil) ;;; :set ignorecase

;;; C-u C-SPC C-SPC C-SPC ...
;;; or Cu C-@ C-@ C-@ ...
(setq set-mark-command-repeat-pop t)

;;; config melpa
(require 'package)

;;    ("gnu"    . "https://elpa.gnu.org/packages/")
;;    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
;;    ("melpa-stable" . "https://stable.melpa.org/packages/")
;;    ("melpa"  . "https://melpa.org/packages/")

(dolist (p '(
	     ("melpa"  . "https://melpa.org/packages/")
	     ("melpa-stable" . "https://stable.melpa.org/packages/")
	     ))
  (add-to-list 'package-archives p t))
(package-initialize)

;(require 'benchmark-init)
;; To disable collection of benchmark data after init is done.
;(add-hook 'after-init-hook 'benchmark-init/deactivate)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(unless (package-installed-p 'quelpa-use-package)
  (package-install 'quelpa-use-package))

(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

(use-package exec-path-from-shell
  :ensure t  ;; 确保该包被安装
  :pin melpa
  :config
  (exec-path-from-shell-initialize)

  ;; 如果你需要从 shell 复制除 PATH 和 MANPATH 之外的其他环境变量，
  ;; 可以在这里添加：
  ;; (exec-path-from-shell-copy-envs '("PYTHONPATH" "JAVA_HOME" "GOPATH"))
  ;; 可以选择性地禁用某些变量的复制，例如，如果你希望 Emacs 内部的某些变量不受 shell 影响：
  ;; (setq exec-path-from-shell-variables-to-exclude '("TERM" "LS_COLORS"))
  )

(use-package counsel
  :ensure t
  :config
  (counsel-mode)
  (ivy-mode)
  (setq ivy-use-virtual-buffers        t
	ivy-count-format      "(%d/%d) "
	enable-recursive-minibuffers   t
	minibuffer-depth-indicate-mode t)
  :bind
  ("C-M-s" . 'swiper-isearch)
  ("C-x C-M-f" . 'counsel-fzf))

(use-package register-jump
  :vc (:fetcher github :repo leoliu/register-jump.el)
  :defer t
  :init
  (define-key ctl-x-r-map "j" 'register-jump))

(use-package j-mode
  :pin melpa
  :defer t
  :config
  ;; for j90x
  (setq j-console-cmd "jconsole"))

(use-package gptel
  :pin melpa
  :defer t
  :init
  (when (file-exists-p "~/gptel.el")
    (load "~/gptel.el")))

(use-package magit
  :defer t
  :pin melpa)

(use-package vterm
  :defer t
  :pin melpa
  :init
  (setq vterm-max-scrollback 100000)
  :bind*
  ;; input C-x to vterm by C-q C-x
  ;; ("C-q" . 'vterm-send-next-key)
  ;; C-q bind to quoted-insert by defult
  ;;     ,use :map to limit the map just bind in vterm
  (:map vterm-mode-map
	("C-c C-t" . 'vterm-copy-mode)
	("C-q" . 'vterm-send-next-key)))

(use-package howm
  :ensure t
  :defer t
  :pin melpa
  :init
  ;; Use the_silvers_searcher as grep
  (setq howm-view-use-grep t)
  (setq howm-view-grep-command "ag")
  (setq howm-view-grep-option "-H --numbers --no-color --noheading")
  (setq howm-view-grep-extended-option nil)
  (setq howm-view-grep-fixed-option "-F")
  (setq howm-view-grep-expr-option nil)
  (setq howm-view-grep-file-stdin-option nil)
  :custom-face
  (howm-mode-title-face ((t (:foreground "LightGreen"))))
  (howm-reminder-normal-face ((t (:foreground "LightGreen"))))
  )

(use-package bqn-mode
  :ensure t
  :defer t
  :pin melpa
  :init
  :custom-face
  (bqn-default ((t (:family "Iosevka")))))

(use-package nov
  :defer t
  :pin melpa
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package easysession
  :defer t
  :pin melpa)

(use-package meow-keymap
  :defer t
  :bind*
  (:map  meow-insert-state-keymap
	 ("ESC" . 'meow-insert-exit)))

(use-package undo-tree
  :ensure t
  :defer t
  :init
  (setq undo-tree-auto-save-history nil)
  :commands undo-tree-visualize
  :config
  (global-undo-tree-mode)
  :bind
  ("C-x u" . 'undo-tree-visualize))

(use-package ace-window
  :ensure t
  :defer t
  :bind
  ("M-o" . 'ace-window)
  :custom-face
  (aw-leading-char-face ((t (:background "white" :foreground "black" :height 2.0)))))

(use-package elpy
  ;; to activate, M-: (elpy-enable)
  :defer t
  :commands elpy-enable
  :init
  (setq python-shell-interpreter "python3"))

(use-package view
  :defer t
  :bind
  (:map view-mode-map
   ("e" . 'View-scroll-line-forward)))

;(use-package dired-single
;  :vc (:fetcher github :repo emacsattic/dired-single)
;  :defer t)

;; learned from xahlee ;; or just (require 'dired-single) than M-x dired-single-magic-buffer
;; press "o" to open file in another window
(use-package dired
  :defer t
  :config
  (put 'dired-find-alternate-file 'disabled nil)
  (setq dired-listing-switches "-alht")
  :bind (:map dired-mode-map
	      ("RET" . 'dired-find-alternate-file)
	      ("^" . (lambda () (interactive) (find-alternate-file "..")))))

(use-package ls-lisp
  :init
  ;; (delq 'links ls-lisp-verbosity)
  ;; (delq 'uid ls-lisp-verbosity)
  (setq ls-lisp-use-insert-directory-program nil
	ls-lisp-dirs-first t
	ls-lisp-verbosity nil))

(use-package doc-view
  ;; try to `M-x doc-view-clear-cache`, if nothing showed better
  :defer t
  :config
  (setq doc-view-resolution 260))

(use-package image
  :defer t
  :hook
  (image-mode . (lambda ()
                  "hook function to display image on the center of window"
                  (let* ((window-width  (window-total-width))
                         (window-height (window-total-height))
	                 (image-width   (car (image-size (image-get-display-property))))
                         (image-height  (cdr (image-size (image-get-display-property))))
                         (margin-width  (truncate (/ (- window-width  image-width)  2)))
                         (margin-height (truncate (/ (- window-height image-height) 2)))
	                 (inhibit-read-only t))
                    (progn (goto-line 1)
	                   (insert (make-string margin-height ?\n))
	                   (goto-line (+ 1 margin-height))
	                   (insert (make-string margin-width ?\s)))
                    (set-buffer-modified-p nil))
                  (define-key image-mode-map (kbd ".") 'image-next-file)
                  (define-key image-mode-map (kbd ",") 'image-previous-file))))

(use-package calendar
  :defer t
  :config
  (calendar-set-date-style 'iso)
  :custom-face
  (diary ((t (:background "dark green" :foreground "#F0DFAF")))))

(defvar my/packages
  ;;; packages in elpa & melpa-stable
  '(ag                    ;A front-end for ag ('the silver searcher'), the C ack replacement.
    ;ace-window            ;Quickly switch windows.
    ;undo-tree             ;Treat undo history as a tree
    wgrep-ag              ;Writable ag buffer and apply the changes to files
    zoom                  ;Fixed and automatic balanced window layout
    pyim                  ;A Chinese input method support quanpin, shuangpin, wubi, cangjie and rime.
    pyim-basedict         ;The default pinyin dict of pyim
    ;dired-single          ;Reuse the current dired buffer to visit a directory (not in elpa already)
    evil                  ;Extensible Vi layer for Emacs.
    counsel-tramp         ;Tramp ivy interface for ssh, docker, vagrant.
    benchmark-init        ;Benchmarks Emacs require and load calls
    afternoon-theme       ;Dark color theme with a deep blue background
    monokai-theme         ;A fruity color theme for Emacs.
    darktooth-theme       ; the darkness... it watches
    ample-theme           ;Dark Theme for Emacs
    material-theme        ;Theme based on the colors of the Google Material Design
    sexy-monochrome-theme ;A sexy dark Emacs >= 24 theme for your sexy code
    tao-theme             ; package provides two parametrized uncoloured color themes for Emacs: tao-yin and tao-yang.
    ;use-package           ;A configuration macro for simplifying your .emacs
    ;counsel               ;Various completion functions using Ivy
    ;magit                 ;A Git porcelain inside Emacs.
    vundo                 ;Visual undo tree
    ;;; some other packages
    ;elpy                  ;Emacs Python Development Environment
    ;geiser                ;GNU Emacs and Scheme talk to each other
    ;geiser-chez           ;Chez Scheme's implementation of the geiser protocols
    ;;;   (setq geiser-chez-binary "chez") ;; for mac
    ;geiser-chibi          ;Chibi Scheme's implementation of the geiser protocols
    ;geiser-gambit         ;Gambit's implementation of the geiser protocols
    ;geiser-guile          ;Guile's implementation of the geiser protocols
    ;geiser-mit            ;MIT/GNU Scheme's implementation of the geiser protocols
    ;geiser-racket         ;Support for Racket in Geiser
    ;sml-mode              ;Major mode for editing (Standard) ML
    lispy                 ;vi-like Paredit
    vlf                   ;View Large Files
    qrencode              ;QRCode encoder
    ))

(defvar my/packages-melpa
  '(;;; packages in melpa
    magit                 ;A Git porcelain inside Emacs.
    w3m                   ;an Emacs interface to w3m
    nov                   ;Featureful EPUB reader mode
    sicp                  ;Structure and Interpretation of Computer Programs in info format
    phoenix-dark-mono-theme ;Monochromatic version of the Phoenix theme
    solarized-theme       ;The Solarized color theme
    nova-theme            ;A dark, pastel color theme
    nimbus-theme          ;An awesome dark theme
    color-theme-sanityinc-tomorrow ;A version of Chris Kempson's "tomorrow" themes
    j-mode                ;Major mode for editing J programs
    bqn-mode              ;Emacs mode for BQN
    vterm                 ;Fully-featured terminal emulator
    multi-vterm           ;Like multi-term.el but for vterm
    meow                  ;modal editng with multi cursors and leader key support
    rg                    ;A search tool based on ripgrep
    i-ching               ;The Book of Changes
    pdf-tools             ;Support library for PDF documents
    markdown-ts-mode      ;Major mode for Markdown using Treesitter
    ;picpocket             ;Image browser, with particular support for tag edit & filter
 ))

(defun my/packages-not-installed (pkgs)
  (seq-filter (lambda (x) (not (package-installed-p x))) pkgs))

(dolist (pkg (my/packages-not-installed (append my/packages
						my/packages-melpa)))
    (package-install pkg))


;;; for emacsclient
;;; alias em='emacsclient -t -a "emacs -Q -l ~/mg_init/init.el " '
(server-start)


(load-theme 'solarized-zenburn 1)

(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6bdc4e5f585bb4a500ea38f563ecf126570b9ab3be0598bdf607034bb07a8875"
     "b11edd2e0f97a0a7d5e66a9b82091b44431401ac394478beb44389cf54e6db28"
     "6fc9e40b4375d9d8d0d9521505849ab4d04220ed470db0b78b700230da0a86c1"
     "04aa1c3ccaee1cc2b93b246c6fbcd597f7e6832a97aaeac7e5891e6863236f9f"
     "76ddb2e196c6ba8f380c23d169cf2c8f561fd2013ad54b987c516d3cabc00216"
     "0281422e7ac95350d1c8593a0107860ed7045f30e51c59526fa2facb693f5262"
     "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36"
     "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5"
     "0489e00d609dd8d3262d03e2c72b1da0a040c25806c230c6602005be1db01e46"
     "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1"
     "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633"
     "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c"
     "3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077"
     "fdb9f6f42170d8bb9255ac3e0cdf370f2e65ba55b515c7456dac9379abb40e15"
     "c5e7a36784b1955b28a89a39fef7c65ddc455b8e7fd70c6f5635cb21e4615670"
     "524fa911b70d6b94d71585c9f0c5966fe85fb3a9ddd635362bfabd1a7981a307"
     "02fefdfc9a0c7256a10c8794a4985c9c70c5fbf674873b66807e8143e02c81a7"
     "763bf89898a06b03f7b65fbc29857a1c292e4350246093702fdbd6c4e46e2cf0"
     "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773"
     "d92c1c36a5181cf629749bf6feee1886cf6bce248ab075c9d1b1f6096fea9539"
     "07885feecd236e4ba3837e7ff15753d47694e1f9a8049400c114b3298285534e"
     "77f1e155387d355fbbb3b382a28da41cc709b2a1cc71e7ede03ee5c1859468d2"
     "de8f2d8b64627535871495d6fe65b7d0070c4a1eb51550ce258cd240ff9394b0"
     "e7820b899036ae7e966dcaaec29fd6b87aef253748b7de09e74fdc54407a7a02"
     "fffd03886983720ef3e4dd2df3cb65b51fa9ab5ec7fb5d6b5da838e64da6cc7d"
     "84f3df540486422ffd00faeae12dee08ac0da8ca317b80dd6167e0877b20edc7"
     "97cc75eac251451d5e20a9d5ac305231edcfbb7f76f4aa49baebeb04e53c4e53"
     "f5507a4256837202b3cf81c8e3b292c5a5ef73964bac2a43bf6b6c0b3d788686"
     "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e"
     "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659"
     "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c"
     "4c56af497ddf0e30f65a7232a8ee21b3d62a8c332c6b268c81e9ea99b11da0d3"
     "90a6f96a4665a6a56e36dec873a15cbedf761c51ec08dd993d6604e32dd45940"
     "f149d9986497e8877e0bd1981d1bef8c8a6d35be7d82cba193ad7e46f0989f6a"
     "a9e17ed60edf45b8aed389713f0826cde71c24aa464e1b1d36f71a0504699520"
     "c335adbb7d7cb79bc34de77a16e12d28e6b927115b992bccc109fb752a365c72"
     "551629d1e63bb66423dd80b3ec2d1a67611d1fa570e7238201e65b25a3b3834f"
     "1a6d120936f9df3f44953124dbf9e56b399e021702ca7d1844e6c5e1658b692b"
     default))
 '(large-file-warning-threshold nil)
 '(package-selected-packages
   '(0blayout 0x0 afternoon-theme ag ample-theme arduino-mode
	      benchmark-init blimp bqn-mode
	      color-theme-sanityinc-tomorrow counsel-tramp
	      darktooth-theme deft dired-single easysession evil
	      exec-path-from-shell f gptel howm i-ching j-mode
	      key-assist kv lispy magit markdown-mode markdown-ts-mode
	      material-theme meow monokai-theme multi-vterm
	      nimbus-theme nov nova-theme org-roam pdf-tools
	      phoenix-dark-mono-theme pyim-basedict qrencode
	      quelpa-use-package register-jump rg
	      sexy-monochrome-theme sicp sml-mode solarized-theme
	      tao-theme undo-tree vc-use-package vlf vundo w3m
	      wgrep-ag zoom)))
(put 'scroll-left 'disabled nil)
(put 'magit-diff-edit-hunk-commit 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bqn-default ((t (:family "Iosevka"))) t))
