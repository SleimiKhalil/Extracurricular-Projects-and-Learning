;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work23) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; DATA DEFINITION:

;; Price is a non-negative number
;;  It is one of:
;;   -Number[0, 1000)
;;   -Number[10000, infinity)
;;   -Number[1000, 10000)

;; Interp: The price of an Item:
;;     -Inexpensive items: Number[0, 1000)
;;     -Luxury Items: Number[10000, infinity)
;;     -else: Number[1000, 10000)

(define (fn-for-price ip)
  (cond
    [(>= ip 10000) (... ip)]
    [(< ip 1000) (... ip)]
    [else (... ip)]))
; Template rules used:
;   -is one of: 3 Cases
;   -Atomic non-distinct: Number[0, 1000)
;   -Atomic non-distinct: Number[1000, 10000)
;   -Atomic non-distinct: Number[10000, infinity)


(define LUXURY-TAX 0.08)
(define INEXPENSIVE-TAX 0.00)
(define MIDDLE-TAX 0.05)
;; FUNCTIONS:

; Price -> Number
; purpose: given the price of an item, computes the sales tax
(check-expect (tax-on-item 0) 0)
(check-expect (tax-on-item 1000) 50)
(check-expect (tax-on-item 10000) 800)
(check-expect (tax-on-item 500) 0)
(check-expect (tax-on-item 5000) 250)
(check-expect (tax-on-item 50000) 4000)
;<use template from Price>
(define (tax-on-item ip)
  (cond
    [(>= ip 10000) (* LUXURY-TAX ip)]
    [(< ip 1000) (*  INEXPENSIVE-TAX 0)]
    [else (* MIDDLE-TAX ip)]))