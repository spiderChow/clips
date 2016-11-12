(deftemplate man (slot name) (slot car) (slot mile))

(defrule generate1
   =>
   (assert (name George)
           (name Jimmy)
           (name Tito)
           (name Doc)
           (car Ford)
           (car Chevrolet)
           (car Dodge)
           (car Toyota)
           (mile 30)
           (mile 25)
           (mile 20)
           (mile 15)    
   )
)

(defrule generate2
   (name ?n)
   (car ?c)
   (mile ?m)
   =>
   (assert (nm ?n ?m))
   (assert (cm ?c ?m) )         
   
)

(defrule rule
   (nm George ?m1)
   (nm Jimmy ?m2)
   (nm Tito ?m3)
   (nm Doc ?m4)
   (test (and (neq ?m1 ?m2)(neq ?m1 ?m3)(neq ?m1 ?m4)(neq ?m3 ?m2)(neq ?m2 ?m4)(neq ?m3 ?m4)))

   (cm Ford ?m5)
   (cm Chevrolet ?m6)
   (cm Dodge ?m7)
   (cm Toyota ?m8) 
   (test (and (neq ?m5 ?m6)(neq ?m5 ?m7)(neq ?m5 ?m8)(neq ?m6 ?m7)(neq ?m6 ?m8)(neq ?m7 ?m8)))

   (test(or(and(> ?m3 20)(= ?m2 20)(> ?m1 ?m2))
           (and(< ?m3 25)(neq ?m2 20)(<= ?m1 ?m2))
         )
    )
  
   (test(or(and(> ?m2 20)(neq ?m4 ?m8)(> ?m3 ?m7))
           (and(> ?m2 20)(eq ?m4 ?m8)(< ?m3 ?m7))
         )
    )

   (test(or(and(> ?m1 20)(eq ?m5 30)(neq ?m6 20))
           (and(< ?m1 25)(neq ?m5 30)(= ?m6 20))
         )
    )
   
   (test(or(and(> ?m4 20)(= ?m4 20))
           (and(< ?m4 25)(neq ?m4 20))
         )
    )
=>

   (assert (nmA George ?m1)(nmA Jimmy ?m2)(nmA Tito ?m3)(nmA Doc ?m4)
           (cnA Ford ?m5)(cnA Chevrolet ?m6)(cnA Dodge ?m7)(cnA Toyota ?m8) 
   )
   (assert (answer))
)

(defrule generateSolution
   (answer)
   ?f1<-(nmA ?n ?m1)
   ?f2<-(cnA ?c ?m2&?m1) 
   =>
   (retract ?f1 ?f2)
   (printout t ?n " " ?c " " ?m1 crlf)        
   
)