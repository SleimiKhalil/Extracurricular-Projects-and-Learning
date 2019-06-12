(define CANVAS-WIDTH 250)
(define CANVAS-HEIGHT 25)
(define CANVAS-BACKGROUND "blue")
(define CANVAS (empty-scene CANVAS-WIDTH CANVAS-HEIGHT CANVAS-BACKGROUND))
(define CAR-HEIGHT CANVAS-HEIGHT)
(define CAR-WIDTH (* 2 CAR-HEIGHT))
(define CAR-CANVAS (empty-scene CAR-WIDTH CAR-HEIGHT CANVAS-BACKGROUND))
(define CAR-COLOR "grey")
(define CAR-BODY (overlay (rectangle CAR-WIDTH (* 0.5 CAR-HEIGHT) "solid" CAR-COLOR) CAR-CANVAS));I know it is not this
(define CAR (place-image (rectangle (* 1/2 CAR-WIDTH) (/ CAR-HEIGHT 4) "solid" CAR-COLOR) (/ CAR-WIDTH 2) (/ CAR-HEIGHT 8) (place-image (circle (/ CAR-HEIGHT 5) "solid" "black") (* 1/5 CAR-WIDTH) (* 3/4 CAR-HEIGHT)  (place-image (circle (/ CAR-HEIGHT 5) "solid" "black") (* 4/5 CAR-WIDTH) (* 3/4 CAR-HEIGHT) CAR-BODY))));Just add wheels
(define (tock cw)
  (+ cw 3))
; Number -> Boolean
; Produce true if current state is greater than canvas width
(check-expect (end? (- CANVAS-WIDTH 10)) #f)
(check-expect (end? CANVAS-WIDTH) #f)
(check-expect (end? (+ CANVAS-WIDTH 10)) #t)
;(define (end? cw) #t);stub
;(define (end? cw);template
;  (... cw))
(define (end? cw)
  (< CANVAS-WIDTH cw))

; Number -> Image
; Produce image of Truck in the given world state
; (define (render cw) (square 5 "solid" "red"));stub

;(define (render cw);template
;  (... cw))
(define (render cw)
  (place-image CAR cw (- CANVAS-HEIGHT (/ CAR-HEIGHT 2)) CANVAS ))

(big-bang 0
  [on-tick tock]
  [stop-when end?]
  [to-draw render];it is not animate; it is draw; nope it is to-draw!!
  )

