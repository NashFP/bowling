{-
  This technique takes advantage of the fact that foldr starts at the rightmost
  item in a list, so it scores the bowling frames from right-to-left. One thing
  that is harder is that in order to show a Strike or Spare message for the last
  frame, you have to know whether there was a message in one of the frames to
  the right. We start with a message of "~" and only set the current message if
  the previous message was "~".
-}

data GameStateType = GameState Int Int Int Int Bool String

-- Sets the current message only if the previous one was "~"
makeMessage : String -> String -> String
makeMessage oldm m =
    if oldm == "~" then
        m
    else
        oldm

-- Processes a frame
processFrame : List Int -> GameStateType -> GameStateType
-- Empty frame
processFrame [] (GameState r1 r2 f s c m) = GameState r1 r2 f s False (makeMessage m "")

-- Strike
processFrame [10] (GameState r1 r2 f s c m) =
    GameState 10 r1 (f+1) (s+10+r1+r2) (f==9) (makeMessage m "Strike")

-- Incomplete frame
processFrame [roll] (GameState r1 r2 f s c m) =
    GameState roll r1 f (s+roll) False (makeMessage m "")

-- Two roll frame, must check for spare here
processFrame [roll1,roll2] (GameState r1 r2 f s c m) =
    if roll1+roll2 == 10 then
        GameState roll1 roll2 (f+1) (s + 10 + r1) (f==9) (makeMessage m "Spare")
    else
        GameState roll1 roll2 (f+1) (s + roll1 + roll2) (f==9) (makeMessage m "")

-- Last frame in the game
processFrame [roll1,roll2,roll3] (GameState r1 r2 f s c m) =
    if roll1 == 10 then
        GameState roll1 roll2 (f+1) (s + 10 + roll2 + roll3) (f==9) (makeMessage m "Strike")
    else if roll1 + roll2 == 10 then
        GameState roll1 roll2 (f+1) (s + 10 + roll3) (f==9) (makeMessage m "Spare")
    else
        GameState roll1 roll2 (f+1) (s + roll1 + roll2) (f==9) (makeMessage m "")
processFrame _ (GameState r1 r2 f s c m) =
    GameState r1 r2 f s c (makeMessage m "Invalid frame")

-- Pull the desired results from the game state, replace the "~" message with "" if
-- it is still there
extractResult : GameStateType -> (Int, Bool, String)
extractResult (GameState _ _ _ s c m) = 
    if s == 300 && c then
        (s,c,"Perfect Game")
    else if c then
        (s,c,"Game Over")
    else if m == "~" then
        (s,c,"")
    else
        (s,c,m)

scoreGame : List (List Int) -> (Int, Bool, String)
scoreGame frames = extractResult (foldr processFrame initGame frames)
    where
        initGame = GameState 0 0 0 0 False "~"
