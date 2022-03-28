(setenv "PATH" (concat (getenv "PATH") ":/Users/anoj/Library/Python/3.8/bin/:/usr/local/bin/:/usr/bin/:/Users/anoj/.nvm/versions/node/v14.19.0/bin/"))
(setq exec-path (append exec-path '("/Users/anoj/Library/Python/3.8/bin" "/usr/local/bin" "/usr/bin" "/Users/anoj/.nvm/versions/node/v14.19.0/bin/")))

;; Disable tab indents, use spaces
(setq-default indent-tabs-mode nil)

;; Disable auto backup files
(setq make-backup-files nil)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

;; Set up the visible bell
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(menu-bar-mode -1)            ; Disable the menu bar

;; Global line highlight
(global-hl-line-mode 1)

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode 1)
;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; IVY Mode
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history)
         ("C-M-l" . counsel-imenu))
  :config
  (setq ivy-install-inputs-alist nil)
  (counsel-mode 1))


;; Mode Line
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  ((doom-modeline-height 15)
   (setq doom-modeline-persp-icon t)
   (setq doom-modeline-lsp t)
   (setq doom-modeline-github nil)
   (setq doom-modeline-modal-icon t)
   (setq doom-modeline-modal-icon t)
   (setq doom-modeline-env-version t)
   (setq doom-modeline-env-load-string "...")))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key)))

(use-package projectile
  :diminish (projectile-mode)
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Dev")
    (setq projectile-project-search-path '("~/Dev")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; TODO: Mode this to another section
(setq-default fill-column 80)

;; Turn on indentation and auto-fill mode for Org files
(defun ap/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (diminish org-indent-mode))

(use-package org
  :hook (ap/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list ("◉" "○" "●" "○" "●" "○" "●"))

  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))

    (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'medium :height (cdr face))

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

    ;; Get rid of the background on column views
    (set-face-attribute 'org-column nil :background nil)
    (set-face-attribute 'org-column-title nil :background nil)))


;; LSP Configuration
(defun ap/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(setq ccls-executable "/usr/local/bin/ccls")
(setq ccls-args '("--log-file=/tmp/ccls.log"))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (lsp-mode . ap/lsp-mode-setup)
         (python-mode . lsp-deferred)
	 (typescript-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-enabled-clients '(ccls pylsp ts-ls))
  (setq lsp-disabled-clients '(clangd))
  (setq lsp-auto-configure t)
  (setq lsp-pyls-plugins-flake8-enabled t)

  ;; make sure we have lsp-imenu everywhere we have LSP
  :commands lsp)

(use-package which-key
    :config
    (which-key-mode))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)  
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-sideline-show-code-actions t)
  (lsp-ui-doc-show))


(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :after lsp)

(use-package ccls
  :ensure t
  :hook ((c-mode) .
         (lambda () ((require 'ccls) (lsp))
           (lsp-enabled-clients . ccls))))

;; Company Mode
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
  (global-company-mode t)
  (setq lsp-completion-provider :capf))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Dired Setup
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom (setq dired-use-ls-dired t
                insert-directory-program "/usr/local/bin/gls"
                dired-listing-switches "-aBhl --group-directories-first"))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode))

(use-package iedit)

(use-package ag)

(use-package flycheck)
(use-package blacken)

(use-package ivy-xref
  :ensure t
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

;; Expand Region
(use-package expand-region
  :ensure t
  :bind
  (("C-=" . er/expand-region)
   ("C--" . er/contract-region)))


(use-package ccls
  :ensure t
  :config
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache")
    )
  (setq ccls-executable "/usr/local/bin/ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls) (lsp))))

;;////////////////////////////////////////////////////////////////////////////////////////////////////
;; Prog Setup
(use-package json-mode
  :ensure t)
;; JSON Mode

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook ((typescript-mode . lsp-deferred)
         (typescript-mode . prettier-js))
  :config
  (setq typescript-indent-level 2))

;; web-mode
(use-package web-mode
  :ensure t
  :mode (("\\.jsx\\'" .  web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.html\\'" . web-mode))
  :commands web-mode
  :hook ((web-mode . lsp-deferred))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2))

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
	  (funcall (cdr my-pair)))))

(use-package prettier-js
  :ensure t
  :hook ((web-mode . (lambda ()
                             (enable-minor-mode
                              '("\\.jsx?\\'" . prettier-js-mode))
			     (enable-minor-mode
                              '("\\.tsx?\\'" . prettier-js-mode))))
         (typescript-mode . (lambda ()
                             (enable-minor-mode
                              '("\\.ts?\\'" . prettier-js-mode))))))

;; Python Config
(use-package python-mode
  :ensure t
  :hook ((python-mode . lsp-deferred)
         (python-mode . flycheck-mode)
         (python-mode . blacken-mode))
  :custom
  (python-shell-interpreter "python3"))

(use-package yaml-mode
  :ensure t)

;; C - Mode
(setq c-default-style "k&r")
(setq-default c-basic-offset 8)

;; Global Key Bindings
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" default))
 '(ivy-mode t)
 '(package-selected-packages
   '(prettier-js web-mode json-mode expand-region company-lsp which-key lsp-imenu typescript-mode blacken dired-hide-dotfiles dired-open all-the-icons-dired dired-single company-box company lsp-treemacs lsp-ivy lsp-ui ccls ivy-xref eglot company-jedi lsp-jedi elpy yaml-mode flycheck ag iedit js2-mode python-mode org-bullets magit counsel-projectile projectile doom-themes helpful counsel ivy-rich rainbow-delimiters rainbow-delimeters doom-modeline ivy command-log-mode use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
