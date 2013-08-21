// Minimalist code-golf version of bowling scoring problem.
// It pattern matches a flattened list of the frames (rolls).
// The flattening approach is helpful because the follow-up rolls
// to a spare or strike may or may not be in the same frame due 
// to those extra bonus rolls at the end of the 10th frame.

let rec score frames =
    if frames = [] then 0 else
    match frames |> List.collect id with
    | 10::b::c::_ -> 10 + b + c             // Strike + 2 rolls
    | 10::b::_ -> 10 + b                    // Strike + 1 roll
    | a::b::c::_ when a + b = 10 -> 10 + c  // Spare + 1 roll
    | _ -> frames.Head |> List.sum          // Other
    |> (+) (score frames.Tail)

// Print some actual versus expected tuples to test my scoring function
[
    0,   []
    0,   [[]]
    6,   [[5;0];[1]]
    10,  [[10]]
    12,  [[10];[1]]
    14,  [[10];[1;1]]
    10,  [[5;5]]
    20,  [[5;5];[5]]
    25,  [[5;5];[5;5]]
    0,   [[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0];[0;0]]
    20,  [[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1];[1;1]]
    110, [[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10];[0;10;10]]
    300, [[10];[10];[10];[10];[10];[10];[10];[10];[10];[10;10;10]]
]
|> Seq.map (fun (x, y) -> x, score y)
|> Seq.iter (printfn "%A")
