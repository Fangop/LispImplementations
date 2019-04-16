(defun palindrome (s)
           (equal s (reverse  s))
)

(print (palindrome '(a b c ) ))
(print (palindrome '(m a d a m)))
(print (palindrome '(cat dog)))
(print (palindrome '()))
(print (palindrome '(cat dog bird bird dog cat)))
