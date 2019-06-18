;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Work1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(define treeHeight 30)
(define treeWidth 7)
(define treeColor "brown")
(define treeBranchesLength 30)
(define treeBranchesColor "green")
(define treeRoot (rectangle treeWidth treeHeight "solid" treeColor))
(define treeBranches (square treeBranchesLength "solid" treeBranchesColor))
(define backgroundColor "blue")
(define treeEmptyCanvas (empty-scene (+ treeWidth treeBranchesLength) (+ treeHeight treeBranchesLength) backgroundColor))
(define tree (place-image treeBranches (/ (image-width treeEmptyCanvas) 2) (/ treeBranchesLength 2)  (place-image treeRoot (/ (image-width treeEmptyCanvas) 2) (- (image-height treeEmptyCanvas) (/ treeHeight 2)) treeEmptyCanvas )))

(define canvasWidth 100)
(define canvasHeight 100)

(define Canvas (empty-scene canvasWidth canvasHeight backgroundColor))
(define scene (place-image tree (/ canvasWidth 2) (- canvasHeight (/ (image-height tree) 2)) Canvas))
scene