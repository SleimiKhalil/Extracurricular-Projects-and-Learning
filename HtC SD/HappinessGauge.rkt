;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HappinessGauge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; Number -> Number
; decreases ws by 0.1 per clocktick as long as it is > 0
; return zero otherwise

(define EMPTY-GAUGE-WIDTH 100)
(define EMPTY-GAUGE-HEIGHT 20)

(define (tock ws)
  (if (< 0 ws)
      (- ws 0.1)
      0))
; Number String -> Number
; if key is "down arrow" increase happiness by 1/5
; if key is "up arrow" happiness jumps by 1/3

(define (ke-h ws key)
  (cond
    [(key=? "down" key) (* 6/5 ws)]
    [(key=? "up" key) (* 4/3 ws)]
    [#t ws]))

; Number -> Image
; Produce the happiness gauge filled part at ws
(define (happiness-gauge ws)
  (rectangle ws EMPTY-GAUGE-HEIGHT "solid" "red"))

; The constant empty happiness gauge
(define EMPTY-GAUGE
  (empty-scene EMPTY-GAUGE-WIDTH  EMPTY-GAUGE-HEIGHT "black"))

; Number -> Image
; Produce the happiness gauge at ws (superposing the amount filled over the empty-scene)
(define (render ws)
  (place-image (happiness-gauge ws) (/ ws 2) (/ EMPTY-GAUGE-HEIGHT 2) EMPTY-GAUGE))

; Big bang main

(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tock]
    [on-key ke-h]))