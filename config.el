;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Shy Robin"
      user-mail-address "shy_robin@163.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 15))

;; treemacs font
(setq doom-variable-pitch-font (font-spec :family "SauceCodePro Nerd Font" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; 最大化窗口
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; 移除顶部标题栏
(add-to-list 'default-frame-alist '(undecorated . t))

;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode t)

;; 使用默认的彩色图标
(setq doom-themes-treemacs-config
      (setq doom-themes-treemacs-theme "doom-colors"))
(treemacs-resize-icons 16)
(map! :leader
      :desc "Treemacs"
      "e" #'treemacs)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(map! :leader
      (:prefix ("w" . "Window")
       :desc "Delete other windows"
       "o" #'delete-other-windows
       :desc "Split window below"
       "b" #'split-window-below
       :desc "Split window right"
       "r" #'split-window-right
       :desc "Select window"
       "w" #'ace-select-window
       :desc "Delete window"
       "d" #'ace-delete-window
       )
      (:prefix ("f" . "File")
        :desc "Format buffer"
        "a" #'lsp-format-buffer
        :desc "Format region"
        "v" #'lsp-format-region
      )
      )

(evil-define-key 'treemacs treemacs-mode-map (kbd "or") #'treemacs-visit-node-ace-horizontal-split)
(evil-define-key 'treemacs treemacs-mode-map (kbd "ob") #'treemacs-visit-node-ace-vertical-split)
(evil-define-key 'treemacs treemacs-mode-map (kbd "a") #'treemacs-create-file)
(evil-define-key 'treemacs treemacs-mode-map (kbd "A") #'treemacs-create-dir)

(setq centaur-tabs-set-close-button nil)
(setq centaur-tabs-height 28)
(setq centaur-tabs-show-new-tab-button nil)
(setq centaur-tabs-set-bar 'under)
(setq centaur-tabs-left-edge-margin nil)
(setq x-underline-at-descent-line t)

(map!
 :desc "Previous tab"
 :n "H" #'centaur-tabs-backward
 :desc "Next tab"
 :n "L" #'centaur-tabs-forward
 :desc "Move tab to left"
 :n "t h" #'centaur-tabs-move-current-tab-to-left
 :desc "Move tab to right"
 :n "t l" #'centaur-tabs-move-current-tab-to-right
 :desc "New tab"
 :n "t t" #'centaur-tabs--create-new-tab
 :desc "Close current tab"
 :n "t w" #'kill-this-buffer
 :desc "Close other tabs"
 :n "t o" #'centaur-tabs-kill-other-buffers-in-current-group
 :desc "Ace jump tab"
 :n "t j" #'centaur-tabs-ace-jump
)

(map!
  :desc "Find type definition"
  :n "g t" #'+lookup/type-definition
  :desc "Next flycheck error"
  :n "g n" #'flycheck-next-error
  :desc "Previous flycheck error"
  :n "g N" #'flycheck-previous-error
  :desc "Next flycheck error"
  :n "g j" #'flycheck-next-error
  :desc "Previous flycheck error"
  :n "g k" #'flycheck-previous-error
  :desc "List flycheck errors"
  :n "g l" #'+default/diagnostics
  :desc "Show doc glance"
  :n "g h" #'lsp-ui-doc-glance
  :desc "Peek find references"
  :n "g r" #'lsp-ui-peek-find-references
)

(with-eval-after-load 'evil
  (scroll-on-jump-advice-add evil-undo)
  (scroll-on-jump-advice-add evil-redo)
  (scroll-on-jump-advice-add evil-jump-item)
  (scroll-on-jump-advice-add evil-jump-forward)
  (scroll-on-jump-advice-add evil-jump-backward)
  (scroll-on-jump-advice-add evil-ex-search-next)
  (scroll-on-jump-advice-add evil-ex-search-previous)
  (scroll-on-jump-advice-add evil-forward-paragraph)
  (scroll-on-jump-advice-add evil-backward-paragraph)
  (scroll-on-jump-advice-add evil-goto-mark)

  ;; Actions that themselves scroll.
  (scroll-on-jump-with-scroll-advice-add evil-goto-line)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-down)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-up)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-center)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-top)
  (scroll-on-jump-with-scroll-advice-add evil-scroll-line-to-bottom)
)

(setq doom-modeline-vcs-max-length 20)
;; Whether display the modal state icon.
;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
(setq doom-modeline-modal-icon nil)

(ispell-change-dictionary "en_US" t)

(add-hook 'prog-mode-hook #'wucuo-start)
(add-hook 'text-mode-hook #'wucuo-start)

(setq ispell-program-name "aspell")
;; You could add extra option "--camel-case" for camel case code spell checking if Aspell 0.60.8+ is installed
;; @see https://github.com/redguardtoo/emacs.d/issues/796
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=16" "--camel-case"))

