(defun rev (l)
  (cond
    ((null l) '())
    (T (append (rev (cdr l)) (list (car l)))
    )
  )
) 

(defun palindrome (s)
           (equal s (rev  s))
)

(print (palindrome '(a b c ) ))
(print (palindrome '(m a d a m)))
(print (palindrome '(cat dog)))
(print (palindrome '()))
(print (palindrome '(cat dog bird bird dog cat)))
