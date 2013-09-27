import Test.HUnit
import Bowling

-- Run with: "runTestTT tests"

tests = TestList [TestLabel "Score is zero if no frames bowled" $
                  TestCase $ assertEqual ""  0 $ bowling [],                 
                  TestLabel "Score for a single bowl is just that value" $
                  TestCase $ assertEqual ""  7 $ bowling [[7]],
                  TestLabel "Score for a two bowls a frame is the sum" $
                  TestCase $ assertEqual ""  7 $ bowling [[3,4]],
                  TestLabel "Score for a final strike is just 10" $
                  TestCase $ assertEqual "" 10 $ bowling [[10]],
                  TestLabel "Score for a strike followed by two bowls in the next frame" $
                  TestCase $ assertEqual "" 24 $ bowling [[10],[3,4]],
                  TestLabel "Score for a strike followed by a single bowl in the next frame" $
                  TestCase $ assertEqual "" 18 $ bowling [[10],[4]],
                  TestLabel "Score for a double strike is 30" $
                  TestCase $ assertEqual "" 30 $ bowling [[10],[10]],
                  TestLabel "Score for a double strike plus a single bowl" $
                  TestCase $ assertEqual "" 42 $ bowling [[10],[10],[4]],
                  TestLabel "Score for a double strike plus two bowls" $
                  TestCase $ assertEqual "" 47 $ bowling [[10],[10],[3,4]],
                  TestLabel "Score for a triple strike" $
                  TestCase $ assertEqual "" 60 $ bowling [[10],[10],[10]],
                  TestLabel "Score for a final spare is just 10" $
                  TestCase $ assertEqual "" 10 $ bowling [[0,10]],
                  TestLabel "Score for a spare followed by a single bowl" $
                  TestCase $ assertEqual "" 16 $ bowling [[5,5],[3]],
                  TestLabel "Score for a spare followed by two bowls" $
                  TestCase $ assertEqual "" 20 $ bowling [[5,5],[3,4]],
                  TestLabel "Score for strike and single bowl in final frame" $
                  TestCase $ assertEqual "" 14 $ bowling [[10,4]],
                  TestLabel "Score for strike and double bowl in final frame" $
                  TestCase $ assertEqual "" 17 $ bowling [[10,3,4]],
                  TestLabel "Score for double strike in final frame" $
                  TestCase $ assertEqual "" 20 $ bowling [[10,10]],
                  TestLabel "Score for triple strike in final frame" $
                  TestCase $ assertEqual "" 30 $ bowling [[10,10,10]],
                  TestLabel "Score for spare and extra bowl in final frame" $
                  TestCase $ assertEqual "" 15 $ bowling [[7,3,5]],
                  TestLabel "Perfect game" $
                  TestCase $ assertEqual "" 300 $ bowling [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
                 ]
