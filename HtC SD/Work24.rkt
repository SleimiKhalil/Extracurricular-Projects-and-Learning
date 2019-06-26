;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work24) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; TrafficLight -> TrafficLight
; yields the next state given current state s
;; WoW better if we had define (define RED "red") and others like it and made the program in this fashion if it is RED, make it GREEN etc. etc. (a bit of abstraction), we can then easily change stuff to (define RED 3)
(check-expect (tl-next "red") "green")
(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))

(define tLIGHTS-WIDTH 90)
(define tLIGHTS-HEIGHT 30)
(define tBULB-RAY 10)
(define tLIGHTS (empty-scene tLIGHTS-WIDTH tLIGHTS-HEIGHT))
(define (tBulb state color) (circle tBULB-RAY (if (string=? state color) "solid" "outline") color))

(define (functional-light current-state)
  (place-image (tBulb current-state "red") (/ tLIGHTS-WIDTH 6) (/ tLIGHTS-HEIGHT 2)
               (place-image (tBulb current-state "yellow") (/ tLIGHTS-WIDTH 2) (/ tLIGHTS-HEIGHT 2)
                            (place-image (tBulb current-state "green") (* tLIGHTS-WIDTH 5/6) (/ tLIGHTS-HEIGHT 2)
                                         tLIGHTS))))

; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (functional-light current-state))




; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 5]))