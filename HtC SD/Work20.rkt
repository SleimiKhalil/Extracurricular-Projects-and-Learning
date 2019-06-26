;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work20) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 "solid" "green") (rectangle 50 10 "solid" "black")))

; WorldState -> Image
; show the status of the UFO
;(define (status ws) (... ws)); stub
(define (status ws)
  (cond
    [(<= HEIGHT ws) (text "landed" 20 "red")]
    [(>= HEIGHT ws CLOSE) (text "closing in" 20 "red")]
    [(<= 0 ws CLOSE) (text "descending" 20 "red")]))



; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render]))
 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image (status 11) (/ (image-width (status 11)) 2) (/ (image-height (status 11)) 2) (place-image UFO (/ WIDTH 2) 11 MTSCN)))
(define (render y)
  (place-image (status y) (/ (image-width (status y)) 2) (/ (image-height (status y)) 2) 
               (place-image UFO (/ WIDTH 2) y MTSCN)))