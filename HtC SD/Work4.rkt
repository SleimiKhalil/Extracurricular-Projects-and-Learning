;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define TICKET-PRICE-AVERAGE 5)
(define ATTENDANCE-AVERAGE 120)
(define SHOW-FIXED-COST 0)
(define COST-PER-ATTENDEE 1.50)
(define AVERAGE-PRICE-INCREMENTATION 0.1)
(define AVERAGE-ATTENDEE-INCREMENTATION 15)

;; Number -> Number
;; from given ticket price, produce average attendance (average attendance can't be negative)

;(define (average-attendance price) 0) ;stub
(check-expect (average-attendance 5) 120)
(check-expect (average-attendance 5.1) 105)
(check-expect (average-attendance 4.9) 135)

;(define (average-attendance price); template
;  (... price))


  

(define (average-attendance price)
  (if (<= 0 (- ATTENDANCE-AVERAGE (* (/ (- price TICKET-PRICE-AVERAGE) AVERAGE-PRICE-INCREMENTATION) AVERAGE-ATTENDEE-INCREMENTATION)))
      (- ATTENDANCE-AVERAGE (* (/ (- price TICKET-PRICE-AVERAGE) AVERAGE-PRICE-INCREMENTATION) AVERAGE-ATTENDEE-INCREMENTATION))
      0))
;; Natural -> Number
;; given number of attendees produce show cost(attendee number must be positive, otherwise return 0)
;(define (show-cost attendee-number) 0) ;stub
;(define (show-cost attendee-number);template
;  (... attendee-number))
(check-expect (show-cost 0) SHOW-FIXED-COST)
(check-expect (show-cost -10) SHOW-FIXED-COST)
(check-expect (show-cost 100) (+ SHOW-FIXED-COST (* 100 COST-PER-ATTENDEE)))
(check-expect (show-cost 200) (+ SHOW-FIXED-COST (* 200 COST-PER-ATTENDEE)))
(define (show-cost attendee-number)
  (if (<= 0 attendee-number)
      (+ SHOW-FIXED-COST (* attendee-number COST-PER-ATTENDEE))
      SHOW-FIXED-COST))

;; Number -> Number
;; given price, produce average income 
;(define (average-income price) 0); stub
(check-expect (average-income 5) (* ATTENDANCE-AVERAGE 5))
(check-expect (average-income 5.1) (* (- ATTENDANCE-AVERAGE  AVERAGE-ATTENDEE-INCREMENTATION) 5.1))
(check-expect (average-income 4.9) (* (+ ATTENDANCE-AVERAGE  AVERAGE-ATTENDEE-INCREMENTATION) 4.9))

;(define (average-income price);template
;  (... price))

(define (average-income price)
      (* price (average-attendance price))
      )

;; Number -> Number
;; given ticket price, produce average show cost (because we know the average attendee number)(Can we say that if price is 0 or negative, the cost will be infinite?)
;(define (average-cost price) 0);stub
(check-expect (average-cost 5) (+ SHOW-FIXED-COST (* COST-PER-ATTENDEE ATTENDANCE-AVERAGE)))

;(define (average-cost price);template
;  (... price))

(define (average-cost price)
  (+ SHOW-FIXED-COST (* COST-PER-ATTENDEE (average-attendance price))))

;; Number -> Number
;; produce potential gain from given price
;(define (potential-gain price) 0);stub
(check-expect (potential-gain 5) (- (* ATTENDANCE-AVERAGE 5) (+ SHOW-FIXED-COST (* COST-PER-ATTENDEE ATTENDANCE-AVERAGE))))

;(define (potential-gain price)
;   (... price))

(define (potential-gain price)
   (- (average-income price) (average-cost price)))



(potential-gain 2.925)
(potential-gain 3.65)

(potential-gain 3)
(potential-gain 4)
(potential-gain 5)
