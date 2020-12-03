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
                [(equal? col 2) (append result (list (cadar file)))]
                [(equal? col 3) (append result (list (string->number(caddar file))))]
                [(equal? col 4) (append result (list (string->number(car (cdddar file)))))]
                [(equal? col 5) (append result (list (string->number(cadr (cdddar file)))))]
                [(equal? col 6) (append result (list (string->number(caddr (cdddar file)))))]
                [(equal? col 7) (append result (list (string->number(car (cdddr (cdddar file))))))]
                )))))
