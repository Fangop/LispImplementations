(DEFUN FIB(n a b)
    (IF (= n 0)
        a
        (FIB (- n 1) b (+ a b))
    )
)
(DEFUN FIB2(n)
    (FIB n  0 1)       
)
