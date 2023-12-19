# Validation

Validation library for Coalton.

## Installation

Since it depends on Coalton, please refer to the link below to install Coalton.

https://github.com/coalton-lang/coalton

Next, place json-parser in your local repository (`~/common-lisp`, etc.).

```shell:~/common-lisp
git clone https://github.com/tojoqk/validation.git
```

If you are using Quicklisp, you can load the system with the following.

```lisp
(ql:quickload :tokyo.tojo.validation)
```

## Examples

### Validation

```
(defpackage #:tokyo.tojo.validation-validation-example
  (:use #:coalton
        #:coalton-prelude)
  (:local-nicknames
   (#:ap #:tokyo.tojo.validation/applicative)
   (#:validation #:tokyo.tojo.validation/validation)
   (#:string #:coalton-library/string)))

(in-package #:tokyo.tojo.validation-validation-example)

(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel
  (define-struct Person
    (name String)
    (age Integer)
    (skill Skill))

  (define-type Skill
    Programming
    Cooking)

  (declare parse-name (String -> Result (List String) String))
  (define (parse-name str)
    (Ok str))

  (declare parse-age (String -> Result (List String) Integer))
  (define (parse-age str)
    (match (string:parse-int str)
      ((Some age)
       (if (< age 0)
           (Err (make-list "age: negative age"))
           (Ok age)))
      ((None)
       (Err (make-list "age: invalid integer")))))

  (declare parse-skill (String -> Result (List String) Skill))
  (define (parse-skill str)
    (match str
      ("programming" (Ok Programming))
      ("cooking" (Ok Cooking))
      (_ (Err (make-list "skill: invalid skill")))))

  (define validation-example-1
    (ap:apply (pure Person)
              (validation:from-result (parse-name "john"))
              (validation:from-result (parse-age "24"))
              (validation:from-result (parse-skill "programming"))))
  ;; => #.(VALIDATION:OK #.(PERSON "john" 24 #.PROGRAMMING))

  (define validation-example-2
    (ap:apply (pure Person)
              (validation:from-result (parse-name "john"))
              (validation:from-result (parse-age "24"))
              (validation:from-result (parse-skill "sleeping"))))
  ;; => #.(VALIDATION:ERR ("skill: invalid skill"))

  (define validation-example-3
    (ap:apply (pure Person)
              (validation:from-result (parse-name "john"))
              (validation:from-result (parse-age "-24"))
              (validation:from-result (parse-skill "sleeping"))))
  ;; => #.(VALIDATION:ERR ("age: negative age" "skill: invalid skill"))
  )
```

### Applicative

```lisp
(defpackage #:tokyo.tojo.validation-applicative-example
  (:use #:coalton
        #:coalton-prelude)
  (:local-nicknames
   (#:ap #:tokyo.tojo.validation/applicative)))

(in-package #:tokyo.tojo.validation-applicative-example)

(named-readtables:in-readtable coalton:coalton)

(coalton-toplevel
  (define applicative-example-1
    (ap:apply (pure *) (make-list 2 3) (make-list 7 11 13)))
  ;; => (14 22 26 21 33 39)
  )
```

## LICENSE

This program is licensed under the MIT License. See the LICENSE file for details.

