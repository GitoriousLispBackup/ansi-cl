;;; chapter3.lisp
;;  exercises from chapter 3 of "ANSI Common Lisp" by Paul Graham
;;  2011-12-30
;;  Kyle Isom <kyle@nodality.io>


(defun check-exercise (exercise attempt expected)
   (if (equal attempt expected)
       (format t "[+] exercise ~A: success!~%" exercise)
       (format t "[!] exercise ~A: failure!~%" exercise)))


;; exercise 2: write a version of union that prserves the order of the elements
;; in the original lists

(defun new-union (lst-1 lst-2)
  nil)

;; exercise 3: define a function that takes a list and returns a list indicated
;; number of times each (eql) element appears, sorted from most common element to
;; least common.

(defun occurrences (lst)
  nil)

;; exercise 4: why does (member '(a) '((a) (b))) return nil?


;; exercise 5: supposed the function pos+ takes a list and returns a list
;; of each element plus its position:
;; > (pos+ '(7 5 1 4))
;; (7 6 3 7)
;;
;; define this function using (a) recursion, (b) iteration, and (c) mapcar.
(defun recur-pos+ (lst)
  nil)

(defun iter-pos+ (lst)
  nil)

(defun mapcar-pos+ (lst)
  nil)

;; exercise 6: after years of deliberation, a government commission has decided
;; that lists should be represented by using the cdr to point to the first element
;; and the car to point to the rest of the list. define the government versions 
;; of the following functions:

;; (a) cons
;; (b) list
;; (c) length (for lists)
;; (d) member (for lists; no keywords)

;; exercise 7: modify the program in figure 3.6 to use fewer cons cells (hint:
;; use dotted lists.) (run-length-encoding)

;; exercise 8: define a function that takes a list and prints it in dot notation.
;; (shotdots '(a b c))
;; (A . (B . (C . NIL)))
;; NIL

;; exercise 9: write a program to find the *longest* finite path through a
;; network represented as in section 3.15 (shortest path). the network may 
;; contain cycles.

(check-exercise 2 (new-union '(a b c) '(b a d)) '(a b c d))
(check-exercise 3 (occurrences '(a b a d a c d c a))
                 '((a . 4) (c . 2) (d . 2) (b . 1)))
(check-exercise "5 (recursive)" (recur-pos+ '(7 5 1 4)) '(7 6 3 7))
(check-exercise "5 (iterative)" (iter-pos+ '(7 5 1 4)) '(7 6 3 7))
(check-exercise "5 (mapcar)" (mapcar-pos+ '(7 5 1 4)) '(7 6 3 7))x