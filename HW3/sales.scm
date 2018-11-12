; From community.tableau.com

; These are order numbers that were returned. Revenue and profit do not count toward totals.
(define RETURNS '(998 1412))

; Format of indiviudal sales
;(orderNum (orderDate shipDate) (grossSale discount profit unitPrice) (deliveryMethod province) product)
(define SALES '(
 (3 ("10/13/2010" "10/20/2010") (261.54 0.04 -213.25 38.94) ("Regular Air" "Nunavut") "Eldon Base for stackable storage shelf, platinum")
 (293 ("10/1/2012" "10/2/2012") (10123.02 0.07 457.81 208.16) ("Delivery Truck" "Northwest Territories") "1.7 Cubic Foot Compact Cube Office Refrigerators")
 (995 ("5/30/2011" "5/31/2011") (1815.49 0.03 782.91 39.89) ("Regular Air" "Nunavut") "Ultra Commercial Grade Dual Valve Door Closer")
 (998 ("11/25/2009" "11/26/2009") (248.26 0.07 93.80 15.74) ("Regular Air" "Nunavut") "#10-4 1/8 x 9 1/2 Premium Diagonal Seam Envelopes")
 )
)
