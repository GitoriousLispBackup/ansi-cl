(load "package.lisp")
(in-package #:ansi-cl)

;;; shortest-path

(defvar *min-net* '((A B C)
                    (B C)
                    (C D)))
(defvar *bigger-net* '((:A :B :D)
                       (:B :A :C)
                       (:C :B :F :J)
                       (:D :A :E)
                       (:E :D :F :H)
                       (:F :C :E :H)
                       (:G :F :I)
                       (:H :E)
                       (:I :G :J :L)
                       (:J :C :I :K)
                       (:K :J :M)
                       (:L :I :M)
                       (:M :K :L)))

(defun new-paths (path node net)
  (mapcar #'(lambda (n)
              (cons n path))
          (cdr (assoc node net))))

(defun bfs (end queue net)
  (if (null queue)
      nil
      (let ((path (car queue)))
        (
let ((node (car path)))
          (if (eql node end)
              (reverse path)
              (bfs end
                   (append (cdr queue)
                           (new-paths path node net))
                   net))))))

(defun shortest-path (start end net)
  (bfs end (list (list start)) net))
