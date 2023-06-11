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
(setq doom-themes-treemacs-theme nil)
(treemacs-resize-icons 18)
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

(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-show-code-actions t)

(after! company
  (map! :map company-active-map
        "<tab>" nil
        "TAB" #'company-complete-selection))

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

(setq mac-option-modifier nil
      mac-command-modifier 'meta)

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
      :m "f" #'avy-goto-char
      )
