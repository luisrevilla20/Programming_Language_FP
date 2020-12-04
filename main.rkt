#lang racket

(require csv-reading)

(define csv-path "./KO.csv")

;Parsing function of the csv
(define read-csv
  (make-csv-reader-maker
   '((separator-chars              #\,)
     (strip-leading-whitespace?  . #t)
     (strip-trailing-whitespace? . #t))))

;Converts the csv into a list of lists where ever sublist is a row of the csv
(define (all-rows path reader)
  (define next-row (reader(open-input-file path)))
  (define (loop)
    (define row (next-row))
    (if (empty? row)
        '()
        (cons row (loop))))
  (loop))

;Function that returns a list containing the values of the desired column
(define (get-column col)
  (let loop
    ([file (cdr(all-rows csv-path read-csv))]
     [result empty])
    (if (empty? file)
        result
        (loop (cdr file)
              (cond
                [(equal? col 1) (append result (list (caar file)))]
                [(equal? col 2) (append result (list (string->number(cadar file))))]
                [(equal? col 3) (append result (list (string->number(caddar file))))]
                [(equal? col 4) (append result (list (string->number(car (cdddar file)))))]
                [(equal? col 5) (append result (list (string->number(cadr (cdddar file)))))]
                [(equal? col 6) (append result (list (string->number(caddr (cdddar file)))))]
                [(equal? col 7) (append result (list (string->number(car (cdddr (cdddar file))))))]
                )))))

(define (length lst)
  (cond
    [(empty? lst)  0]
    [(cons? lst)   (+ 1 (length (rest lst)))]))

(define (last_element l)
  (cond ((null? (cdr l)) (car l))
        (else (last_element (cdr l)))))

(define (suma-SMA col n)
  (let loop
    ([cont n]
     [res 0]
     [col col])
    (if  (zero? cont)
        (/ res n)
        (loop (sub1 cont) (+ res (car col)) (cdr col)))))

(define (get-SMA list days)
  (cond
    ((null? list)
     '()) ;; error?
    ;((null? (cdr list))
     ;'())
    ( (>= (length list) days)
     (cons  (suma-SMA list days) (get-SMA (cdr list) days)))))

;(define (get-SMA2 col days)

(define (sum-EMA val1 val2 days)
  (+(* val2(/ 2 (add1 days))) (* val1 (- 1 (/ 2 (add1 days))))))
  

(define (get-EMA col days)
  (let loop
    ([result (append empty (list (suma-SMA col days)))]
     [cont days]
     [val1 (suma-SMA col days)]
     [val2 (list-ref col (add1 days))]
     [a (length col)])
    (if (equal? a cont)
        result
        (loop (append result (list (sum-EMA val1 val2 days))) (add1 cont) (last_element result)(list-ref col (add1 days)) (length (cdr col))) )))
#|
(define (repeat col n)
  (let loop
    (
|#

