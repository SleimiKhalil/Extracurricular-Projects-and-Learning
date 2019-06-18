;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work13) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; DATA DEFINITIONS:

;; Season is one of:
;; - "spring"
;; - "summer"
;; - "fall"
;; - "winter"
;; interp. the four seasons of the year
;; <examples are redundant for enumerations>

#;
(define (fn-for-season s)
  (cond
    [(string=? "spring" s) (...)]
    [(string=? "summer" s) (...)]
    [(string=? "fall" s) (...)]
    [(string=? "winter" s)(...)]))

;; Template rules used:
;;  -one of: 4 cases:
;;  -atomic distinct "spring"
;;  -atomic distinct "summer"
;;  -atomic distinct "fall"
;;  -atomic distinct "winter"

;; FUNCTIONS: 

;; Season -> Season
;; produce the next season to the given season
;(define (next-season s) "summer");stub

(check-expect (next-season "spring") "summer")
(check-expect (next-season "summer") "fall")
(check-expect (next-season "fall") "winter")
(check-expect (next-season "winter") "spring")



;<use template from Summer>
#;
(define (fn-for-season s)
  (cond
    [(string=? "spring" s) (...)]
    [(string=? "summer" s) (...)]
    [(string=? "fall" s) (...)]
    [(string=? "winter" s)(...)]))


(define (next-season s)
  (cond
    [(string=? "spring" s) "summer"]
    [(string=? "summer" s) "fall"]
    [(string=? "fall" s) "winter"]
    [else "spring"]))

