;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work15) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; DATA DEFINITIONS:
;; CarSpeed is Number[0, 200]
;; interp. the speed of a car in km/h: 0 means stopped, 200 is the maximum speed

(define CS1 0)
(define CS2 200)
(define CS3 110)
#;
(define (fn-for-car-speed cs)
  (... cs))

;; Template rules used: atomic non distinct


;; FUNCTIONS:

;; CarSpeed -> Boolean
;; produces true if Car Speed is (strictly) above 110 km/h, false otherwise.
;(define (speeding? cs) #f);stub

(check-expect (speeding? 0) #f)
(check-expect (speeding? 200) #t)
(check-expect (speeding? 110) #f)
;<use template from CarSpeed>
(define (speeding? cs)
  (> cs 110))