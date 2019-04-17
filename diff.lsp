(defun diff (f1 f2)
  (let (fin1)
  (setf fin1
  (with-open-file (str f1 :direction :input)
    (do (
         (line (read-line str nil 'eof) (read-line str nil 'eof))
         (tmp nil)
        )
         (
          (eql line 'eof)
          (reverse tmp)
          )
      (setf tmp (cons line tmp)
      )
    )
  )
  )
  (let (fin2)
    (setf fin2
    (with-open-file (str f2 :direction :input)
    (do (
         (line (read-line str nil 'eof) (read-line str nil 'eof))
         (tmp nil)
        )
         (
          (eql line 'eof)
          (reverse tmp)
          )
      (setf tmp (cons line tmp))
    )
  )
  )
   ;(print fin1)
   ;(print (out "1" fin1))
   (do (
        (l1 fin1 (cdr l1))
        (r1 fin1)
        (r2 fin2)
        )
        (
         (eql l1 nil)
         )
        (
         if (eql nil (in (car l1) r2))
          ()
          (progn
           (print- (out (car l1) r1))
           (print+ (out (car l1) r2))
           (format t "~A~%" (car l1))
           (setf r1 (cdr(in (car l1) r1)))
           (setf r2 (cdr(in (car l1) r2)))
           )
          )
     )
   )
   )
  )
(defun print- (lst)
  (if (null lst)
    nil
    (do 
      ((l lst (cdr l) ))
      ((eql  l nil))
      (format t "-~A~%" (car l))
      ))
)
(defun print+ (lst)
  (if (null lst)
    nil
    (do
      ((l lst (cdr l) ))
      ((eql l nil))
      (format t "+~A~%" (car l))
      ))
)
(defun out (obj lst)
   (if (null lst)
     nil
    (reverse (cdr (in obj (reverse lst)))))
)



(defun in (obj lst)
   (if (null lst)
       nil
   (if (equal (car lst) obj)
       lst
       (in obj (cdr lst)))))


(diff "hello-world.c" "hello-world.cpp")
