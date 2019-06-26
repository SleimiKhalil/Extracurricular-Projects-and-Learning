;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work34) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; ==============================
;; Data definitions:
(define-struct time [hour minute second])
;; Time is a structure:
;;     (make-time Integer[0, 24) Integer[0, 60) Integer[0, 60))
;; (make-time hh mm ss) interp. hh represents the hour, mm represents the minute and ss represent the second

(define T1 (make-time 10 12 47))

;; Second is a non negative integer

;; =============================
;; Functions:
;; Time -> Second
;; calculates thenumber of seconds from given time
;(define (time->seconds t) 0);stub
(check-expect (time->seconds (make-time 0 0 13)) 13)
(check-expect (time->seconds (make-time 0 54 0)) (* 60 54))
(check-expect (time->seconds (make-time 13 0 0)) (* 60 60 13))
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* 60 60 (time-hour t)) (* 60 (time-minute t)) (time-second t)))