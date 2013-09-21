// Minimalist code-golf version of bowling scoring problem.
// It pattern matches a flattened list of the frames (rolls).
// The flattening approach is helpful because the follow-up rolls
// to a spare or strike may or may not be in the same frame due 
// to those extra bonus rolls at the end of the 10th frame.
let rec score frames =
    if frames = [] then 0 else
    match List.collect id frames with
    | 10::b::c::_ -> 10 + b + c             // Strike + 2 rolls
    | 10::b::_ -> 10 + b                    // Strike + 1 roll
    | a::b::c::_ when a + b = 10 -> 10 + c  // Spare + 1 roll
    | _ -> List.sum frames.Head             // Other
    + score frames.Tail

// Load and run our tests
#load "bowling_test.fsx"
open bowling_test 
test score
