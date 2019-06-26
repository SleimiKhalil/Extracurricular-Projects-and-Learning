;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work29) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
; A Posn represents the state of the world.
; Posn -> Posn
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p) (place-image DOT (posn-x p) (posn-y p) MTS))

(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

; Posn -> Posn
; resets the position of the world to the current place of the cursor
(check-expect
(reset-dot (make-posn 10 20) 29 31 "button-down")
(make-posn 29 31))
(check-expect
(reset-dot (make-posn 10 20) 29 31 "button-up")
(make-posn 10 20))
(define (reset-dot p0 x y me)
  (if (equal? me "button-down")
      (make-posn x y)
      p0))

; Posn -> Posn
; increases x-coordinate by 3
(define (x+ p0)
  (make-posn (+ (posn-x p0) 3) (posn-y p0)))

; Posn Number -> Posn
; consumes a Posn p and a Number n . It produces a Posn like p with n in the x field.
;(define (posn-up-x p n) (make-posn 0 0)); stub
(check-expect (posn-up-x (make-posn 0 0) 3) (make-posn 3 0))
(define (posn-up-x p n) (make-posn n (posn-y p)))