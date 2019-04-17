# Lisp Simple Implementations

## Evironment
`Mac OSX Darwin 18.2.0`
`sbcl 1.5.0`
```bash
$ uname -a 
Darwin Fangs-MBP 18.2.0 Darwin Kernel Version 18.2.0: Thu Dec 20 20:46:53 PST 2018; root:xnu-4903.241.1~1/RELEASE_X86_64 x86_64
$ sbcl
This is SBCL 1.5.0, an implementation of ANSI Common Lisp.
More information about SBCL is available at <http://www.sbcl.org/>.
```
## Prime Number Checker
### Code
```=
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
```
Simply devide it from itself  to 2!
If it not devisible from itself to 2, it is a prime number!
### Execution
By bash(with simple test written).
(2 999 17)
```bash
$ sbcl --script prime.lsp
T
NIL
T
```

By load to `sbcl`
```
* (load "prime.lsp")
* (prime 1342)
NIL
* (prime NumberYouWant)
```
## Palindrome Checker
### Code
```=
defun rev (l)
  (cond
    ((null l) '())
    (T (append (rev (cdr l)) (list (car l)))
    )
  )
)

(defun palindrome (s)
           (equal s (rev  s))
)
```
Simply implemented reverse by my self using recursive, but it actually has its own `reverse` function.
I didn't implemented my `equal`.
Compare if the input string `s` equal to its own reversal.
### Execution
By bash(with simple test written).
```
(print (palindrome '(a b c ) ))
(print (palindrome '(m a d a m)))
(print (palindrome '(cat dog)))
(print (palindrome '()))
(print (palindrome '(cat dog bird bird dog cat)))
```
```bash
$ sbcl --script palindrome.lsp
NIL
T
NIL
T
T
```

By load to `sbcl`
```
* (load "palindrome.lsp")
* (palindrome '(1 4 5 4 1))
T
* (palindrome ListYouWant)
```
## Fibonacci
### Code
`fib1.lsp`
```
(DEFUN FIB1(n)
    (IF (< n 2)
        n
        (+ (FIB1 (- n 1)) (FIB1 (- n 2)))
    )
)
```
Naive Fibonacci caculate.
`fib2.lsp`
```
(DEFUN FIB(n a b)
    (IF (= n 0)
        a
        (FIB (- n 1) b (+ a b))
    )
)
(DEFUN FIB2(n)
    (FIB n  0 1)
)
```
Tail recursive!
`n` is for counting times of recursion.
`a` is for total.
`b` is the next value.

### Execution
#### script
Test script test for `fib(20)`.
```bash
$ sbcl --script fib1.lsp
6765
$ sbcl --script fib2.lsp
6765
```
#### load
```
* (load "fib1.lsp")
* (fib1 10)
55
* (load "fib2.lsp")
* (fib2 10)
55
```

## Simple Diff checker
### Code
Functions for print with `+` `-`.
```
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
```

Function `out` and `in`
```
(defun out (obj lst)
   (if (null lst)
     nil
    (reverse (cdr (in obj (reverse lst)))))
)
```
```
(defun in (obj lst)
   (if (null lst)
       nil
   (if (equal (car lst) obj)
       lst
       (in obj (cdr lst)))))
```
These 2 functions are reverse usage. 
Function`In` will see if the `obj` in the `lst`, and return the part behind `obj` with it.
Function`out` will see if the `obj` in the `lst`, and return the part int the front of `obj` without it.


```
defun diff (f1 f2)
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
```
First part of this function is to import files.
then by using `in` and `out` funcion, implement the diff-checker.

### Execute
#### script
```
$ sbcl --script diff.lsp
-#include <stdio.h>
+#include <iostream>
+using namespace std;
int main() {
-printf(“Hello World”);
+cout << “Hello World” << end;
return 0;
}
```
input:
`hello-world.c`
```clike
include <stdio.h>
int main() {
printf(“Hello World”);
return 0;
}
```
and
`hello-world.cpp`
```
#include <iostream>
using namespace std;
int main() {
cout << “Hello World” << end;
return 0;
}
```
#### load
```
* (load "diff.lsp")
* (diff "yourfile1" "yourfile2")
```