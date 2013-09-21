// I wanted to see if I could further condense my solution to fit into a 140 character tweet.
// Here is the result (132 characters):

let rec s f=f|>function[]->0|h::t as l->(List.collect id l|>function|a::b::c::_ when a+b>=10->a+b+c|10::b::_->10+b|_->Seq.sum h)+s t

// Here's what it looks like with formatting:
//
// let rec s f =
//     f |> function
//     [] -> 0
//     | h::t as l ->
//       (List.collect id l |> function
//        | a::b::c::_ when a + b >= 10 -> a + b + c     // Strike + 2 rolls OR Spare + 1 roll!
//        | 10::b::_-> 10+b                              // Strike + 1 roll
//        | _-> Seq.sum h)                               // Other
//        + s t

// Run our tests
#load "bowling_test.fsx"
open bowling_test
test s
