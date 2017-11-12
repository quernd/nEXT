;;;; base.lisp --- main entry point into nEXT

(in-package :next)

(defun start ()
  (ensure-directories-exist (uiop:physicalize-pathname #P"~/.next.d/"))
  (initialize-bookmark-db)
  (initialize-default-key-bindings)
  (interface:initialize)
  (interface:start)
  ;; create the default buffers
  (setf *minibuffer* (generate-new-buffer "minibuffer" (minibuffer-mode) nil))
  (set-visible-active-buffer (generate-new-buffer "default" (document-mode)))
  ;; load the user configuration if it exists
  (load "~/.next.d/init.lisp" :if-does-not-exist nil))

(defun initialize-default-key-bindings ()
  (define-key global-map (kbd "C-x C-c") #'interface:kill)
  (define-key minibuffer-mode-map (kbd "
  (define-key minibuffer-mode-map (kbd "C-g") #'(lambda () (cancel-input (buffer-mode *minibuffer*))))
  (define-key minibuffer-mode-map (kbd "Escape") #'(lambda () (cancel-input (buffer-mode *minibuffer*))))
  (define-key global-map (kbd "C-x b") (:input-complete *minibuffer* switch-buffer buffer-complete))
  (define-key global-map (kbd "C-x k") (:input-complete *minibuffer* delete-buffer buffer-complete))
  (define-key document-mode-map (kbd "S-f") (:input-complete *minibuffer* history-forwards-query history-fowards-query-complete))
  (define-key document-mode-map (kbd "S-b") #'history-backwards)
  (define-key document-mode-map (kbd "C-f") #'history-forwards)
  (define-key document-mode-map (kbd "C-b") #'history-backwards)
  (define-key document-mode-map (kbd "C-p") #'scroll-up)
  (define-key document-mode-map (kbd "C-n") #'scroll-down)
  (define-key document-mode-map (kbd "C-o") (:input *minibuffer* set-url))
  (define-key global-map (kbd "S-o") (:input *minibuffer* set-url-new-buffer))
  (define-key global-map (kbd "S-s k") (:input-complete *minibuffer* bookmark-delete bookmark-complete))
  (define-key document-mode-map (kbd "S-s o") (:input-complete *minibuffer* set-url bookmark-complete))
  (define-key document-mode-map (kbd "S-s s") #'bookmark-current-page))