;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Title: .emacs configuration for people who don't normally use Emacs, but still want to use org-mode.
;; Author: Jacob Levernier (except when otherwise noted)
;; Date: 2017-03-07
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up the package manager, so that org-mode is available and packages can be easily downloaded and installed from the melpa repository
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize) ;; Load packages

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End package manager setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Easily list packages in this one central place. You'll be asked automatically whether you'd like to install any packages in this list that aren't currently installed the next time you start Emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; From http://blog.aaronbieber.com/2015/05/24/from-vim-to-emacs-in-fourteen-days.html: Automatically ensure that a list of packages is installed on startup:

(defun ensure-package-installed (&rest packages)
  "Ensure that every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed
 'helm ;; For a dashboard
 'flycheck ;; For Syntax checking
 'powerline
 'solarized-theme ;; This can then be activated with M-x load-theme
 'markdown-mode
 'markdown-mode+
 'darkroom
 'scroll-restore ;; For allowing scrolling without moving the cursor once it goes off-screen.
 ;;'org-bullets ;; For nicer bullets (replacing multiple **s with UTF-8 bullets) in org-mode. UPDATE: I've disabled this for now because it slows down org-mode by up to several seconds.
 'org-repo-todo ;; For todo functionality within a repo.
 'org-journal ;; An org-mode-based journal
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of package list to automatically install
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable other settings for making Emacs' interface easier to use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;; Ivy-mode
;;;;;;;;;;;;;;;

(ivy-mode 1) ;; Enable ivy-mode, which makes menus in Emacs nicer-looking and searchable.

;;;;;;;;;;;;;;;
;; Scroll-restore-mode (for saving your place when you scroll with your mouse)
;;;;;;;;;;;;;;;

(scroll-restore-mode 1) ;; Change to nil to disable, and 1 to enable, scroll-restore mode by default
(global-set-key (kbd "C-x j") 'scroll-restore-jump-back) ;; Set a keybinding for jumping back when scrolling.

;;;;;;;;;;;;;;;
;; Load the Darkroom package (useful for writing prose -- it brings in the margins of the interface to offer less distraction when writing)
;;;;;;;;;;;;;;;

(require 'darkroom)

;;;;;;;;;;;;;;;
;; Powerline (for making the status bar at the bottom of the page more useful)
;;;;;;;;;;;;;;;

(require 'powerline)
(powerline-default-theme) ;; Turn on powerline

;;;;;;;;;;;;;;;
;; Font, text display, and color theme settings
;;;;;;;;;;;;;;;

;; Load solarized theme on startup
(load-theme 'solarized-light t)
;;(load-theme 'solarized-dark t) ;; Uncomment this for the solarized dark theme instead of the solarized light theme.

;; Set font to 16 pt. (1/10 font x 160):
(set-face-attribute 'default nil :height 160)

;; Word-wrap by word instead of character by default:
(setq-default word-wrap t)

;;;;;;;;;;;;;;;
;; Misc. interface settings
;;;;;;;;;;;;;;;

;; Set zoom in and out to Ctrl + and Ctrl - (By default, they're C-x C-+ and C-x C--, respectively)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Don't display the 'Welcome to GNU Emacs' buffer on startup
(setq inhibit-startup-message t)

;; From https://www.emacswiki.org/emacs/SmoothScrolling: Enable smooth scrolling with the mouse:
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Cause window titles to display the current buffer's name (rather than just "emacs@computer-name")
(setq-default frame-title-format '("%b"))

;; Make Emacs function like a 'normal' text editor (with enhancements for plaintext tables), by:
  ;; Entering 'CUA' mode, which enables the C-z, C-s, C-c, C-v, etc. keybindings that are used in many other editors, as well as Shift-based text selection.
  ;; Enabling orgtbl-mode (via orgstruct-mode). This allows you to type
    ;;  | 1 | 2 | 3 |
    ;;  and press tab for a nicely-formatted ASCII table.
  ;; Enabling scroll-restore-mode. You can press C-S-z to return to a point after scrolling.
  ;;(orgstruct-mode) ;; Following https://www.gnu.org/software/emacs/manual/html_node/org/Tables-in-arbitrary-syntax.html#Tables-in-arbitrary-syntax, enable the use of orgtbl-mode (for tables) without actually turning on all of org-mode.
  ;;(orgtbl-mode) ;; Enable orgtbl-mode, where you can put pipe symbols around something and press Tab and it will format into a nice table for you.
  (scroll-restore-mode 1)
  (setq cursor-type '(bar . 2))
  
  (global-set-key (kbd "C-s") 'save-buffer) ;; Map C-s to Save
  (global-set-key (kbd "C-o") 'find-file) ;; Map C-o to Open
  (global-set-key (kbd "C-S-z") 'undo-tree-redo) ;; Map C-o to Open
  

  ;; Following http://stackoverflow.com/a/36707038, get isearch-forward to automatically wrap:
  (defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))
  
  ;; Make C-f activate search-forward
  (global-set-key (kbd "C-f") 'isearch-forward)
  (define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

  ;; From https://www.emacswiki.org/emacs/CuaMode: Activate CUA mode, which makes Emacs function with keybindings like in a "normal" editor : )
  (cua-mode t)
  (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
  (transient-mark-mode nil) ;; No region when it is not highlighted
  (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
  
  ;; Tell emacs to still use CUA keybindings in org-mode, which would otherwise replace some of them:
  (setq org-support-shift-select t)
  (setq org-replace-disputed-keys t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of extra interface configurations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DO NOT EDIT THIS SECTION MANUALLY
;; Variables configured from within Emacs
;; (Press C-h v for help understanding a variable -- type the variable's name, then press "edit"/"change", and choose a new setting for that variable. If you then click "Apply and Save", the change will be recorded here.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
	("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(darkroom-margins 0.2)
 '(delete-selection-mode nil)
 '(org-hide-leading-stars t)
 '(org-journal-date-format "%A, %Y-%m-%d")
 '(org-journal-file-format "%Y-%m-%d.org")
 '(org-startup-truncated nil)
 '(scroll-restore-handle-cursor t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of variable settings made from within Emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tab vs. Spaces settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make <tab> actually insert a tabstop, following (but editing from)  http://www.creativeadea.com/uncategorized/force-emacs-to-use-tabs:
(setq-default indent-tabs-mode t)

;; Bind the TAB key
(global-set-key (kbd "TAB") 'self-insert-command)

;; Set the tab width
(setq-default default-tab-width 3)
(setq-default tab-width 3)
(setq-default c-basic-indent 3)
(setq-default c-basic-offset 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of tab vs. spaces settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigating between windows:
;;;;;;;;;;;;;;;;;;;;;;;;

;; Set custom keybindings for moving among windows (since org-mode takes over shift and alt/meta, and I like using the control key for moving quickly over words). The lowercase 's-' is for the Windows key (Not the Shift key (which is S-, with an uppercase S):
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of settings for navigating between windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions for different writing-modes (e.g., for writing prose distraction-free, and making Emacs behave like a more "normal" text editor)
;; The 'jacob/' in the function names is just to make them easier to search for. You can use your own name or delete that part of the function name)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jacob/prose-writing-mode ()
  "Enter writing mode, turning some distractions off.
  
This function makes the following changes:
  * Starts markdown mode. This enables markdown syntax highlighting.
  * Enables orgtbl-mode (via orgstruct-mode). This allows you to type
  | 1 | 2 | 3 |
  and press tab for a nicely-formatted ASCII table.
  * Enables scroll-restore-mode. You can press C-S-z to return to a point after scrolling.
  * Enables flyspell-mode. This enables red lines under misspelled words. You can middle-click a word to change it.
  * Enables markdown-display-inline-images. This will show images within markdown text, if the images 1) have an absolute path, and 2) do not have any other text in the parentheses portion of the image syntax (e.g., this is correct: '![Description goes here](/full/path/to/image.jpg)'. This is not correct: '![Description goes here](/full/path/to/image.jpg 'Description goes here')').
  * Enables darkroom-mode. This increases margins and font size, to remove distractions when writing.
  * Changes the theme to solarized-dark.
" ;; End of docstring (documentation string)
  (interactive) ;; Tell emacs that this function is a command (and should thus be listed in the M-x list of commands).
  (markdown-mode) ;; Turn on markdown syntax highlighting
  (darkroom-mode) ;; Bring in the margins
  (orgstruct-mode) ;; Following https://www.gnu.org/software/emacs/manual/html_node/org/Tables-in-arbitrary-syntax.html#Tables-in-arbitrary-syntax, enable the use of orgtbl-mode (for tables) without actually turning on all of org-mode.
  (orgtbl-mode) ;; Enable orgtbl-mode, where you can put pipe symbols around something and press Tab and it will format into a nice table for you.
  (scroll-restore-mode 1)
  (flyspell-mode) ;; Enable spell-checking red underlines.
  (markdown-display-inline-images) ;; Show markdown images (if they have absolute paths and no text other than the path within the parentheses portion) in the buffer. This can be toggled with M-x markdown-toggle-inline-images
  (load-theme 'solarized-dark)) ;; Make the theme dark
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End of custom functions for different styles of writing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;
;; Set agenda files list:
;; This is the list of all folders and files into which org-mode will look for .org files.
;;;;;;;;;;;;;;;

(if (boundp 'org-user-agenda-files)
	(setq org-agenda-files org-user-agenda-files)
	(setq org-agenda-files (quote (
	    ;; ('~' = your home directory)
		"~/Daily_Logs"
		"~/Primary_Syncing_Folder/Documents/todo"
))))

;;;;;;;;;;;;;;;
;; Set the org-journal directory
;; This is the directory (which, when typed here, needs to have a trailing slash ('/') into which org-journal-mode will look for .org files
;;;;;;;;;;;;;;;

(setq org-journal-dir "~/Primary_Syncing_Folder/Documents/Research_and_Project_Log_Notes/")

;;;;;;;;;;;;;;;
;; Set default TODO-list states (e.g., TODO, DONE, etc.) and colors for org-mode
;; '@/!' means that a prompt will appear asking for information when these states are used (?)
;;;;;;;;;;;;;;;

;; Adapted from org-mode complex example file (which is GPLv3-licensed):
;; Set default TODO states (and a color scheme for them) for all org files.
;; Following 'C-h v org-todo-keywords', EXAMPLE(e@/!) means that EXAMPLE can be chosen with the 'e' key when using C-c C-t, and that on entering it, a timestamp and note (@) should be recorded, and than on leaving it, just a timestamp (!) should be recorded. (For a timestamp upon just leaving the state, EXAMPLE(e/!) would be valid).
;; Anything after the pipe symbol ('|') is considered a DONE-type state.
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "RIGHT_NOW(r)" "SCHEDULED(s)" "|" "DONE(d!)")
              (sequence "SCHEDULED(s@/)" "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
			  (sequence "|" "TIME_TRACKED(x)")))) ;; TIME_TRACKED is a non-todo but still time-tracked item.

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("RIGHT_NOW" :foreground "green" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("SCHEDULED" :foreground "forest green" :weight bold))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;;;;;;;;;;;;;;;
;; Misc. org-mode settings
;;;;;;;;;;;;;;;

(setq org-agenda-search-view-always-boolean t) ;; When searching in org-mode's agenda, don't require explicit '+' symbols (so 'test1 test2' will be seen as '+test1 +test2' when this is set to t)

;; Turn org-mode on by default


;;;;;;;;;;;;;;;
;; Misc. other settings
;;;;;;;;;;;;;;;

;; Make the cursor blink, and be a narrow line:
(blink-cursor-mode 1)
(setq-default cursor-type 'bar)

(setq make-backup-files nil) ; From http://superuser.com/a/84168/192382: stop creating (backup) (~) files

;; When in org-mode, load a function I wrote for facilitating pasting links, and set keyboard commands for it and a related function.
(add-hook 'org-mode-hook ;; When entering into org-mode...
	(lambda ()
		;; Define the function:
        (defun org-id-paste-link ()
          "Paste an org-mode link to another line (or other file listed in org-agenda-files), with the prefix \"id:\".

        This function assumes that the last thing that you did before running this function was going to the target location of the link and running M-x org-id-copy, which will generate (if necessary) and then copy an ID for that line of org-mode document."
          (interactive)
          (insert "[[id:")
          (yank)
          (insert "][]]")
          (backward-char 2))
		
		(local-set-key (kbd "C-x l") 'org-id-copy)
		(local-set-key (kbd "C-x L") 'org-id-paste-link))) ;; local-set-key will set the key for the major mode (any buffer in org-mode).

;; Set new text for emacs' startup "Scratch buffer:"
(setq initial-scratch-message "Welcome to Emacs, configured for use like a normal text editor, with org-mode built-in!

* Enabling org-mode

To turn org-mode on, type M-x (that's Alt-x or Command-x, depending on your keyboard), then type 'org-mode', and press enter.

This document is written in org-mode. Turn on org-mode now, and you'll see the headlines "fold" down. You can then press use <Tab> on a headline to cycle through it being folded, partially open, and fully open. You can also use Shift-<Tab> to cycle through *all* headlines in the document at once.

** Keyboard shortcuts to remember

- *C-h k* = Hold down Control and h and the same time, then press k.
- *M-x* = Hold down 'Meta' (usually the Alt key, depending on your keyboard) and x at the same time, then type

** Normal keyboard shortcuts

Although Emacs doesn't typically use them, this configuration of Emacs has enabled 'normal' keyboard shortcuts like C-c for *copy*, C-v for *paste*, C-o for *open*, etc.

If you notice that a keyboard shortcut you try to use doesn't work, let me know, and we can see about adding it.

Also, note that in org-mode, some keyboard shortcuts, like holding down Ctrl. and using the arrow keys, change function (for example, C-<left> / C-<right> change to de-indenting or indenting the current line if it's in a list).

*C-f* does work for *searching* a file. To jump between matches, you need to keep pressing C-f (instead of <Enter>, like in some text editors).

** Menus

If you remember even *just the two keyboard shortcuts below*, you can use Emacs with org-mode :)

- *M-x*: Get a searchable pop-up menu (called 'Ivy') of every function in Emacs
- *C-g*: Cancel a pop-up menu

** Getting help

- *C-h k*: Get the help documentation for any keyboard shortcut (you type the keyboard shortcut, and it tells you what that shortcut does)
- *C-h f*: Get the help documentation for any function (you type the function name, and it shows you the help documentation for it
- *C-h v*: Get the value of any configuration variable in Emacs (you type the variable name, and it tells you what it does and what it's currently set to)

** Switching between windows and open files ('buffers')

(A '*buffer*' in emacs is like a tab in Firefox or Chrome -- it's a file or scratchpad that's currently open)

- *C-x b*: Switch between buffers
- *C-x 1*: If you have multiple windows/panes open, switch to just the current one.
- *windows-key-<up>*, *windows-key-<down>*: If you have multiple windows/panes open, move between them.

** org-mode shortcuts

- *C-x l* / *C-x L*: When you're in org-mode, you can go to any headline (any line that starts with '*'), and type C-x l (think 'l' for 'link'). This will create an ID number for that headline and copy a link to it to your keyboard.
Then you can go anywhere else in your document and press C-x L to paste the link in org-mode format. Type some text to describe the link, and you now have a clickable link to that first place in your document!
- *<Tab>*: Fold / Unfold the headline where your cursor is.
- *S-<Tab>*: Fold / Unfold every headline in the document.
- *M-<up>* / *M-<down>*: Move a headline up or down
- *M-<left>* / *M-<right>*: De-indent / Indent a headline
- *M-<Enter>*: Insert a new headline
- *M-S-<Enter>*: Insert a new TODO headline

* Emacs functions to remember
* org-mode functions to remember

(You can run any of these from the M-x menu):

- *org-sparse-tree*:
- *org-clock-in* / *org-clock-out*:
- *org-clock-report*:
- *org-agenda*:
  (Within org-agenda, if you press a (for full Agenda view), then v (for View) and d (for Day), you'll get the current day's entries.


") ;; End of scratch message definition.

;; Since the scratch-buffer's message is long, tell emacs to scroll to the beginning of the buffer on startup:
(add-hook 'emacs-startup-hook 'startup-scroll-function)
(defun startup-scroll-function ()
  "Scroll to the top of the buffer"
  (beginning-of-buffer))














