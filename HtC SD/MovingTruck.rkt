;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname MovingTruck) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 10 "solid" "brown")))
(define CANVAS-WIDTH 250)
(define CANVAS-HEIGHT 25)
(define CANVAS-BACKGROUND "blue")
(define CANVAS-RAW (empty-scene CANVAS-WIDTH CANVAS-HEIGHT CANVAS-BACKGROUND))
(define CANVAS (place-image tree (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT (/ (image-height tree) 2)) CANVAS-RAW))
(define CAR-HEIGHT CANVAS-HEIGHT)
(define CAR-WIDTH (* 2 CAR-HEIGHT))
(define CAR-CANVAS (empty-scene CAR-WIDTH CAR-HEIGHT CANVAS-BACKGROUND))
(define CAR-COLOR "grey")
(define CAR-BODY (overlay (rectangle CAR-WIDTH (* 0.5 CAR-HEIGHT) "solid" CAR-COLOR) CAR-CANVAS));I know it is not this
(define WHEEL (circle (/ CAR-HEIGHT 5) "solid" "black"))
(define CAR (place-image (rectangle (* 1/2 CAR-WIDTH) (/ CAR-HEIGHT 4) "solid" CAR-COLOR) (/ CAR-WIDTH 2) (/ CAR-HEIGHT 8) (place-image  WHEEL (* 1/5 CAR-WIDTH) (* 3/4 CAR-HEIGHT)  (place-image  WHEEL (* 4/5 CAR-WIDTH) (* 3/4 CAR-HEIGHT) CAR-BODY))));Just add wheels
(check-expect (tock 21) 24)
(check-expect (tock -30) -27)

(define (tock cw)
  (+ cw 3))
; Number -> Boolean
; Produce true if current state is greater than canvas width

;(define (end? cw) #t);stub
;(define (end? cw);template
;  (... cw))
;(define (end? cw)
;  (< (+ CANVAS-WIDTH (/ CAR-WIDTH 2)) cw));stop animation when car dissapears to the right


(define (end? cw)
  (< (- CANVAS-WIDTH (/ CAR-WIDTH 2)) cw));stop animation when car touches the right


; Number -> Image
; Produce image of Truck in the given world state
; (define (render cw) (square 5 "solid" "red"));stub

;(define (render cw);template
;  (... cw))
(define Y-CAR (- CANVAS-HEIGHT (/ CAR-HEIGHT 2)))
(define (render cw)
  (place-image CAR cw Y-CAR CANVAS ))
(define (mh-e cw x y me )
  (if (string=? me "button-down")
      x
      cw))

(check-expect (mh-e 21 10 20 "enter") 21)
(check-expect (mh-e 42 10 20 "button-down") 10)
(check-expect (mh-e 42 10 20 "move") 42)

(define (main ws)
  (big-bang ws
  [on-tick tock]
  [stop-when end?]
  [to-draw render];it is not animate; it is draw; nope it is to-draw!!
  [on-mouse mh-e]
    )
  )

