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
