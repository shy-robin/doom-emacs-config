;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "" ;; 不需要设置这两项信息，否则 blamer 中的 author name 会使用此信息
      user-mail-address "")
(setq all-the-icons-scale-factor 1)

(map! :i "C-h" "<backspace>")

;; 删除不影响剪贴板
(defun bb/evil-delete (orig-fn beg end &optional type _ &rest args)
    (apply orig-fn beg end type ?_ args))
(advice-add 'evil-delete :around 'bb/evil-delete)

;; move text
(define-key evil-visual-state-map (kbd "J") (concat ":m '>+1" (kbd "RET") "gv=gv"))
(define-key evil-visual-state-map (kbd "K")   (concat ":m '<-2" (kbd "RET") "gv=gv"))

(map! :leader
    :desc "Save file without formatting"
    "f n" #'my-save-file-no-formatting)

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

;; (setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 15))
(setq doom-font (font-spec :family "IntelOne Mono" :size 15))

;; treemacs font
;; (setq doom-variable-pitch-font (font-spec :family "SauceCodePro Nerd Font" :size 15))
(setq doom-variable-pitch-font (font-spec :family "IntelOne Mono" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

(setq display-line-numbers-type 'relative)

;; 最大化窗口
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; 移除顶部标题栏
(add-to-list 'default-frame-alist '(undecorated . t))

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
)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~/org/")
(setq org-log-done 'note)
(setq org-log-into-drawer t)
(setq org-todo-keywords
      '((sequence "TODO(t!)" "|" "DONE(d@)")
        (sequence "REPORT(r!)" "BUG(b!)" "KNOWNCAUSE(k!)" "|" "FIXED(f@)")))
;; (setq org-tag-alist '(("shy1" . ?s) ("robin1" . ?r)))

(map!
    :map org-mode-map
    :n "g l" #'org-down-element
    :n "g h" #'org-up-element
    :n "g j" #'org-next-visible-heading
    :n "g k" #'org-previous-visible-heading
    :n "g J" #'org-forward-element
    :n "g K" #'org-backward-element
)

;;Exit insert mode by pressing j and then j quickly
(after! key-chord
    (setq key-chord-two-keys-delay 0.5)
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
    (key-chord-mode t)
)

(after! treemacs
    ;; 使用默认的彩色图标
    (setq doom-themes-treemacs-config
        (setq doom-themes-treemacs-theme "doom-colors"))
    (treemacs-resize-icons 16)
    (setq +treemacs-git-mode 'deferred)
    (evil-define-key 'treemacs treemacs-mode-map (kbd "or") #'treemacs-visit-node-ace-horizontal-split)
    (evil-define-key 'treemacs treemacs-mode-map (kbd "ob") #'treemacs-visit-node-ace-vertical-split)
    (evil-define-key 'treemacs treemacs-mode-map (kbd "a") #'treemacs-create-file)
    (evil-define-key 'treemacs treemacs-mode-map (kbd "A") #'treemacs-create-dir)

    (custom-set-faces!
        `(treemacs-git-unmodified-face :foreground "#ABB2BF" :weight normal)
        `(treemacs-git-added-face :foreground "#0EAA00" :weight normal)
        `(treemacs-git-modified-face :foreground "#E5C07B" :weight normal)
        `(treemacs-git-renamed-face :foreground "#C678DD" :weight normal)
        `(treemacs-git-deleted-face :foreground "#E06C75" :weight normal)
        `(treemacs-git-ignored-face :foreground "#4B5263" :weight normal)
        `(treemacs-git-conflict-face :foreground "#FF0000" :weight normal)
        `(treemacs-git-untracked-face :foreground "#0A7700" :weight normal)
        `(treemacs-root-face :height 1.1)
    )

    (treemacs-project-follow-mode)
)
(map! :leader
    :desc "Treemacs"
    "e" #'treemacs
)

(after! ace-window
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
)

(map! :leader
    (:prefix ("f" . "File")
        :desc "Format buffer"
        "a" #'lsp-format-buffer
        :desc "Format region"
        "v" #'lsp-format-region
    )
)

(after! centaur-tabs
    (setq centaur-tabs-set-close-button nil)
    (setq centaur-tabs-height 25)
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
)

(map!
    :map prog-mode-map
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
)

(map!
    :desc "Show doc glance"
    :n "g h" #'lsp-ui-doc-glance
    :desc "Peek find references"
    :n "g r" #'lsp-ui-peek-find-references
)

(setq +lsp-company-backends '(:separate company-yasnippet company-capf))
(setq lsp-lens-enable nil)
;; (setq lsp-eldoc-enable-hover nil)

(after! doom-modeline
    (setq doom-modeline-vcs-max-length 999)
    ;; Whether display the modal state icon.
    ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
    (setq doom-modeline-modal-icon nil)
    (setq auto-revert-check-vc-info t)
    (setq doom-modeline-buffer-file-name-style "file-name")
    (setq doom-modeline-height 1)
    (set-face-attribute 'mode-line nil :height 150)
    (set-face-attribute 'mode-line-inactive nil :height 150)
)

;; ispell 是 Emacs 的内置拼写检查工具。
;; flyspell 是 Emacs 的一个模块，用于实时拼写检查。它会在你输入文本时自动进行拼写检查，并标记出可能的拼写错误。
;; aspell 是一个独立的拼写检查工具，与 Emacs 配合使用。它提供了更强大和灵活的拼写检查功能，支持多种语言和自定义字典。在 Doom Emacs 中，aspell 通常被用作 flyspell 的后端引擎，提供了更准确的拼写检查和更丰富的字典。

(ispell-change-dictionary "en_US" t)

(add-hook 'prog-mode-hook #'wucuo-start)
(add-hook 'text-mode-hook #'wucuo-start)

(setq ispell-program-name "aspell")
;; You could add extra option "--camel-case" for camel case code spell checking if Aspell 0.60.8+ is installed
;; @see https://github.com/redguardtoo/emacs.d/issues/796
(setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=16" "--camel-case"))

(after! ispell
  (setq ispell-personal-dictionary "~/.config/doom/.spell/my-words"))

;; projectile discover projects in search path
(setq projectile-project-search-path '("~/Projects/"))

(map! :n "f" #'avy-goto-char
      :o "f" #'avy-goto-char
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

;; fix: complete objects error
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

(after! diff-hl
    (map! :leader
        "g j" #'diff-hl-next-hunk
        "g k" #'diff-hl-previous-hunk
        "g J" #'diff-hl-show-hunk-next
        "g K" #'diff-hl-show-hunk-previous
    )
)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(after! blamer
    (setq blamer-View 'overlay-right)
    (setq blamer-author-formatter "%s")
    (setq blamer-datetime-formatter " <%s> ")
    (setq blamer-commit-formatter "%s")
    (setq blamer-min-offset 40)
    (custom-set-faces!
        `(blamer-face :italic nil :foreground "#62686E")
    )
)
(global-blamer-mode 1)

(map!
    :n "C-n" #'evil-multiedit-match-and-next
    :v "C-n" #'evil-multiedit-match-and-next
)
(map!
    :map evil-multiedit-mode-map
    :n "C-n" nil
    :n "C-p" nil
    :n "R" #'evil-multiedit-match-all
    :n "C-j" #'evil-multiedit-next
    :n "C-k" #'evil-multiedit-prev
    :i "C-j" #'evil-multiedit-next
    :i "C-k" #'evil-multiedit-prev
)

(setq web-mode-part-padding 0)
(setq web-mode-style-padding 0)
(setq web-mode-script-padding 0)
