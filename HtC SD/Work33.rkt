;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work33) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; ===========================
;; Data definition
(define-struct r3 [x y z])
;; An R3 is a structure: (make-r3 Number Number Number)
;; (make-r3 a b c) interp. a is the x-coordinate, b is the y-coordinate and c is the z-coordinate.
(define ex1 (make-r3 1 2 3))
#;
(define (fn-for-r tdo)
  (... (r3-x tdo)
       (r3-y tdo)
       (r3-z tdo)))
;; Template rules used:
;; -Consists of: 3 Parts
;; !!!

;; ============================
;; Functions:
;; 3-Dimensiona-Object -> Number
;; purpose: Measure the distance between tdo and the center
;(define (compute-distance tdo) 0);stub
(check-within (compute-distance (make-r3 1 2 3))
              (sqrt (+ (sqr 1) (sqr 2) (sqr 3))) 0.00000001)
;<use template from 3-Dimensional-Object>
(define (compute-distance tdo)
  (sqrt (+ (sqr (r3-x tdo))
           (sqr (r3-y tdo))
           (sqr (r3-z tdo)))))