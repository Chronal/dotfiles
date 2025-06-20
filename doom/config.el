;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "Anuj"
      user-mail-address "chronal@chronal.space")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme (seq-random-elt '(doom-bluloco-dark
                                   doom-henna
                                   doom-horizon
                                   doom-laserwave
                                   doom-molokai
                                   doom-monokai-octagon
                                   doom-monokai-spectrum
                                   doom-oceanic-next
                                   doom-palenight
                                   doom-shades-of-purple
                                   doom-snazzy
                                   doom-tokyo-night
                                   doom-xcode)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Makes doom start up full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Doom Leader Keys
(setq doom-leader-key "SPC"
      doom-localleader-key ",")

;; If you use `org' and don't want your org files in the default location below,0
;; change `org-directory'. It must be set before org loads!

;; Org
(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/Documents/org-roam/")
(setq org-attach-id-dir "~/Documents/org/.attach/")

(setq org-log-done 'time)
(setq org-log-into-drawer t)

(add-to-list 'org-modules 'org-habit)

;; org-agenda
(setq org-agenda-files '("~/Documents/org/todo.org"
                         "~/Documents/org/csiro.org"
                         "~/Documents/org/uni.org"
                         "~/Documents/org/reading_list.org"))

(setq org-agenda-log-mode-items '(closed clock state))
(setq org-agenda-start-with-clockreport-mode t)
(setq org-agenda-start-with-log-mode nil)

(setq org-return-follows-link t)

;; org-download
(setq org-download-screenshot-method "spectacle --region --output=%s")

;; Org Roam
(setq org-roam-capture-templates
      '(("d" "default" plain "%?" :target
         (file+head "${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)))

;; Citation
(setq bibfile-list
      '("~/Documents/org/articles_papers_misc.bib"
        "~/Documents/org/books.bib"
        "~/Documents/org/fiction.bib"))

;; (setq reftex-default-bibliography)
(setq lib-folders '("~/Documents/papers/" "~/Documents/books/"))

;; Citar
(setq bibtex-completion-bibliography bibfile-list)
(setq citar-bibliography bibfile-list)
(setq citar-library-paths lib-folders
      citar-notes-paths '("~/Documents/org-roam" "~/Documents/org"))

(map!
 :map doom-leader-notes-map
 :desc "Open Library file"
 "F" #'citar-open-files)

(after! citar
  (setq citar-file-open-functions '((t . citar-file-open-external))))

;;; Ebib
(setq ebib-preload-bib-files bibfile-list)
(setq ebib-reading-list-file "~/Documents/org/reading_list.org")
(setq ebib-file-search-dirs lib-folders)
(setq ebib-bibtex-dialect 'biblatex)
(setq ebib-file-associations '(("pdf" . "okular")
                               ("ps" . "okular")
                               "epub" . "foliate"))
;;; Bibtex
(setq bibtex-autokey-year-title-separator "_")

(use-package! ebib
  :config
  (map! :map doom-leader-notes-map
        "B" #'ebib))

(use-package! biblio)
(use-package! ebib-biblio
  :after (ebib biblio)
  :bind (:map ebib-index-mode-map
         ("B" . ebib-biblio-import-doi)
         :map biblio-selection-mode-map
         ("e" . ebib-biblio-selection-import)))

(after! dirvish
  (setq! dirvish-quick-access-entries
         `(("h" "~/"                "home")
           ("c" "~/code/"           "code")
           ("d" "~/Downloads/"      "Downloads")
           ("o" "~/Documents/org/"  "org"))))

;; Treemacs
(after! treemacs
  (setq treemacs-git-mode 'extended)
  (setq treemacs-indent-guide-mode t)
  (setq treemacs-show-hidden-files nil))

;;; Treemacs and Dirvish both bind SPC-o-p
;;; to open in the sidebar. In the evil config
;;; dirivish is setup afterwards so takes precedence
(map! :after evil
      :map doom-leader-open-map
      "p" #'+treemacs/toggle
      "P" #'treemacs-find-file)

;; Setting the scratch buffer default mode to org
(setq initial-major-mode 'org-mode)

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

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t)

  (map! :after org-roam
        :map doom-leader-notes-map
        :prefix "r"
        "u" #'org-roam-ui-open))

;;; Lisp Config
;; Adds more things to lispy
(after! lispyville
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     (prettify insert)
     (atom-motions normal visual)
     slurp/barf-lispy
     text-objects
     additional
     additional-insert
     additional-motions
     commentary
     (additional-wrap normal insert))))

;; Racket
(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

;; sly for common-lisp
(after! sly
  :config
  (setq! sly-complete-symbol-function 'sly-flex-completions)
  ;; (add-hook! 'sly-mrepl-mode-hook #'lispy-mode)
  (add-to-list '+lisp-quicklisp-paths "~/.local/share/quicklisp"))

;; Emacs should use this internally
(setq shell-file-name (executable-find "bash"))

;; And fish otherwise
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")
