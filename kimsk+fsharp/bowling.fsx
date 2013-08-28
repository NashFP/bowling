let rec bowling (frames:List<List<int>>) =
    match frames with
    | [] -> 0        
    // [[]] or [[_]]
    | frame::rest when frame = [] || rest = [] 
        -> printfn "%d Last Frame" (List.sum frame); (List.sum frame)    
    // [_,_]:: spare
    | frame::rest when (frame.Length) = 2 && (List.sum frame) = 10 && rest <> []
        -> printfn "%d\t%d\tSpare" frame.[0] frame.[1]; 10 + rest.Head.[0] + bowling rest
    // bad frame
    | frame::rest when (frame.Length) = 2
        -> printfn "%d\t%d" frame.[0] frame.[1]; (List.sum frame) + bowling rest
    // [[_];[_]]
    | frame::rest when (frame.Length) = 1 && (List.sum frame) = 10 && (rest.Head.Length) = 1 && rest.Tail = []
        -> printfn "%d\t\tStrike %O" frame.[0] rest; 10 + rest.Head.[0] + bowling rest    
    | frame::rest when (frame.Length) = 1 && (List.sum frame) = 10 && (rest.Head.Length) = 1 && rest.Tail <> []
        -> printfn "%d\t\tStrike %O" frame.[0] rest; 10 + rest.Head.[0] + rest.Tail.Head.[0] + bowling rest
    | frame::rest when (frame.Length) = 1 && (List.sum frame) = 10 && (rest.Head.Length) = 2 
        -> printfn "%d\t\tStrike" frame.[0]; 10 + rest.Head.[0] + rest.Head.[1] + bowling rest
    | frame::rest when (frame.Length) = 1 && (rest.Head.Length) = 3 
        -> printfn "%d\t\tStrike" frame.[0]; 10 + rest.Head.[0] + rest.Head.[1] + bowling rest    
    | _ -> 0


// borrow tests from Luke's folder :-)
let test bowling =
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
        |> Seq.map (fun (x, y) -> x, bowling y)
        |> Seq.iter (printfn "%A")

test bowling