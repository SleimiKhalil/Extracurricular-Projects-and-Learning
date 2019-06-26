;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work19) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define WIDTH 500)
(define HEIGHT 20)
;; Position between the left margin and the center of the ball
;; Position Keyboard -> Position
(define (ke-h ws key)
  (cond
        [(string=? "left" key)
         (if (< ws 0) 0 (- ws 5))]
        [(string=? "right" key)
         (if (> ws WIDTH) WIDTH (+ ws 5))]
        [else ws]))
(define RAY 6)
(define RED (circle RAY "solid" "red"))
(define CANVAS (empty-scene WIDTH HEIGHT))
;; Position -> Image
(define (render ws)
  (place-image RED ws (/ HEIGHT 2) CANVAS))

(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-key ke-h]))