(map! :i "C-h" "<backspace>")

;; projectile discover projects in search path
(setq projectile-project-search-path '("~/Projects/"))

(map! :n "f" #'avy-goto-char
      :o "f" #'avy-goto-char
      )

(setq +treemacs-git-mode 'deferred)

;; 删除不影响剪贴板
(defun bb/evil-delete (orig-fn beg end &optional type _ &rest args)
    (apply orig-fn beg end type ?_ args))
(advice-add 'evil-delete :around 'bb/evil-delete)

;; move text
(define-key evil-visual-state-map (kbd "J") (concat ":m '>+1" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "K")   (concat ":m '<-2" (kbd "RET") "gv=gv"))

(after! treemacs
  (custom-set-faces!
  `(treemacs-git-unmodified-face :foreground "#ABB2BF" :weight normal)
  `(treemacs-git-added-face :foreground "#0EAA00" :weight normal)
  `(treemacs-git-modified-face :foreground "#E5C07B" :weight normal)
  `(treemacs-git-renamed-face :foreground "#C678DD" :weight normal)
  `(treemacs-git-deleted-face :foreground "#E06C75" :weight normal)
  `(treemacs-git-ignored-face :foreground "#4B5263" :weight normal)
  `(treemacs-git-conflict-face :foreground "#FF0000" :weight normal)
  `(treemacs-git-untracked-face :foreground "#0A7700" :weight normal))
  )

(use-package! rainbow-mode
  :hook (prog-mode . rainbow-mode))

(setq-hook! 'js-mode-hook +format-with-lsp nil)
(setq-hook! 'js-mode-hook +format-with :none)
(eval-after-load 'web-mode
    '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-js-mode)))
(eval-after-load 'typescript-mode
    '(progn
       (add-hook 'typescript-mode-hook #'add-node-modules-path)
       (add-hook 'typescript-mode-hook #'prettier-js-mode)))

(defun my-save-file-no-formatting ()
  (interactive)
  (let ((before-save-hook (remove 'prettier-js before-save-hook)))
    (save-buffer)))

(map! :leader
      :desc "Save file without formatting"
      "f n" #'my-save-file-no-formatting)

(advice-add 'json-parse-string :around
            (lambda (orig string &rest rest)
              (apply orig (s-replace "\\u0000" "" string)
                     rest)))

;; minor changes: saves excursion and uses search-forward instead of re-search-forward
(advice-add 'json-parse-buffer :around
            (lambda (oldfn &rest args)
	      (save-excursion
                (while (search-forward "\\u0000" nil t)
                  (replace-match "" nil t)))
		(apply oldfn args)))

(after! company
  ;;; Prevent suggestions from being triggered automatically. In particular,
  ;;; this makes it so that:
  ;;; - TAB will always complete the current selection.
  ;;; - RET will only complete the current selection if the user has explicitly
  ;;;   interacted with Company.
  ;;; - SPC will never complete the current selection.
  ;;;
  ;;; Based on:
  ;;; - https://github.com/company-mode/company-mode/issues/530#issuecomment-226566961
  ;;; - https://emacs.stackexchange.com/a/13290/12534
  ;;; - http://stackoverflow.com/a/22863701/3538165
  ;;;
  ;;; See also:
  ;;; - https://emacs.stackexchange.com/a/24800/12534
  ;;; - https://emacs.stackexchange.com/q/27459/12534

  ;; <return> is for windowed Emacs; RET is for terminal Emacs
  (dolist (key '("<return>" "RET"))
    ;; Here we are using an advanced feature of define-key that lets
    ;; us pass an "extended menu item" instead of an interactive
    ;; function. Doing this allows RET to regain its usual
    ;; functionality when the user has not explicitly interacted with
    ;; Company.
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
                  :filter ,(lambda (cmd)
                             (when (company-explicit-action-p)
                              cmd)))))
  ;; (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (map! :map company-active-map "TAB" #'company-complete-selection)
  (map! :map company-active-map "<tab>" #'company-complete-selection)
  (define-key company-active-map (kbd "SPC") nil)

  ;; Company appears to override the above keymap based on company-auto-complete-chars.
  ;; Turning it off ensures we have full control.
  (setq company-auto-commit-chars nil)
)

(after! doom-modeline
  (setq auto-revert-check-vc-info t)
  (setq doom-modeline-buffer-file-name-style "file-name")
  )

(after! why-this
  (global-why-this-mode))

(map! :leader
      "g j" #'diff-hl-next-hunk
      "g k" #'diff-hl-previous-hunk
      "g J" #'diff-hl-show-hunk-next
      "g K" #'diff-hl-show-hunk-previous
)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
