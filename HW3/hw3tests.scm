(mydisplay "1. INTERSECTION --------------------------------------")
(mydisplay (intersection '(a b c) '(1 2 a b c)))
(mydisplay (intersection '(a b c) '(1 2 a b c 0)))
(mydisplay (intersection '(a b c) '(1 2)))

(mydisplay "2. QUADRATIC --------------------------------------")
(mydisplay (quadratic 1 0 0))
(mydisplay (quadratic 0 1 0))
(mydisplay (quadratic 3 4 2))
(mydisplay (quadratic 5 6 1))
(mydisplay (quadratic 5 2 1))
(mydisplay (quadratic 1 2 1))

(mydisplay "3. MULTIPLYIT --------------------------------------")
(mydisplay (multiplyIt 3 '(-1 1 2 3 4 -4 5)))

(mydisplay "4. REMOVETAIL --------------------------------------")
(mydisplay (removeTail 1 '(1 2 3)))
(mydisplay (removeTail 1 '(1 2 1 1 14 1 5 6)))
(mydisplay (removeTail 1 '()))
(mydisplay (removeTail 1 '(1)))

(define square '(lambda (x) (* x  x)))
(define cube '(lambda (x) (* x  x  x)))
(define clamp '(lambda (x) (if (< x 0) 0 x)))

; Uncomment the following lines when you have a working implementation
; of compose
(define cubeOfClamp (compose cube clamp))
(define sqrOfCube (compose square cube))
(define clampOfCube (compose clamp cube))

(mydisplay "5. COMPOSE --------------------------------------")
(mydisplay (cubeOfClamp -2))
(mydisplay (cubeOfClamp 2))
(mydisplay (sqrOfCube -2))
(mydisplay (sqrOfCube 2))
(mydisplay (clampOfCube -2))
(mydisplay (clampOfCube 2))

(mydisplay "6. GETORDER --------------------------------------")
(mydisplay (getOrder SALES 1))
(mydisplay (getOrder SALES 3))
(mydisplay (getOrder SALES 293))

(mydisplay "7. GETPROFIT --------------------------------------")
(mydisplay (getProfit '(3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum")))
(mydisplay (getProfit '(293 ("10/1/2012" "10/2/2012") (10123.02 0.07 457.81 208.16) ("Delivery Truck" "Northwest Territories") "1.7 Cubic Foot Compact Cube Office Refrigerators")))

(mydisplay "8. TOTALPROFITS --------------------------------------")
(mydisplay (totalProfits SALES RETURNS))

(mydisplay "9. GETPROV --------------------------------------")
(mydisplay (getProv '(3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum")))
(mydisplay (getProv '(293 ("10/1/2012" "10/2/2012") (10123.02 0.07 457.81 208.16) ("Delivery Truck" "Northwest Territories") "1.7 Cubic Foot Compact Cube Office Refrigerators")))

(mydisplay "10. GETPROVINCES --------------------------------------")
(mydisplay (getProvinces SALES))

(mydisplay "11. PROVINCIALPROFIT --------------------------------------")
(mydisplay (provincialProfit SALES RETURNS))