# Idris Solution

Since scoring requires the ability to look ahead up to two rolls,
this solution scores starting at the rightmost frame and then just
keeps track of the previous rolls it saw. It uses the foldr function
which takes function, an initial state, and a list, and applies the
function to a list element and an initial state. The function then
returns the new state.

In this case, the state is defined as a GameState containing
Roll1, Roll2, FrameCount, Score, IsComplete, Message
in that order. So when scoring any frame, is the roll that would come
immediately after the current frame, and Roll2 is the one that would
come after Roll1.

Showing a message can be tricky, because if the last frame in the game
is a strike, that's the first frame processed by foldr, so we have to
remember the strike message while processing the rest of the frames. In
this case, we start with a dummy message ("~") and only replace it with
a message if it is still "~".
