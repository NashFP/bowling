(ns bowling)
(use 'clojure.test)

(defn messages [score]
    (condp = score
      300 "That's how you roll!"
      150 "Half-way there"
       0 "We can put the bumpers up."
          "Game Over")
 )


(defn strike [x]
  (if (and (= (count x) 1) (= (first x) 10))      
    true
      false
   )
  )    

(defn spare [x]
  (if (> (count x) 1)
    (if (= (+ (first x) (second x)) 10)
      true
     )
  )
)    

;; Rules are a little different for tenth frame
;; Perhaps if the dataset was 11 frames, this 
;; might be handled differently 
(defn tenthframeok [x]
  (if (or (= (count x) 2) (= (count x) 3))
    (if (= (first x) 10)
      (if (= (count (rest x)) 2)
          true
       )
       true
    )
    false
  )
  
 )

(defn framesok [x]
  (if (not (empty? x))
    (if (= (count x) 2)
      (if (< (+ (first x) (last x)) 11)
              true
    )
  )))


(defn gamecomplete [x]
  (if (and (and (= (count x) 10 ) (tenthframeok (last x))) (= 2 2))
    "complete"
      "incomplete"
   )
   
 )


(defn frametotal [x]
  (if (and (not (= nil (first x))) (not (empty? x)))
     (+ (first x) (frametotal (rest x)))        
         0
  )

)
    
(defn pintotal [x]
    (if (not (empty? x))
      (if (strike (first x))
            ;; two strikes???? wow!
          (if (strike (first (rest x)))
              (+ (frametotal (first x)) 
                 (frametotal [(first (first (rest x)))] ) 
                 (frametotal [(first (first (rest (rest x))))]) 
                 (pintotal (rest x)))
                      ;; just one strike
                      (+ (frametotal (first x)) (frametotal [(first (first (rest x)))] ) (frametotal [(second (first (rest x)))] ) (pintotal (rest x)))
            )
        
          (if (spare (first x))
              (+ (frametotal (first x)) (frametotal [(first (first (rest x)))] ) (pintotal (rest x)))
                    ;; you didn't close the frame
                    (+ (frametotal (first x)) (pintotal (rest x)) )
            
            )
            
           )
          0
     )
 )  

(deftest perfectscore (is (= (pintotal [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]) 300)))
(deftest gutters (is (= (pintotal [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]) 0)))


(defn score [frames] 
   [(gamecomplete frames),(pintotal frames),(messages(pintotal frames))]
 )

(score [])
(score [[5]])
(score [[10]])
(score [[7, 3]])
(score [[10] [3, 6]])
(score [[7, 3] [4, 2]])
(score [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]])
(score [[10] [3 0] [3 0]])
(score [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]])
(score [[10],[10],[3,3]])
          
(run-tests 'bowling)