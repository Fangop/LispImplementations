(DEFUN FIB1(n)
    (IF (< n 2)
        n
        (+ (FIB1 (- n 1)) (FIB1 (- n 2)))
    )
)


(print (FIB1 20))
