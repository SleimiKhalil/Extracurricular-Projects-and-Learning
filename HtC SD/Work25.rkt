;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work25) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp") (lib "web-io.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

(define CLOSED "closed")
(define LOCKED "locked")
(define OPEN "open")

; DATA DEFINITIONS:
; DoorState is one of:
; -- CLOSED
; -- LOCKED
; -- OPEN

; Examples for enumeration are redundant
(define (fn-for-door-state ds)
  (cond
    [(equal? ds CLOSED) (...)]
    [(equal? ds LOCKED) (...)]
    [(equal? ds OPEN) (...)]))

; Template rules used:
; - is one of:
; - atomic distinct: CLOSED
; - atomic distinct: LOCKEDED
; - atomic distinct: OPEN

; FUNCTIONS:

; DoorState -> DoorState
; purpose: unlock the door (change ds from LOCKED to CLOSED, keep others as they are)
;(define (unlock-door ds) CLOSED);stub
(check-expect (unlock-door LOCKED) CLOSED)
(check-expect (unlock-door CLOSED) CLOSED)
(check-expect (unlock-door OPEN) OPEN)
;<use template from DoorState>
(define (unlock-door ds)
  (cond
    [(equal? ds LOCKED) CLOSED]
    [else ds]))


; DoorState -> DoorState
; purpose: lock the door (change ds from CLOSED to LOCKED, keep others as they are)
;(define (lock-door ds) LOCKED);stub
(check-expect (lock-door LOCKED) LOCKED)
(check-expect (lock-door CLOSED) LOCKED)
(check-expect (lock-door OPEN) OPEN)
;<use template from DoorState>
(define (lock-door ds)
  (cond
    [(equal? ds CLOSED) LOCKED]
    [else ds]))

; DoorState -> DoorState
; purpose: opens the door (change ds from CLOSED to OPEN, keep others as they are)
;(define (push-door ds) OPEN);stub
(check-expect (push-door LOCKED) LOCKED)
(check-expect (push-door CLOSED) OPEN)
(check-expect (push-door OPEN) OPEN)
;<use template from DoorState>
(define (push-door ds)
  (cond
    [(equal? ds CLOSED) OPEN]
    [else ds]))

; DoorState -> DoorState
; purpose: closes the door (change ds from OPEN to CLOSED, keep others as they are)
;(define (close-door ds) CLOSE);stub
(check-expect (close-door LOCKED) LOCKED)
(check-expect (close-door CLOSED) CLOSED)
(check-expect (close-door OPEN) CLOSED)
;<use template from DoorState>
(define (close-door ds)
  (cond
    [(equal? ds OPEN) CLOSED]
    [else ds])) ;;Door automatically closes! doesn't need the transition

(define (tock ds)
  (if (equal? OPEN ds)
      CLOSED
      ds))

; the way doors deal with an action in a state is left to them

; DoorState KeyEvent -> DoorState
; Purpose: According to pressed key, do an event "l":lock, "u":unlock or " ":push door
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(define (door-action ds key)
  (cond
    [(string=? key "u") (unlock-door ds)]
    [(string=? key "l") (lock-door ds)]
    [(string=? key " ") (push-door ds)]
    [else ds]))

; DoorState -> Image
; Purpose: generate an image of the door in given state


; DoorState -> Image
; translates the state s into a large text image
(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))
(define (door-render s)
  (text s 40 "red"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick close-door 3]
    [on-key door-action]
    [to-draw door-render]))