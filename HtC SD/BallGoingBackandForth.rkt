;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname BallGoingBackandForth) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; ================================
;; Constants:
(define WIDTH 200)
(define HEIGHT 100)
(define SPEED 3) ;SPEED pixels per second
(define MTS (empty-scene WIDTH HEIGHT))
(define BALL (circle SPEED "solid" "red"))

;; ================================
;; Data definitions:
;; Location is the distance of the ball in pixels from the top
(define l1 (/ HEIGHT 2))

(define (fn-for-location l)
  (... l))
;; Template rules used:
;; -atomic non-distinct: number

;; Direction is one of:
;; -up if the ball is mving upwards
;; -down if the ball is moving downwards
(define UP "up")
(define DOWN "down")
#;
(define (fn-for-direction d)
  (cond
    [(equal? UP d) (...)]
    [(equal? DOWN d) (...)]))
;; Template rules used:
;; - is one of: 2 cases
;; - atomic distinct: UP
;; - atomic distinct: DOWN

;; Velocity is the combination of direction and speed#should we define it??


;; dirloc is the combination of direction and location
(define-struct dirloc [direction location])


;; =================================
;; Functions
;; dirloc -> dirloc
;; produces the next ball position and direction of the ball
(define (tock dl)
  
  (make-dirloc (cond
                 [(<= 0 (dirloc-location dl) HEIGHT) (dirloc-direction dl)]
                 [(<= (dirloc-location dl) 0) DOWN]
                 [(>= (dirloc-location dl) HEIGHT) UP]
                 ) (cond
                     [(equal? (dirloc-direction dl) UP) (- (dirloc-location dl) SPEED)]
                     [(equal? (dirloc-direction dl) DOWN) (+ (dirloc-location dl) SPEED)]
                     [else (dirloc-location dl)]);; if you get to this else clause, something really wrng is happening
                   ))

;; dirloc -> Image
;; produce the image of the ball in the location specified by dl
(define (render dl)
  (place-image BALL (/ WIDTH 2) (dirloc-location dl) MTS))



(define (main dl)
  (big-bang dl
    [on-tick tock]
    [to-draw render]))


(main (make-dirloc UP 0))