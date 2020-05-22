;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
   (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t))
  ;; (when (< emacs-major-version 24)
  ;;   ;; For important compatibility libraries like cl-lib
  ;;   (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Global prettify symbols: \\forall -> \forall (upside-down A) in LaTeX
(global-prettify-symbols-mode +1)

;; Highlight the entire line the cursor is on
;;(global-hl-line-mode +1)

;; Mouse features in a TTY emulator
(setq xterm-mouse-mode t)

;; Disable toolbar
(tool-bar-mode -1)

;; Disable async-shell-command from spawning a buffer
(add-to-list 'display-buffer-alist
             (cons "\\*Async Shell Command\\*.*"
                   (cons #'display-buffer-no-window nil)))

;; Change word delimiters, Let _ and : constitute words
(modify-syntax-entry ?_ "w")
(modify-syntax-entry ?: "w")

;; Entry keyboard macro
;; (fset 'entry
;;    "\C-m\C-p\\entry{\C-u\C-[!date\C-m\C-e}\C-m\C-m")
(defun entry (arg color)
  "Prints an entry for notes. Includes date generated by shell
command, and a paremeterized color"
  (interactive "p\nsEntry Color: ")
  (insert (format
           "\\begin{entry}{%s}{%s}\\label{entry:%s}\n\n\n\n\\end{entry}\n"
           color
           (shell-command-to-string
            "date --iso-8601='seconds' | tr -d '\n' ")
           (shell-command-to-string
            "date +%Y%m%d%H%M%S | tr -d '\n' ")
           ))
  (backward-char 14))
;; Function to copy to clipboard
(defun clip ()
  (interactive)
  (if (use-region-p)
      (shell-command
       (format
        "echo '%s' | xclip -selection c"
        (buffer-substring (mark) (point))))
    ()))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ibuffer over buffer-list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual Bell adjustment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ring-bell-function
      (lambda ()
        (let ((orig-fg (face-foreground 'mode-line)))
          (set-face-foreground 'mode-line "#FF8040")
          (run-with-idle-timer 0 nil
                               (lambda (fg) (set-face-foreground
                                        'mode-line fg)) orig-fg))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable Ido mode errwhere
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(defun ido-define-keys ()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable linum-mode unless file too large
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; (global-linum-mode 0)
;; (defun buffer-too-big-p ()
;;   (or (> (buffer-size) (* 5000 80))
;;       (> (line-number-at-pos (point-max)) 5000)))
;; (add-hook 'prog-mode-hook
;; 	  (lambda ()
;; 	    ;; turn off `linum-mode' when there are more than 5000 lines
;; 	    (if (buffer-too-big-p) (linum-mode -1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight Indents
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (file-exists-p "~/.emacs.d/highlight-indents/")
    (progn (add-to-list 'load-path "~/.emacs.d/highlight-indents/")
           (require 'highlight-indentation)
           (add-hook 'prog-mode-hook 'highlight-indentation-mode) )
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load Path
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (if (file-exists-p "~/.emacs.d/LanguageTool-3.5/")
;;     (progn (add-to-list 'load-path "~/.emacs.d/LanguageTool-3.5/")
;;            (require 'langtool)
;;            (global-set-key "\C-x4w" 'langtool-check-buffer)
;;            (global-set-key "\C-x4W" 'langtool-check-done)
;;            (global-set-key "\C-x4n" 'langtool-goto-next-error)
;;            (global-set-key "\C-x4p" 'langtool-goto-previous-error)
;;            (global-set-key "\C-x44" 'langtool-show-message-at-point)

;;            (setq langtool-java-bin "/usr/bin/java")
;;            )
;;   nil)
;; langtool setup
;; (setq langtool-java-classpath
;;       "/usr/share/languagetool:/usr/share/java/languagetool/*")
;; (require 'langtool)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Save backup directory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENCODING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)
;; Treat clipboard input as UTF-8 string first; compund text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SET THEME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (advice-add #'x-apply-session-resources :override #'ignore)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'dracula t)
;; Set background color
;;(add-to-list 'default-frame-alist '(background-color . "color-236"))
;; Don't display a background
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)
(defun on-frame-open (frame)
  (if (not (display-graphic-p frame))
    (set-face-background 'default "unspecified-bg" frame)))
(on-frame-open (selected-frame))
(add-hook 'after-make-frame-functions 'on-frame-open)

(global-visual-line-mode 1); Proper line wrapping
;; (global-hl-line-mode 1); Highlight current row
(show-paren-mode 1); Matches parentheses and such in every mode
;;(set-fringe-mode '(0 . 0)); Disable fringe because I use visual-line-mode
(setq inhibit-splash-screen t); Disable splash screen
(setq visible-bell t); Flashes on error

;; Disable blinking cursor
(setq visible-cursor nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Proof General Package / Coq things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Open .v files with Proof General's Coq mode
;;(load "~/.emacs.d/lisp/PG/generic/proof-site")
;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)
;; Pretty symbols with company-coq
(setq company-coq-features/prettify-symbols-in-terminal t)
;; Auto-complete externally defined symbols
(setq company-coq-live-on-the-edge t)
;; I appreciate the effort of writing a splash-screen, but the angry
;; general on the gif scares me.
(setq proof-splash-seen t)

;;; Hybrid mode is by far the best.
(setq proof-three-window-mode-policy 'hybrid)

;;; I don't know who wants to evaluate comments
;;; one-by-one, but I don't.
(setq proof-script-fly-past-comments t)

(with-eval-after-load 'coq
  ;; The most common command by far. Having a 3(!)
  ;; keys long sequence for this command is just a
  ;; crime.
  (define-key coq-mode-map "\C-c\M-n"
    'proof-assert-until-point-interactive)
  (defun insert_arrow () (interactive) (insert "->"))
  (define-key coq-mode-map (kbd "M--") #'insert_arrow)
  )


;;   ;; Proof Navigation Didn't work for me. So please
;;   ;; stand aside for my paragraph navigation.
;;   ;; https://endlessparentheses.com/meta-binds-part-2-a-peeve-with-paragraphs.html
;;   (define-key coq-mode-map "\M-e" nil)
;;   (define-key coq-mode-map "\M-a" nil)

;;   ;; Small convenience for commonly written commands.
;;   (define-key coq-mode-map "\C-c\C-m" "\nend\t")
;;   (define-key coq-mode-map "\C-c\C-e"
;;     #'endless/qed)
;;   (defun endless/qed ()
;;     (interactive)
;;     (unless (memq (char-before) '(?\s ?\n ?\r))
;;       (insert " "))
;;     (insert "Qed.")
;;     (proof-assert-next-command-interactive)))

;; (defun open-after-coq-command ()
;;   (when (looking-at-p " *(\\*")
;;     (open-line 1)))

;; (when (fboundp 'company-coq-initialize)
;;   (add-hook 'coq-mode-hook #'company-coq-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sail highlighting package  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (file-exists-p "~/.emacs.d/sail/")
    (progn
      (add-to-list 'load-path "~/.emacs.d/sail/")
      (load "sail-mode"))
  nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LATEX STUFF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell check when entering latex-mode
;;(add-hook 'tex-mode-hook #'flyspell-mode)
(add-hook 'tex-mode-hook (lambda () (set-fill-column 85)))
(add-hook 'tex-mode-hook (lambda () (column-number-mode 1)))
(add-hook 'tex-mode-hook (lambda () (flyspell-buffer)))
;; AUC TeX
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook (lambda () (flyspell-buffer)))
;; Needed for latex many packages
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; Use xetex (instead of pdflatex) 
(setq-default TeX-engine 'xetex)
;; Ask for master file when using \input
(setq-default TeX-master nil)
;; Set up reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
(defun reftex-format-cref (label def-fmt reftype)
  (format "\\cref{%s}" label))
(setq reftex-format-ref-function 'reftex-format-cref)
;; Set default tex compiler
(setq-default TeX-engine 'xetex)
;; Produce PDF by default 
(setq-default TeX-PDF-mode t)
;; enable fold-mode by default in tex-files
(add-hook 'TeX-mode-hook (lambda ()
                           (progn
                             (TeX-fold-mode 1)
                             ;; Enable folding of cref
                             (add-to-list 'TeX-fold-macro-spec-list '("[cr]" ("cref" "Cref"))))))
(defun LaTeX-mode-kbd ()
  (local-set-key (kbd "M-o") 'delete-other-windows)
  (local-set-key (kbd "C-M-o") 'delete-window)
  (local-set-key (kbd "C-j") 'jump-to-register)
  (local-set-key (kbd "M-j") 'point-to-register)
  )
(add-hook 'LaTeX-mode-hook 'LaTeX-mode-kbd)
;; Add lstlisting to the set of verbatim environments
(add-to-list 'LaTeX-verbatim-environments "lstlisting")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(normal-erase-is-backspace-mode 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fill Column
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default fill-column 85)

;; Make _ a symbol constituent in the standard syntax table (inherited by most)
;; (modify-syntax-entry ?_ "_");; standard-syntax-table)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-Mode prettyness
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default c-basic-offset 2
              tab-width 2
              indent-tabs-mode nil)
(defun pretty-c ()
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-cont '0)
  (c-set-offset 'case-label '+))
(add-hook 'c-mode-hook 'pretty-c)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Verilog-Mode Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'verilog-mode-hook 
          (lambda () (local-set-key (kbd "M-*") 'pop-tag-mark)))



;; Line-number mode format, linum 
(require 'linum)
;; use customized linum-format: add a addition space after the line number
(setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

;; disable menubar
(menu-bar-mode -1)

;; Set TAB to indent in bibtex-mode
(defun bibtex-mode-tab ()
  (local-set-key (kbd "TAB") 'indent-for-tab-command)
  (local-set-key (kbd "M-q") 'fill-individual-paragraphs)
  )
(add-hook 'bibtex-mode-hook 'bibtex-mode-tab)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODIFIED KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-i") 'ido-goto-symbol)
                                        ;(global-set-key (kbd "M-RET") 'open-line)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "M-r") 'replace-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'rgrep)
(global-set-key (kbd "C-x {") 'shrink-window)
(global-set-key (kbd "C-x }") 'enlarge-window)
(global-set-key (kbd "C-x [") 'shrink-window-horizontally)
(global-set-key (kbd "C-x ]") 'enlarge-window-horizontally)
(global-set-key (kbd "M-o") 'delete-other-windows)
(global-set-key (kbd "C-M-o") 'delete-window)
(global-set-key (kbd "M-j") 'point-to-register)
(global-set-key (kbd "C-j") 'jump-to-register)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-5-face ((t (:foreground "brightyellow" :weight bold)))))
(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open"))))
 '(cdlatex-paired-parens "$([{")
 '(custom-safe-themes
   (quote
    ("55c2c0d811cdecd311ebe27f82b24a5410d38c1ff6117c91e5ba88031829ee06" default)))
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (auctex pdf-tools markdown-mode helm fzf sml-mode rainbow-mode multiple-cursors company-coq pretty-symbols auto-complete flycheck boogie-friends)))
 '(safe-local-variable-values (quote ((TeX-master . t))))
 '(verilog-align-ifelse t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-inst-vector nil)
 '(verilog-auto-newline nil)
 '(verilog-auto-save-policy nil)
 '(verilog-auto-template-warn-unused t)
 '(verilog-case-indent 3)
 '(verilog-cexp-indent 3)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 3)
 '(verilog-indent-level-behavioral 3)
 '(verilog-indent-level-declaration 3)
 '(verilog-indent-level-module 0)
 '(verilog-tab-to-comment t))

