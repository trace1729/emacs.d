;------------------ package ----------------------------------;
(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line
;;防止反复调用 package-refresh-contents 会影响加载速度
(when (not package-archive-contents)
  (package-refresh-contents))

;----------------- keyboard rebinding-------------------------;
(global-set-key (kbd "s-a") 'mark-whole-buffer) ;;对应Windows上面的Ctrl-a 全选
(global-set-key (kbd "C-c y") 'kill-ring-save) ;;对应Windows上面的Ctrl-c 复制
(global-set-key (kbd "s-s") 'save-buffer) ;; 对应Windows上面的Ctrl-s 保存
(global-set-key (kbd "C-c p") 'yank) ;对应Windows上面的Ctrl-v 粘贴
(global-set-key (kbd "s-z") 'undo) ;对应Windows上面的Ctrol-z 撤销
(global-set-key (kbd "s-x") 'kill-region) ;对应Windows上面的Ctrol-x 剪切
(global-set-key (kbd "C-c s") 'eshell); open a shell
(global-set-key (kbd "C-c r") 'recentf-open-files)

;-----------------      file         ------------------------;
(defun load-config-file()
  (save-buffer)
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c l") 'load-config-file)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

;; 快速打开todo文件
(defun open-org()
  (interactive)
  (find-file "~/Documents/org/TODO.org"))

;; 这一行代码，将函数 open-init-file 绑定到  键上
(global-set-key (kbd "C-c C-t") 'open-org)


;; 快速进入 rv book
(defun open-rv()
  (interactive)
  (find-file "~/Documents/rvbook.pdf")
  (org-noter))

;; 这一行代码，将函数 open-init-file 绑定到  键上
(global-set-key (kbd "<f4>") 'open-rv)

;================ user defined function =====================;

(defun consult-directory-externally (file)
  "Open FILE externally using the default application of the system."
  (interactive "fOpen externally: ")
  (call-process (pcase system-type
		  ('gnu/linux "nautilus"))
		nil 0 nil
		(file-name-directory
		 (expand-file-name file))))

; 打开当前文件的目录
(defun my-open-current-directory ()
  (interactive)
  (consult-directory-externally default-directory))


;---------------- custmisze editor apperance ----------------;
;; close tool-bar
(tool-bar-mode -1)

;;关闭文件滑动控件
(scroll-bar-mode -1)

;; 指定在 prog 和 text mode 下显示行号
;(global-display-line-numbers-mode)
(add-hook 'prog-mode-hook (lambda() (display-line-numbers-mode 1)))
(add-hook 'text-mode-hook (lambda() (display-line-numbers-mode 1)))
(add-hook 'prog-mode-hook (lambda() (hl-line-mode 1)))
(add-hook 'text-mode-hook (lambda() (hl-line-mode 1)))

;(add-hook 'pdf-view-mode (lambda() (display-line-numbers-mode nil)))

;; change font size
(set-face-attribute 'default nil :height 160)

;; Latex syntax hightlight
(setq org-highlight-latex-and-related '(latex))
; 高亮当前行
; (global-hl-line-mode 1)

;; use minted to hightlight the source code
; (add-to-list 'org-latex-packages-alist '("" "minted"))

; change todo keywords
(setq org-todo-keywords '((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)" "ABORT(a)")))

; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 25)

; remember previous editing positon
(save-place-mode 1)
; 不生成备份文件
(setq make-backup-files nil)
; 选中编辑删除
(delete-selection-mode t)
; 改变光标

(setq-default cursor-type 'bar)
; 不要移动备份
(setq auto-save-default nil)

(global-auto-revert-mode 1)
; (icomplete-mode 1)
(setq ring-bell-function 'ignore)
; 关闭菜单栏
(menu-bar-mode 0)
; 关闭 启动界面
(setq inhibit-startup-message t)
; ----------------------- custom -----------------------;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "c8b3d9364302b16318e0f231981e94cbe4806cb5cde5732c3e5c3e05e1472434" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "e4a702e262c3e3501dfe25091621fe12cd63c7845221687e36a79e17cf3a67e0" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" "603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" default))
 '(package-selected-packages
   '(fanyi org-noter pdf-tools doom-themes embark-consult consult embark marginalia gnu-elpa-keyring-update vertico uimage org-download grip-mode keycast htmlize rainbow-mode racket-mode org markdown-mode evil company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;------------------------  plugin -------------------------;

; --- company -- 
; 开启全局 Company 补全
(global-company-mode 1)

;; company mode 默认选择上一条和下一条候选项命令 M-n M-p
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

; theme
;(load-theme 'monokai 1)
(load-theme 'doom-xcode)
;(load-theme 'dracula t)


(setq org-src-fontify-natively t)

; org src execute block 
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (R . t)
   (C . t)
   (python . t)
   (makefile . t)
   (awk . t)
   (latex . t)
   (shell . t)))

; enable inline-images 
;;; org-download
(require 'org-download)
(setq org-download-screenshot-method "flameshot gui --raw >%s")
; (setq org-download-method 'directory)
(setq-default org-download-heading-lvl nil)
(setq-default org-download-image-dir "./images")
(defun dummy-org-download-annotate-function (link)
  "")
(setq org-download-annotate-function
      #'dummy-org-download-annotate-function)


; 在查找文件时，加入一个自定义动作，打开当前文件的目录
(require 'embark)
(eval-after-load 'embark
  '(define-key embark-file-map (kbd "E") #'consult-directory-externally))

;; Or start grip when opening a markdown/org buffer
; (add-hook 'org-mode-hook #'grip-mode)

 
(vertico-mode t)
(setq completion-styles '(orderless))
;;modeline上显示我的所有的按键和执行的命令
; keycast
; (keycast-mode-line-mode t)

; enhancing minibuffer
(marginalia-mode t)

; context action embark
(global-set-key (kbd "C-c ;") 'embark-act)
(setq prefix-help-command 'embark-prefix-help-command)

; replace swiper
; (global-set-key (kbd "C-s") 'consult-line)
; 为了不在 pdf-mode 里触发 consult-line
; 原来是因为 打开pdf 文件不会自动打开 pdf-mode ...
(add-hook 'prog-mode-hook (lambda() (local-set-key (kbd "C-s") 'consult-line)))
(add-hook 'text-mode-hook (lambda() (local-set-key (kbd "C-s") 'consult-line)))
;(add-hook 'pdf-sync-minor-mode (lambda() (local-set-key [double-mouse-1] 'mouse-set-region)))

;;consult-imenu

(global-set-key (kbd "C-c i") 'consult-imenu)

;; org-noter
(setq org-noter-notes-search-path '("/home/trace/Documents/org/pdf_notes")) ;; 默认笔记路径
(setq org-noter-auto-save-last-location t) ;; 自动保存上次阅读位置
(setq org-noter-highlight-selected-text t)
(setq org-noter-max-short-selected-text-length 20) ;; 默认为 80
(setq org-noter-default-heading-title "第 $p$ 页的笔记") ;; 默认短标题格式
(global-set-key (kbd "C-c n n") 'org-noter) ;; 与 org-roam 配合


; =========================== pdf-tools ==================================;

(pdf-loader-install)
(add-hook 'pdf-view-mode-hook 'pdf-view-fit-width-to-window) ;; 自动放大到页宽
;(define-key pdf-sync-minor-mode-map [double-mouse-1] 'pdf-sel-mode)

(defvar pdf-sel-mode-map nil
  "Keymap for `pdf-sel-mode'.")

(setq pdf-sel-mode-map
      (let ((map (make-sparse-keymap)))
    (define-key map [double-mouse-1] 'pdf-sel-mouse)
    map))

(define-minor-mode pdf-sel-mode
  "\\<pdf-sel-mode-map>Just binding \\[pdf-sel-mouse] to `pdf-sel-mouse'.
`pdf-sel-mouse' selects the text at point and copies it to `kill-ring'."
  :keymap pdf-sel-mode-map)

(defvar pdf-view-active-region) ;; defined in "pdf-view.el"

(defun pdf-sel-mouse (ev)
  "Select word at mouse event EV and copy it to `kill-ring'."
  (interactive "@e")
  (let* ((posn (event-start ev))
     (xy (posn-object-x-y posn))
     (size (pdf-view-image-size))
     (page (pdf-view-current-page))
     (x (/ (car xy) (float (car size))))
         (y (/ (cdr xy) (float (cdr size)))))
    (setq pdf-view-active-region (pdf-info-getselection page (list x y x y) 'word))
    (pdf-view-display-region pdf-view-active-region)
    (kill-new (pdf-info-gettext page (list x y x y) 'word))))

; 关闭 sync mode
; 打开 sel mode
(add-hook 'pdf-view-mode-hook (lambda () (setq pdf-sync-minor-mode nil)))
(add-hook 'pdf-view-mode-hook (lambda () (setq pdf-sel-mode t)))


(require 'pdf-tools)
(define-key pdf-view-mode-map "j" 'pdf-view-scroll-up-or-next-page) ;; 向下滑动
(define-key pdf-view-mode-map "k" 'pdf-view-scroll-down-or-previous-page) ;; 向上滑动

; ====================== pdf-tools ======================================;

;; fanyi

(global-set-key (kbd "C-c f") 'fanyi-dwim2)
(global-set-key [(control return)] 'calculator)
