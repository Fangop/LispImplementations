;;; file: prime.lsp
( DEFUN IS-PRIME(n d)
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

(print(PRIME 2))
(print(PRIME 999))
(print(PRIME 17))
