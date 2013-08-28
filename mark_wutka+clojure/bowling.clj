(ns bowling)

(defn bowling [[scores-first & scores-rest]]
  (if (coll? scores-first)
    (+ 
     (let [s (apply + scores-first)] 
         (if (< s 10) s
             (apply + s 
                    (take (- 3 (count scores-first)) (flatten scores-rest)))))
     (bowling scores-rest))
    0))

;; Tweetable version of the above
(defn b [[sf & sr]] (if (coll? sf) (+ (let [s (apply + sf)] (if (< s 10) s (apply + s (take (- 3 (count sf)) (flatten sr))))) (b sr)) 0))

(defn test-bowling [b-func]
  (assert (= 300 (b-func [[10] [10] [10] [10] [10] [10] [10] [10] [10] [10 10 10]])))
  (assert (= 0 (b-func (repeat 10 [0 0]))))
  (assert (= 1 (b-func [[1]])))
  (assert (= 5 (b-func [[2 3]])))
  (assert (= 10 (b-func [[10]])))
  (assert (= 10 (b-func [[6 4]])))
  (assert (= 30 (b-func [[10] [10]])))
  (assert (= 60 (b-func [[10] [10] [10]])))
  (assert (= 38 (b-func [[10] [7 3] [3 2]])))
  (assert (= 96 (b-func [[7 3] [6 4] [10] [10] [10]])))
  (assert (= 299 (b-func [[10] [10] [10] [10] [10] [10] [10] [10] [10] [10 10 9]]))))

(defn run-tests []
  (test-bowling bowling)
  (test-bowling b))