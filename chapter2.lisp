(load "package.lisp")
(in-package :ansi-cl)

;;;; second pass working through ANSI-CL

;; 1. Describe what happens when the following expressions are evaluated:
;; (a) (+ (- 5 1) (+ 3 7))
;; first, (- 5 1) and (+ 3 7) are evaluated, leading to the following
;; chain:
;;   (+ (- 5 1) (+ 3 7))
;;   (+ 4 10)
;;   14
;; (b) (list 1 (+ 2 3))
;;   (list 1 (+ 2 3))
;;   (list 1 5)
;;   '(1 5)
;; (c) (if (listp 1) (+ 12) (+3 4))
;;   (if (listp 1)
;;       (+ 1 2)
;;       (+ 3 4))
;;   (if nil
;;       (+ 1 2)
;;       (+ 3 4))
;;   (+ 3 4)
;;   7
;; (d) (list (and (listp 3) t) (+ 1 2))
;;   (list (and (listp 3) t) (+ 1 2))
;;   (list (and nil t) 3)
;;   (list nil 3)
;;   '(nil 3)

;; 2. Give three distinct cons expressions that return (a b c).
;; (cons 'a (cons 'b (cons 'c nil)))
;; (cons 'a (cons 'b '(c)))
;; (cons 'a '(b c))

;; 3. Using car and cdr, define a function to return the fourth
;; element of a list.
;; (defun my-fourth (lst)
;;   (car (cdr (cdr (cdr lst)))))

;; 4. Define a function that takes two arguments and returns the
;; greater of the two.
;;
;; (defun greater (a b)
;;   (if (and (numberp a) (numberp b))
;;       (if (> a b)
;;           a
;;           b)
;;       nil))

;; 5. What do these functions do?
;; (a)
 ;; (defun enigma (x)
 ;;   (and (not (null x))
 ;;        (or (null (car x))
 ;;            (enigma (cdr x)))))
;; return T if there are any null elements in x

;; (b)
 ;; (defun mystery (x y)
 ;;   (if (null y)
 ;;       nil
 ;;       (if (eql (car y) x)
 ;;           0
 ;;           (let ((z (mystery x (cdr y))))
 ;;             (and z (+ z 1))))))
;; return the index of the first matching element in y, or nil if not found.
;; for the element.

;; 6. What could occur in place of the x in each of the following exchanges?
;; (a) (car (x (cdr '(a (b c) d))))
;;     > B
;;     car
;; (b) (x 13 (/ 1 0))
;;     > 13
;;     or
;; (c) (x #'list 1 nil)
;;     > (1)
;;    apply

;; 7. using only operators introduced in this chapter, define a function
;; that takes a list as an argument and returns true if one of its elements
;; is a list.

(defun has-sublist (lst)
  (if (or (null lst) (not (listp lst)))
      nil
    (if (listp (car lst))
        t
      (has-sublist (cdr lst)))))


;; 8. Give iterative and recursive definitions of a function that
;;   (a) takes a positive integer and print that many dots
(defun dot-print-i (n)
  "Iterative dot printer from Chapter 2 of ANSI-CL."
  (dotimes (i n)
    (format t "."))
  (format t "~%"))

(defun dot-print-r (n)
  "Recursive dot printer from Chapter 2 of ANSI-CL."
  (if (> n 0)
      (progn
        (format t ".")
        (dot-print-i (- n 1)))
    (format t "~%")))

;;   (b) takes a list and returns the number of times the symbol a
;;        occurs in it.
(defun find-symbol-i (sym lst)
  (let ((n 0))
    (dolist (obj lst)
      (if (equal obj sym)
          (setf n (+ n 1))))
    n))

(defun find-symbol-r (sym lst)
  (if (null lst)
      0
    (+ (find-symbol-r sym (cdr lst))
       (if (equal sym (car lst)) 1 0))))

;; 9. A friend is trying to write a function that returns the sum of all
;; the non-nil elements in a list. He has written two versions of this
;; function, and neither of them work. he was written two versions of
;; this function, and neither of them work. explain what's wrong with
;; each, and give a correct version.

;; (defun summit-wrong-a (lst)
;;  (remove nil lst)
;;  (apply #' lst))

;; remove doesn't modify the list. this approach is easy to fix:
(defun summit (lst)
  (apply #'+ (remove nil lst)))

;;(defun summit-wrong-b (lst)
;;  (let ((x (car lst)))
;;    (if (null x)
;;        (summit (cdr lst))
;;      (+ x (summit (cdr lst))))))

(defun summit% (lst)
  (if (and (listp lst) (null lst))
      0
  (let ((x (car lst)))
    (+ (if (null x) 0 x)
       (summit% (cdr lst))))))
