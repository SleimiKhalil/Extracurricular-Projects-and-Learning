;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work31) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct time [hour minute second])

; A time is a structure
; (make-time 23 59 59)
;interpretation (make-time hh mm ss) means a time at hour hh, at minute mm at second ss

(define three-letter [first second third])

; A three-letter is a structure
;    (make-three-letter f s t)
; where each of f s and t are either a 1String or #false
; interpretation (make-three-letter f s t) means a three-letter where f is the first letter, s is the second letter and t is the third letter



;A Color is one of:
;--- "white"
;--- "yellow"
;--- "orange"
;--- "green"
;--- "red"
;--- "blue"
;--- "black"

