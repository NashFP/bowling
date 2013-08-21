// Minmalist code-golf version of bowling scoring problem.
// It pattern matches a tuple of the current frame along
// with the flattened list of frames (rolls). It has to match
// both values because the follow-up rolls to a spare or strike
// may or may not be in the same frame due to those extra bonus
// rolls in the 10th frame. That's also the reason why the frame
// patterns for strikes and spares end in wildcards.
let rec score frames =
    if frames = [] then 0 else
    match frames.Head, frames |> List.collect id with
    | 10::_, _::b::c::_ -> 10 + b + c                // Strike + 2 rolls
    | 10::_, _::b::_ -> 10 + b                       // Strike + 1 roll
    | a::b::_, _::_::c::_ when a + b = 10 -> 10 + c  // Spare + 1 roll
    | x, _ -> x |> List.sum                          // Other
    |> (+) (score frames.Tail)

// Print some actual versus expected tuples to test my scoring function
[
    6, score [[5;0];[1]];
    10, score [[10]];
    12, score [[10];[1]];
    14, score [[10];[1;1]];
    10, score [[5;5]];
    20, score [[5;5];[5]];
    25, score [[5;5];[5;5]];
    0, score [[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0]];
    20, score [[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1]];
    110, score [[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10;10]];
    300, score [[10];[10];[10];[10];[10];[10];[10];[10];[10];[10;10;10]];
]
|> Seq.iter (printfn "%A")
