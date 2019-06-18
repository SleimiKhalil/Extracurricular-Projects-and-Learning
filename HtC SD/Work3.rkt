;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Image Image -> Boolean
;; Produce #true if first image is strictly larger (height and width) than the second
(check-expect (larger-than? (square 10 "solid" "red") (square 10 "solid" "red")) #f)
(check-expect (larger-than? (square 10 "solid" "red") (square 9 "solid" "red")) #t)
(check-expect (larger-than? (square 9 "solid" "red") (square 10 "solid" "red")) #f)

(check-expect (larger-than? (rectangle 10 9 "solid" "red") (rectangle 10 10 "solid" "red")) #f)
(check-expect (larger-than? (rectangle 10 10 "solid" "red") (rectangle 10 9 "solid" "red")) #f)
(check-expect (larger-than? (rectangle 9 10 "solid" "red") (rectangle 10 10 "solid" "red")) #f)
(check-expect (larger-than? (rectangle 10 10 "solid" "red") (rectangle 9 10 "solid" "red")) #f)
(check-expect (larger-than? (rectangle 9 10 "solid" "red") (rectangle 10 9 "solid" "red")) #f)
(check-expect (larger-than? (rectangle 10 9 "solid" "red") (rectangle 9 10 "solid" "red")) #f)


;(define (larger-than? Img1 Img2) #false);stub

;(define (larger-than Img1 Img2)  ;template
;  (... Img1 Img2)
(define (larger-than? Img1 Img2)
  (and (> (image-height Img1) (image-height Img2)) (> (image-width Img1) (image-width Img2))))
