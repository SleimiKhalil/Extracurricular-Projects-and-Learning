;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Work36-Own work text editor|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
;; ========================
;; Data definition:
(define-struct text+location [text location])
;; Text+Location is a structure:
;;     (make-text+location String Natural)
;; (make-text+loction theText theLocation) is a Text+Location instance where theText is the text entered so far and theLocation is the location of the cursor
(define tl1 (make-text+location "HelloWorld" 5))
(define (fn-for-text+location tl)
  (... (text+location-text tl) ... (text+location-location tl) ))
;; Template rules used:
;; - Consists of: 2 Parts

;; ==================================
;; Functions:
(define (main tl)
  (big-bang tl
    [to-draw render]
    [on-key ke-h]))

;; Text+Location -> Image
;; produce the image of the entered text with cursor
(define (render tl)
  (text (string-append (substring (text+location-text tl) 0 (text+location-location tl)) "|" (substring (text+location-text tl) (text+location-location tl))) 20 "black"))

(check-expect (render (make-text+location "HelloWorld" 5)) (text "Hello|World" 20 "black"))

;; Text+Location -> Text+Location
;; Add characters in given position of string or delete them, move cursor with arrow keys
(define (ke-h tl key)
  (cond
    [(and (key=? key "left") (< 0 (text+location-location tl))) (make-text+location (text+location-text tl) (- (text+location-location tl) 1))]
    [(and (key=? key "right") (> (string-length (text+location-text tl)) (text+location-location tl))) (make-text+location (text+location-text tl) (+ (text+location-location tl) 1))]
    [(and (key=? key "\b") (< 0 (text+location-location tl))) (make-text+location (string-append (substring (text+location-text tl) 0 (sub1 (text+location-location tl))) (substring (text+location-text tl) (min (string-length (text+location-text tl)) (text+location-location tl)) (string-length (text+location-text tl)))) (sub1 (text+location-location tl)))]
    
    [else (make-text+location (string-append (substring (text+location-text tl) 0 (text+location-location tl)) key (substring (text+location-text tl) (min (string-length (text+location-text tl)) (text+location-location tl)) (string-length (text+location-text tl)))) (add1 (text+location-location tl)))]));This should be all other keys


(main (make-text+location "HelloWorld" 5))