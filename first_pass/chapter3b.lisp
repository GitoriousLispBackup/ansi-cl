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
  (let ((half (/ (length lst) 2)))
    (let ((first (subseq lst 0 (floor half)))
          (second (subseq lst (ceiling half))))
      (equal first (reverse second)))))

;; paul's implementation of the palindrome detector
(defun mirror? (s)
  (let ((len (length s)))
    (and (evenp len)
         (let ((mid (/ len 2)))
           (equal (subseq s 0 mid)
                  (reverse (subseq s mid)))))))

;; validate the implementations of the palindrome detector
(defun test-mirror ()
  (let ((test-vectors '(((a b c d e) . nil)
                        ((a b c d) . nil)
                        ((a b b a) . t)
                        ((a b c b a) . t))))
    (format t "[+] testing mirrorp")
    (dolist (tv test-vectors)
      (format t "~&~8Tvector: ~A (expecting ~A): " (car tv) (cdr tv))
      (if (equal (mirrorp (car tv)) (cdr tv))
          (format t "ok~%")
          (format t "failed!")))
    (format t "[+] testing mirror?")
    (dolist (tv test-vectors)
      (format t "~&~8Tvector: ~A (expecting ~A): " (car tv) (cdr tv))
      (if (equal (mirror? (car tv)) (cdr tv))
          (format t "ok~%")
          (format t "failed~%" )))))


;; my version of our-reverse using push
(defun my-reverse (lst)
  (let ((revlst '()))
    (dolist (elt lst)
      (push elt revlst))
    revlst))

;; lists can be used as stacks using push, pop, and pushnew
(defmacro my-push (elt lst)
  `(progn
     (setf ,lst (cons ,elt ,lst))
     ,lst))

(defmacro my-pop (lst)
  `(let ((elt (car ,lst)))
     (setf ,lst (cdr ,lst))
     elt))

(defmacro my-pushnew (elt lst)
  `(progn (setf ,lst (adjoin ,elt ,lst))
          ,lst))

;; why yes, old chum, i do agree - this is quite the eyesore
(defun test-mystack ()
  (let ((my-lst '(b c d)))
    (my-push 'a my-lst)
    (if (not (equal my-lst '(a b c d)))
        (progn
          (format t "[!] my-push failed: ~A~%" my-lst)
          nil)
        (let ((elt (pop my-lst)))
          (if (or (not (equal elt 'a))
                  (not (equal my-lst '(b c d))))
              (progn
                (format t "[!] my-pop failed: ~A from ~A~%" elt my-lst)
                nil)
              (progn
                (if (not (equal (my-pushnew 'a my-lst) '(a b c d)))
                    (progn
                      (format t "[!] my-pop failed: ~A from ~A~%" elt my-lst)
                      nil)
                    (if (not (equal (my-pushnew 'a my-lst) '(a b c d)))
                        (progn
                          (format t "[!] my-pop failed: ~A from ~A~%" elt my-lst)
                          nil)
                        (progn
                          (format t "[+] all my-stack tests passed.")
                          t)))))))))
