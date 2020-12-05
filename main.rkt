#lang racket

(require csv-reading)
(require plot)

(define csv-path "./KO2.csv")

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

(define (get-SMA days)
  (let loop
    ([col (get-column 5)]
     [result empty])
    (if (>= (length col) days)
        (loop (cdr col) (append result (list(suma-SMA col days))))
        result)))
        

(define (sum-EMA val1 val2 days)
  (+(* val2(/ 2 (add1 days))) (* val1 (- 1 (/ 2 (add1 days))))))
  

(define (get-EMA col days)
  (let loop
    ([result  (list (suma-SMA col days))]
     [cont days]
     [val1 (suma-SMA col days)]
     [val2 (list-ref col (add1 days))]
     [a (length col)])
    (if (equal? a cont)
        result
         (loop (append result (list (sum-EMA val1 val2 days))) (add1 cont) (last_element result)(list-ref col  cont) (length (cdr col))) )))

(define (sumatoria col n)
  (let loop
    ([cont n]
     [res 0]
     [col col])
    (if  (zero? cont)
         res
        (loop (sub1 cont) (+ res (car col)) (cdr col)))))
#|
(define (get-sumatoria col days)
  (let loop
    ([col col]
     [result empty])
    (if (>= (length col) days)
        (loop (cdr col) (append result (list(sumatoria col days))))
        result)))
|#

(define (get-factores n)
  (let loop
    ([n n]
     [result (range 1 (add1 n))])
    (if (zero? n)
        result
        (loop (sub1 n) (append result (list n))))))

(define (get-elements col n)
  (let loop
    ([col col]
     [n n]
     [result empty])
    (if (zero? n)
        result
        (loop (cdr col) (sub1 n) (append result (list (car col)))))))

(define (solve-TMA baa days)
  (define a (foldr + 0 baa))
 (/ a (foldr + 0 (get-factores days))))

(define (sum-TMA col days)
  (let loop
    ([list1  col]
     [list2 (get-factores (/ days 2))]
     [result empty])
     ;(if (empty? list2)
         ;(sum-TMA list1 days)
         (if (empty? list2)
             ;(solve-TMA result (/ days 2))
        result
         (loop (cdr list1) (cdr list2) (append result (list (* (car list1) (car list2))))))))

(define (sum-TMA2 days)
  (let loop
    ([list1  (get-column 5)]
     [list2 (get-factores (/ days 2))]
     [result empty])
     ;(if (empty? list2)
         ;(sum-TMA list1 days)
         (cond
           [(empty? list2) (loop list1 (get-factores (/ days 2)) (solve-TMA result (/ days 2)))]
           [(empty? list1) result]
         [else (loop (cdr list1) (cdr list2) (append result (list (* (car list1) (car list2)))))])))
      
(define (jump col n)
  (let loop
    ([col col]
     [n n])
    (if(zero? n)
    col
    (loop (cdr col) (sub1 n)))))

(define (get-MACD col day1 day2)
  (let loop
    ([val1 (jump (get-EMA col day1) (- day2 day1))]
     [val2 (get-EMA col day2)]
     [result empty])
    (if (empty? val1)
        result
        (loop (cdr val1) (cdr val2) (append result (list (- ( car val1) (car val2))))))))

(define (minimum lst acc)
  (cond
    ((null? lst) acc)
    ((< (car lst) acc)
     (minimum (cdr lst) (car lst)))
    (else
     (minimum (cdr lst) acc))))

(define (mymin lst)
  (if (null? lst)
      #f
      (minimum (cdr lst) (car lst))))

(define (min)
  (let loop
    ([val (get-column 5)]
     [col (get-column 4)]
     [col2 empty]
     [result empty]
     [n 5])
    (cond
      [(empty? val) result]
      [(equal? 1 n) (loop val col (cdr col2) (append result (list (- (car val) (mymin col2)))) 2)]
      ;[(equal? 2 n) (loop  (cdr val) (cdr col) (append col2 (list (car col))) (append result (list (- (car val) (mymin col2)))) 2)]
      [else (loop (cdr val) (cdr col) (append col2 (list (car col))) result (sub1 n))])))

(define (mymax L)
  (let loop ((L (cdr L)) 
             (m (car L)))         
    (cond
      [(empty? L) m]
      [(> (car L) m)               
         (loop (cdr L) (car L))]
      [else                       
         (loop (cdr L) m)])))

(define (max)
  (let loop
    ([val (get-column 3)]
     [col (get-column 4)]
     [col2 empty]
     [val2 empty]
     [result empty]
     [n 5])
    (cond
      [(empty? val) result]
      [(equal? 1 n) (loop val col (cdr col2) (cdr val2) (append result (list (- (mymax val2) (mymin col2)))) 2)]
      ;[(equal? 2 n) (loop  (cdr val) (cdr col) (append col2 (list (car col))) (append result (list (- (car val) (mymin col2)))) 2)]
      [else (loop (cdr val) (cdr col) (append col2 (list (car col))) (append val2 (list (car val))) result (sub1 n))])))

(define (mid)
  (let loop
    ([min (min)]
     [max (max)]
     [result empty])
    (if (empty? min)
        result
        (loop (cdr min) (cdr max) (append result (list (/ (car min) (car max))))))))

(define (get-STOC)
  (let loop
    ([mid (mid)]
     [result empty])
    (if (empty? mid)
        result
        (loop (cdr mid) (append result (list (*(- 1 (car mid)) 100)))))))
  
