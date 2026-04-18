;; Setup Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Custom Functions

;;https://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs
(defun jr-duplicate-line ()
  "EASY"
  (interactive)
  (save-excursion
    (let ((line-text (buffer-substring-no-properties
                      (line-beginning-position)
                      (line-end-position))))
      (move-end-of-line 1)
      (newline)
      (insert line-text))))

;;https://stackoverflow.com/questions/3417438/close-all-buffers-besides-the-current-one-in-emacs
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer 
        (delq (current-buffer) 
              (cl-remove-if-not 'buffer-file-name (buffer-list)))))

;;https://stackoverflow.com/questions/20514360/opening-a-window-into-a-specified-buffer
(defun open-dir-at-right ()
  (interactive)         ;; Tell emacs this function can be called interactively
  (split-window-right)  ;; Just what C-x 3 does
  (dired "~/dev/datomic"))              ;; Just what M-x dired does

;; https://emacs.stackexchange.com/questions/46664/switching-between-horizontal-and-vertical-splitting
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun reload-conf ()
  (interactive)
  (load-file "~/.emacs"))

(defun foo-echo ()
  (message "echo! this is a message from foo command."))


;; Custom keybinding

;; duplicate line
(global-set-key "\C-cd" 'jr-duplicate-line)
;; kill other buffers
(global-set-key "\C-cK" 'kill-other-buffers)
;; fill region
(global-set-key "\C-c=" 'fill-region)
;; open current dirin right buffer
(global-set-key "\C-c3" 'open-dir-at-right)
;; reload emacs conf
(global-set-key (kbd "C-c L") 'reload-conf)

;; toggle window split
(global-set-key (kbd "C-c o") 'toggle-window-split)

;; resize window will repeat if keep holding the keys
(global-set-key (kbd "C-=") 'enlarge-window-horizontally)
(global-set-key (kbd "C--") 'shrink-window-horizontally)

;; Global Modes
(require 'vertico)
(add-hook 'after-init-hook #'vertico-mode)

;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq-default indent-tabs-mode nil)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)


;; Backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;; Hooks
;;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)

;; cider, inf-clojure
(add-hook 'clojure-mode-hook          #'inf-clojure-minor-mode)
;; (add-hook 'clojure-mode-hook #'cider-mode)

;; dumb jump
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

;; repl
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))

;; abbrevs
(add-hook 'clojure-mode-hook #'abbrev-mode)

;; alter key-bindings in paredit
(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map (kbd "M-s") 'nil))) ;; default paredit-splice-sexp

;; Globals
(global-display-line-numbers-mode 1)
(setq-default tab-width 2)
(setq inf-clojure-custom-startup nil)
(setq inf-clojure-custom-startup "clojure")
(setq inf-clojure-custom-startup "clojure -A:dev")
(setq inf-clojure-custom-startup "clojure -M:dev:morse")
(setq inf-clojure-custom-repl-type 'clojure)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tsdh-light))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-buffer-menu nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(inf-clojure vertico web-mode dumb-jump cider clojure-mode magit paredit))
 '(ring-bell-function 'ignore)
 '(tab-bar-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Menlo" :foundry "nil" :slant normal :weight regular :height 130 :width normal))))
 '(tool-bar ((t (:foreground "black" :box (:line-width (1 . 1) :style released-button))))))
(put 'erase-buffer 'disabled nil)
