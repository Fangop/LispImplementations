;;; file: prime.lsp
( DEFUN IS-PRIME(n d)
 ;    (print "in")
     (IF (= d 1)
         t
         (IF (= (mod n d) 0)
             nil
             (IS-PRIME n (- d 1))
         )
     )
)

( DEFUN PRIME(n)
    (IS-PRIME n (- n 1))
)

;;;(PRIME 2)
;;;(PRIME 999)
;;;(PRIME 17)
