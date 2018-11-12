; Helper function - do not change
(define (mydisplay value)
	(display value)
	(newline)
	#t
)

; Returns the intersection of two sets. The inputs are flat lists
; of atoms. The result is a flat list containing all the elements
; that appear in both of the two lists. No duplicates 
; should be present in the result. Order is not important.
; You can use the built-in function member.
; (intersection '(a b c) '(1 2 a b c)) -> (a b c)
; (intersection '(a b c) '(1 2 a b c 0)) -> (a b c)
; (intersection '(a b c) '(1 2)) -> ()
(define contains member) ;function member usage
(define (intersection lst1 lst2)
	(if (null? lst1)
		'()
	(if (contains (car lst1) lst2)
          (cons (car lst1) (intersection (cdr lst1) lst2))
          (intersection (cdr lst1) lst2)))))

; Returns the roots of the quadratic formula, given
; ax^2+bx+c=0. Return only real roots. Thus, the list will
; have 0, 1, or 2 *unique real* roots. If a = 0, return  
; the string "division by 0".
(define (quadratic a b c)
  (cond
  ((= a 0)'(division by 0))
  ((< (-(* b b)(* 4 (* a c))) 0) '())
  ((> (-(* b b)(* 4 (* a c))) 0) 
	
   (list (/ (-(sqrt(-(* b b) (*(* 4 a)c))) b)(* 2 a))
    (/ (-(-(sqrt(-(* b b)(*(* 4 a) c)))) b)(* 2 a))))
    ((=(-(* b b) (* 4 (* a c))) 0)

     (list (/ (-(sqrt(-(* b b)(*(* 4 a)c))) b)(* 2 a))))
    (else '(division by 0))))


; Return a list containing the original list's values multiplied by c.
; lst is a list of integers and c is an integer
(define (multiplyIt c lst)
	(map (lambda (x) (* c x)) lst)))

; Removes all occurrences of v from lst,
; where v is an integer and lst is a list of integers.
; The function must use tail recursion!
; No points if tail recursion is not used!
(define (removeTail v lst)
	(if (null? lst)
     '()
    (let ((remove (car lst)))
    ((if (eqv? v remove)
		(lambda (y) y)
		(lambda (y) (cons remove y)))
	(removeTail v (cdr lst))))))

; compose takes two functions and returns a new function that 
; is the composition, F1 o F2. The two inputs are lambda functions.
; Assume that F1 takes only one parameter as an input
(define (compose F1 F2)
	(lambda (x) ((eval F1(interaction-environment)) ((eval F2 (interaction-environment)) x)))) 

; sales.scm contains all the company's sales.
; You should not modify this file. Your code
; should work for other instances of this file
; such as salesBig.scm 
(load "sales.scm")
;(load "salesBig.scm")

; Returns a list containing the order information for all sales records
; that have a matching order number with orderNo.
; Returns the empty list id there is no record of an order with the
; given orderNo.
; (getOrder SALES 3) -> ((3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum"))
; (getOrder SALES 293) -> ((293 ("10/1/2012" "10/2/2012") (10123.02 0.07 457.81 208.16) ("Delivery Truck" "Nunavut") "1.7 Cubic Foot Compact Cube Office Refrigerators")
;                          (293 ("10/1/2012" "10/3/2012") (244.57 0.01 46.71 8.69) ("Regular Air" "Nunavut") "Cardinal Slant-D? Ring Binder, Heavy Gauge Vinyl")
;                          )
; (getOrder SALES 1) -> ()
; TODO: Fill this in
(define (getOrder sales orderNo)
	(if (not (null? sales))
    (if (= orderNo (caar sales))
		(car sales)
		(getOrder (cdr sales) orderNo)
             )
         '()
         ))

; Returns the profit information out of a given record for a sale.
; (getProfit '(3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum")) -> -213.25
(define (getProfit sale)
	(caddr(caddr sale)))

; Returns the total profits for all sales. Returned
; orders are not included in this total.
(define (totalProfits sales returns)
(if (not (null? sales))
	(if (not (memv (caar sales) returns))
        (+ (caddr (caddar sales)) (totalProfits (cdr sales) returns))
        (+ 0 (totalProfits (cdr sales) returns))
         )
      0))

; Returns the province information out of a given record for a sale.
; (getProv '(3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum")) -> Nunavut
(define (getProv sale)
	(cdr(cadddr sale)))

; Returns the set (i.e., list with no duplicates) of provinces that the company sold to.
(define (getProvinces sales)
 (if (not (null? sales))
	(if (not (null? (cdr sales)))
		(if (not(string=? (cadar (cdddar sales)) (cadadr (cddadr sales)) ))
			(append (list `(,(cadar(cdddar sales)))) (getProvinces (cdr sales)))
            (append '() (getProvinces (cdr sales))))
		(list `(,(cadar(cdddar sales))))
          )
      '()))

; Returns the list of provinces, each with its total profit.
; The expected result is a list of the form
; '((prov1 profit1) (prov2 profit2) ... (provn profitn) 
; where profiti is the total profit of province prov1
; and prov1, prov2, ... provn are unique (no duplicates)
(define (provincialProfit sales returns)
	(if (not (null? sales))
          (if (not (null? (cdr sales)))
              (if (not (string=? (cadar (cdddar sales)) (cadadr (cddadr sales)) ))
                  (append (list (list (cadadr(cddadr sales)) (oneProvince (cdr sales) returns)))
                          (provincialProfit (cdr sales) returns))
                  (append '() (provincialProfit (cdr sales) returns)))
              '())
          '()))

; Returns the profit for one province to help provincialProfit
(define (oneProvince sales returns)
   (if (not (null? sales))
	(if (not (null? (cdr sales)))
		(if (string=? (cadar (cdddar sales)) (cadadr (cddadr sales)))
           (if (not (memv (caar sales) returns))
			(+ (caddr (caddar sales)) (oneProvince (cdr sales) returns))
			(+ 0 (oneProvince (cdr sales) returns)))
        (caddr (caddar sales)))
    (caddr (caddar sales)))
      0))
	
; Do not modify the following line
(load "hw3tests.scm")

,exit
