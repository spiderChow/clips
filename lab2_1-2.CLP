(deftemplate elm (slot n) (slot v) (slot h))


(deftemplate man
  (slot nationality
    (type SYMBOL))
  (slot drink
    (type SYMBOL))
  (slot cigarette
    (type SYMBOL))
  (slot pet
    (type SYMBOL))
  (slot color
    (type SYMBOL))
  (slot location
    (type INTEGER)))

(defrule generation
   =>
   (assert (element color red) 
           (element color green) 
           (element color white)
           (element color yellow)
           (element color blue)
           (element nationality English)
           (element nationality Swedish)
           (element nationality Dane) 
           (element nationality German)
           (element nationality Norwegian)
           (element pet dog)
           (element pet cat)
           (element pet fish)
           (element pet horse)
           (element pet bird)
           (element drink water)
           (element drink coffee)
           (element drink milk)
           (element drink beer)
           (element drink tea)
           (element cigarette BlueMaster)
           (element cigarette Prince)
           (element cigarette Blend)
           (element cigarette Dunhill)
           (element cigarette PallMall)) 
   )

(defrule generate2
    
   ?f <- (element ?s ?e)
   =>
   (retract ?f)
   (assert (elm (n ?s) (v ?e) (h 1))
           (elm (n ?s) (v ?e) (h 2))
           (elm (n ?s) (v ?e) (h 3))
           (elm (n ?s) (v ?e) (h 4))
           (elm (n ?s) (v ?e) (h 5))))

(defrule condition2
    (elm (n nationality) (v English) (h ?n1))   
    (elm (n color) (v red) (h ?c1&?n1))

    (elm (n nationality) (v Swedish) (h ?n2&~?n1))   
    (elm (n pet) (v dog) (h ?p1&?n2)) 

    (elm (n nationality) (v Dane) (h ?n3&~?n2&~?n1)) 
    (elm (n drink) (v tea) (h ?d1&?n3))
    
    (elm (n nationality) (v German) (h ?n4&~?n3&~?n2&~?n1)) 
    (elm (n cigarette) (v Prince) (h ?cig1&?n4))

    (elm (n nationality) (v Norwegian) (h ?n5&1&~?n4&~?n3&~?n2&~?n1))
    (elm (n color) (v blue) (h ?c5&~?c1))
     (test(or(eq ?n5 (+ 1 ?c5))
            (eq ?n5 (- ?c5 1))
          ))

    (elm (n color) (v green) (h ?c2&~?c1&~?c5))
    (elm (n color) (v white) (h ?c3&~?c1&~?c5&~?c2))
    (test(eq ?c2 (- ?c3 1) ))

    (elm (n color) (v green) (h ?c2))
    (elm (n drink) (v coffee) (h ?d2&?c2&~?d1))
    
    (elm (n cigarette) (v PallMall) (h ?cig2&~?cig1))   
    (elm (n pet) (v bird) (h ?p2&?cig2&~?p1))

    (elm (n color) (v yellow) (h ?c4&~?c1&~?c2&~?c3&~?c5))
    (elm (n cigarette) (v Dunhill) (h ?cig3&?c4&~?cig1&~?cig2))
    
    (elm (n drink) (v milk) (h ?d3&3&~?d1&~?d2))
    
    (elm (n cigarette) (v Blend) (h ?cig4&~?cig1&~?cig2))
    (elm (n pet) (v cat) (h ?p3&~?p1&~?p2))
    (elm (n drink) (v water) (h ?d5&~?d1&~?d2&~?d3))
    (test(or(eq ?cig4 (+ 1 ?p3))
            (eq ?cig4 (- ?p3 1))
          ))
    (test(or(eq ?cig4 (+ 1 ?d5))
            (eq ?cig4 (- ?d5 1))
          ))
 
    (elm (n cigarette) (v Dunhill) (h ?cig3&~?cig1&~?cig2&~?cig4))
    (elm (n pet) (v horse) (h ?p4&~?p1&~?p2&~?p3))
    (test(or(eq ?cig3 (+ 1 ?p4))
            (eq ?cig3 (- ?p4 1))
          ))
    
     (elm (n cigarette) (v BlueMaster) (h ?cig5&~?cig1&~?cig2&~?cig3&~?cig4))
     (elm (n drink) (v beer) (h ?d4&?cig5&~?d1&~?d2&~?d3&~?d5))
     
     (elm (n pet) (v fish) (h ?p5&~?p4&~?p1&~?p2&~?p3))

   =>
   (assert(result color red ?c1)
          (result color green ?c2)
          (result color white ?c3)
          (result color yellow ?c4)
          (result color blue ?c5)
          
          (result pet dog ?p1)
          (result pet cat ?p3)
          (result pet bird ?p2)       
          (result pet horse ?p4)
          (result pet fish ?p5)

          (result cigarette BlueMaster ?cig5)
          (result cigarette Prince ?cig1)
          (result cigarette Blend ?cig4)
          (result cigarette Dunhill ?cig3)
          (result cigarette PallMall ?cig2)

(result drink beer ?d4)
(result drink water ?d5)
(result drink milk ?d3)
(result drink coffee ?d2)
(result drink tea ?d1)


(result nationality English ?n1)
(result nationality Swedish ?n2)
(result nationality Dane ?n3)
(result nationality German ?n4)
(result nationality Norwegian ?n5)
))

(defrule generate3
   ?f1 <- (result drink  ?e1  ?num)
   ?f2 <- (result pet  ?e2 ?num)
   ?f3 <- (result color  ?e3 ?num)
   ?f4 <- (result cigarette  ?e4 ?num)
   ?f5 <- (result nationality  ?e5 ?num)
   
   =>
    (retract ?f1 ?f2 ?f3 ?f4 ?f5)
   (assert (man(nationality ?e5)(cigarette ?e4)(pet ?e2)(color ?e3)(drink ?e1)(location ?num))))
  