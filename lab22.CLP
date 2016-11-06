(deftemplate avh (slot a) (slot v) (slot h))

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
   (assert (value color red) 
           (value color green) 
           (value color white)
           (value color yellow)
           (value color blue)
           (value nationality English)
           (value nationality Swedish)
           (value nationality Dane) 
           (value nationality German)
           (value nationality Norwegian)
           (value pet dog)
           (value pet cat)
           (value pet fish)
           (value pet horse)
           (value pet bird)
           (value drink water)
           (value drink coffee)
           (value drink milk)
           (value drink beer)
           (value drink tea)
           (value cigarette BlueMaster)
           (value cigarette Prince)
           (value cigarette Blend)
           (value cigarette Dunhill)
           (value cigarette PallMall)) 
   )

(defrule generate2
   ?f <- (value ?s ?e)
   =>
   (retract ?f)
   (assert (avh (a ?s) (v ?e) (h 1))
           (avh (a ?s) (v ?e) (h 2))
           (avh (a ?s) (v ?e) (h 3))
           (avh (a ?s) (v ?e) (h 4))
           (avh (a ?s) (v ?e) (h 5))))

(defrule generate3
   ?f1 <- (avh (a drink) (v ?e1) (h ?num))
   ?f2 <- (avh (a color) (v ?e2) (h ?num))
   ?f3 <- (avh (a pet) (v ?e3) (h ?num))
   ?f4 <- (avh (a cigarette) (v ?e4) (h ?num))
   ?f5 <- (avh (a nationality) (v ?e5) (h ?num))
   
   =>
   (retract ?f1 ?f2 ?f3 ?f4 ?f5)
   (assert (man(nationality ?e5)(cigarette ?e4)(pet ?e3)(color ?e2)(drink ?e1)(location ?num))))


(defrule condition2 
   ?f1 <- (man(nationality English)(color ?c1&~red))
   ?f2 <- (man(nationality ?n1&~English)(color red))
  =>
  (retract ?f1 ?f2))

(defrule condition3
   ?f1 <- (man(nationality Swedish)(pet ?c1&~dog))
   ?f2 <- (man(nationality ?n1&~Swedish)(pet dog))
  =>
  (retract ?f1 ?f2))

(defrule condition4
   ?f1 <- (man(nationality Dane)(drink ?c1&~tea))
   ?f2 <- (man(nationality ?n1&~Dane)(drink tea))
  =>
  (retract ?f1 ?f2))


(defrule condition6
   ?f1 <- (man(color green)(drink ?c1&~coffee))
   ?f2 <- (man(color &c&~green)(drink coffee))
  =>
  (retract ?f1 ?f2))

(defrule condition7
   ?f1 <- (man(cigarette PallMall)(pet ?c1&~bird))
   ?f2 <- (man(cigarette &c&~PallMall)(pet bird))
  =>
  (retract ?f1 ?f2))

(defrule condition8
   ?f1 <- (man(cigarette Dunhill)(color ?c1&~yellow))
   ?f2 <- (man(cigarette &c&~Dunhill)(color yellow))
  =>
  (retract ?f1 ?f2))

(defrule condition9
   ?f1 <- (man(drink milk)(location ?c1&~3))
   ?f2 <- (man(drink &c&~milk)(location 3))
  =>
  (retract ?f1 ?f2))

(defrule condition10
   ?f1 <- (man(nationality Norwegian)(location ?c1&~1))
   ?f2 <- (man(nationality ?n1&~Norwegian)(location 1))
  =>
  (retract ?f1 ?f2))


(defrule condition13
   ?f1 <- (man(drink beer)(cigarette ?c1&~BlueMaster))
   ?f2 <- (man(drink &c&~beer)(cigarette BlueMaster))
  =>
  (retract ?f1 ?f2))

(defrule condition14
   ?f1 <- (man(nationality German)(cigarette ?c1&~Prince))
   ?f2 <- (man(nationality ?n1&~German)(cigarette Prince))
  =>
  (retract ?f1 ?f2))

(defrule conditionrest
   ?f1 <-  (man (nationality ?n1) (drink ?d1) (cigarette ?c1)
                (pet ?p1)(color green)(location ?l1))
   ?f2 <-  (man (nationality ?n2&~?n1) (drink ?d2&~?d1) (cigarette ?c2&~?c1)
                (pet ?p2&~?p1)(color white)(location (+ 1 ?l1)))
   ?f3 <-  (man (nationality ?n3) (drink ?d3) (cigarette Blend)
                (pet ?p3&~cat)(color ?color3)(location ?l3))
   ?f4 <-  (man (nationality ?n4&~?n3) (drink ?d4&~?d3) (cigarette ?c4&~Blend)
                (pet cat)(color ?color4&~?color3)(location (+ 1 ?l3)|(- ?l3 1)))

   ?f5 <-  (man (nationality ?n5) (drink ?d5) (cigarette Dunhill)
                (pet ?p5&~horse)(color ?color5)(location ?l5))
   ?f6 <-  (man (nationality ?n6&~?n5) (drink ?d6&~?d5) (cigarette ?c6&~Dunhill)
                (pet horse)(color ?color6&~?color5)(location (+ 1 ?l5)|(- ?l5 1)))

   ?f7 <-  (man (nationality Norwegian) (drink ?d7) (cigarette ?c7)
                (pet ?p7)(color ?color7&~blue)(location ?l7))
   ?f8 <-  (man (nationality ?n8&~Norwegian) (drink ?d8&~?d7) (cigarette ?c8&~?c7)
                (pet ?p8&~?p7)(color blue)(location (+ 1 ?l7)|(- ?l7 1)))

   ?f9 <-  (man (nationality ?n9) (drink ?d9&~water) (cigarette Blend)
                (pet ?p9)(color ?color9)(location ?l9))
   ?f10 <-  (man (nationality ?n10&~?n9) (drink water) (cigarette ?c10&~Blend)
                (pet ?p10&~?p9)(color ?color10&~?color9)(location (+ 1 ?l9)|(- ?l9 1)))



   
  =>
  (retract ?f1 ?f2))
