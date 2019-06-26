;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work28) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; Bouncing ball
(define WIDTH 50)
(define HEIGHT 350)
(define CIRCLE-RAY 20)
(define BALL (circle CIRCLE-RAY "solid" "red"))
(define MTS (empty-scene WIDTH HEIGHT))
(define SPEED 2)
;; Data definitions:
;; Direction is one of:
;; - "up" interp. the ball is moving upwards with SPEED
;; - "down" interp. the ball is moving downwards with SPEED

;; Velocity is a Structured Type
(define-struct velocity [sp dir])
(define v1 (make-velocity SPEED "up"))
(define v2 (make-velocity SPEED "down"))

;; Position is posn



;; Functions:

;; 