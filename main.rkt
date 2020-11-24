(define (file->list filename-in (a '()))
    (call-with-input-file filename-in 
        (lambda (in)
            (let loop
                ([line (read-line in)]
                 [a a])
                (cond
                    [(eof-object? line) a]
                    [else
                       ; (displayln line)
                        (loop (read-line in)(append a (list line)) )])))
    )
)

(define (list->file filename-out list)
    (call-with-output-file filename-out #:exists 'truncate
        (lambda (out)
            (let loop
                ([list list]
                [n 0])
                (cond
                    [(empty? list) n]
                    [else
                        (fprintf out "~a\n" (car list))
                        (loop (cdr list) (add1 n))])))))


