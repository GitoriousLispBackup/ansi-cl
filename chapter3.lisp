(load "package.lisp")
(in-package :ansi-cl)

;;; run-length encoding
(defun compress (x)
  (if (consp x)
      (compr (car x) 1 (cdr x))
    x))

(defun compr (elt n lst)
  (if (null lst)
      (list (n-elts elt n))
    (let ((next (car lst)))
      (if (eql next elt)
          (compr elt (+ n 1) (cdr lst))
        (cons (n-elts elt n)
              (compr next 1 (cdr lst)))))))

(defun n-elts (elt n)
  (if (> n 1)
      (list elt n)
    elt))

;; my implementation given the spec
(defun uncompress (lst)
  (if (null lst)
      nil
    (let ((elt (car lst))
          (rem (cdr lst)))
      (if (listp elt)
          (append (expand elt)
                  (uncompress rem))
        (cons elt (uncompress rem))))))

(defun expand (lst)
  (let ((l '()))
    (dotimes (x (car (cdr lst)))
      (setf l (cons (car lst) l)))
    l))

;; paul's implementation
(defun pg-uncompress (lst)
  (if (null lst)
      nil
    (let ((elt (car lst))
          (rest (uncompress (cdr lst))))
      (if (consp elt)
          (append (apply #'list-of elt)
                  rest)
        (cons elt rest)))))

(defun list-of (n elt)
  (if (zerop n)
      nil
    (cons elt (list-of (- n 1) elt))))

(defun test-compression ()
  (let* ((original '(a a b a c d d d e))
         (expected-out '((a 2) b a c (d 3) e))
         (out (compress original)))
    (format t "[+] test compress: ")
    (unless (equal expected-out out)
      (error "Invalid RLE: ~A (expected ~A)~%" out expected-out))
    (format t "ok.~%")
    (let ((out (uncompress out)))
      (format t "[+] test uncompress: ")
      (unless (equal out original)
        (error "Invalid decompression: ~A (expected ~A)~%" out original))
      (format t "ok.~%")
      (format t "~&[+] all tests passed.~%") t)))

;;; conses can be thought of as binary trees
;; car is the right subtree and cdr the left
;; substitute: shallow -tree level
;; subst: full tree
;; doubly recursive functions recurse down both car and cdr
;;   member returns the list starting with the member on the first
;;   match
;;
;;   adjoin is a conditional cons

;; my implementation of the palindrome detector
(defun mirrorp (lst)
  (let ((first (subseq lst 0 (floor
                               (/ (length lst) 2))))
         (second (subseq lst (ceiling
                              (/ (length lst) 2))
                         (length lst))))
    (equal first (reverse second))))

;; paul's implementation of the palindrome detector
(defun mirror? (s)
  (let ((len (length s)))
    (and (evenp len)
         (let ((mid (/ len 2)))
           (equal (subseq s 0 mid)
                  (reverse (subseq s mid)))))))
