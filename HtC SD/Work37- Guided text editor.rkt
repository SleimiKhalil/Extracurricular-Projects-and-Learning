;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Work37- Guided text editor|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with
; the cursor displayed between s and t
(define WIDTH 200)
(define HEIGHT 20)
(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define TEXT-SIZE 16)
(define MTS (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" "red"))


; Editor -> Image
; Produce Image of text with cursor in correct place
(check-expect (render (make-editor "Hello" "World")) (overlay/align "left" "center"
                                                                    (beside (text "Hello" TEXT-SIZE "black") CURSOR (text "World" TEXT-SIZE "black"))
                                                                    MTS))

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE "black") CURSOR (text (editor-post ed) TEXT-SIZE "black"))
                 MTS))

; Editor KeyEvent -> Editor
; produce next Editor instance after key is pressed
;(define (edit ed ke) (make-editor "" ""));stub
(check-expect (edit (make-editor "Hello" "World") " ") (make-editor "Hello " "World"))
(check-expect (edit (make-editor "Hello" "World") "\b") (make-editor "Hell" "World"))
(check-expect (edit (make-editor "" "World") "\b") (make-editor "" "World"))
(check-expect (edit (make-editor "Hello" "World") "\t") (make-editor "Hello" "World"))
(check-expect (edit (make-editor "Hello" "World") "\r") (make-editor "Hello" "World"))
(check-expect (edit (make-editor "Hello" "World") "left") (make-editor "Hell" "oWorld"))
(check-expect (edit (make-editor "" "World") "left") (make-editor "" "World"))
(check-expect (edit (make-editor "Hello" "") "right") (make-editor "Hello" ""))
(check-expect (edit (make-editor "Hello" "World") "a") (make-editor "Helloa" "World"))
(define (edit ed ke)
  (cond
    [(and (= 1 (string-length ke)) (<= (string-length (editor-pre ed)) 22)) (cond ; To ignore caracters that'll fall of the right
                               [(key=? ke "\t") ed]
                               [(key=? ke "\r") ed]
                               [(key=? ke "\b") (make-editor (substring (editor-pre ed) 0 (max 0 (sub1 (string-length (editor-pre ed))))) (editor-post ed))]
                               [else (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
                               )]
    [(and (key=? ke "left") (< 0 (string-length (editor-pre ed)))) (make-editor (string-remove-last (editor-pre ed)) (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [(and (key=? ke "right") (< 0 (string-length (editor-post ed)))) (make-editor (string-append (editor-pre ed) (string-first (editor-post ed))) (string-remove-first (editor-post ed)) )]
    [else ed]))

(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

(define (string-remove-last str)
  (substring str 0 (sub1 (string-length str))))

(define (string-last str)
  (substring str (sub1 (string-length str)) (string-length str)))

(define (string-first str)
  (substring str  0 1))

(define (string-remove-first str)
  (substring str 1 (string-length str)))