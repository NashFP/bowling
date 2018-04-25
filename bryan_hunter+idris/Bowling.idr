||| Bowling homework from Idris School.
||| > "Is this your homework, Larry?"
|||
||| How Bryan plays when the bumpers are down
||| ```idris example
||| score [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
||| ```
|||
||| How Bryan imagines he will play, but never does
||| ```idris example
||| score [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
||| ```
|||
||| A complex example from http://slocums.homestead.com/gamescore.html
||| ```idris example
||| score [10, 7, 3, 9, 0, 10, 0, 8, 8, 2, 0, 6, 10, 10, 10, 8, 1]
||| ```
||| Scoring an incomplete game from http://slocums.homestead.com/gamescore.html
||| ```idris example
||| score [10, 7, 3, 9, 0]
||| ```

score : List Int -> Int
score [] = 0
score [a] = a
score (a :: b :: []) = a + b
score (10 :: b :: c :: tail) = 10 + b + c + score (b :: c :: tail)
score (a :: b :: c :: tail) with (a + b)
  | 10 = a + b + c + score (c :: tail)
  | _  = a + b + score (c :: tail)
