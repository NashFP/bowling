-module(bowling_tests).
-include_lib("eunit/include/eunit.hrl").

score_test() ->
  Strike = <<"X">>,
  Spare  = <<"/">>,
  IncompleteMsg = "Don't give up, keep playing!",
  SkunkyTownMsg = "Skunky town...",
  CompletedMsg  = "Game over",
  PerfectGameMsg = "Perfect game!",

  %% Empty list
  ?assert(bowling:score([]) =:= {incomplete, 0, IncompleteMsg}),
  ?assert(bowling:score([[]]) =:= {incomplete, 0, IncompleteMsg}),

  %% Single bowls
  ?assert(bowling:score([[0]]) =:= {incomplete, 0, IncompleteMsg}),
  ?assert(bowling:score([[1]]) =:= {incomplete, 1, IncompleteMsg}),
  ?assert(bowling:score([[7]]) =:= {incomplete, 7, IncompleteMsg}),

  %% Single frames without strikes or spares
  ?assert(bowling:score([[2,4]]) =:= {incomplete, 6, IncompleteMsg}),
  ?assert(bowling:score([[3,6]]) =:= {incomplete, 9, IncompleteMsg}),
  ?assert(bowling:score([[0,0]]) =:= {incomplete, 0, IncompleteMsg}),
  ?assert(bowling:score([[7,0]]) =:= {incomplete, 7, IncompleteMsg}),
  ?assert(bowling:score([[0,2]]) =:= {incomplete, 2, IncompleteMsg}),

  %% Single frames with spares or strikes
  ?assert(bowling:score([[0,Spare]]) =:= {incomplete, 10, IncompleteMsg}),
  ?assert(bowling:score([[9,Spare]]) =:= {incomplete, 10, IncompleteMsg}),
  ?assert(bowling:score([[Strike]]) =:= {incomplete, 10, IncompleteMsg}),

  %% Multiple frames without strikes or spares
  ?assert(bowling:score([[0,0], [0,0], [0,0]]) =:= {incomplete, 0, IncompleteMsg}),
  ?assert(bowling:score([[0,1], [2,3], [4,5]]) =:= {incomplete, 15, IncompleteMsg}),
  ?assert(bowling:score([[4,3], [7,1], [0,9]]) =:= {incomplete, 24, IncompleteMsg}),

  %% Multiple frames with spares
  ?assert(bowling:score([[0,Spare], [3,2]]) =:= {incomplete, 18, IncompleteMsg}),
  ?assert(bowling:score([[9,Spare], [5,4]]) =:= {incomplete, 24, IncompleteMsg}),
  ?assert(bowling:score([[2,Spare], [0,9]]) =:= {incomplete, 19, IncompleteMsg}),
  ?assert(bowling:score([[0,Spare], [9,Spare]]) =:= {incomplete, 29, IncompleteMsg}),

  %% Multiple frames with strikes
  ?assert(bowling:score([[Strike], [0,0], [0,0]]) =:= {incomplete, 10, IncompleteMsg}),
  ?assert(bowling:score([[Strike], [2,7], [0,0]]) =:= {incomplete, 28, IncompleteMsg}),
  ?assert(bowling:score([[Strike], [2,7], [Strike], [0,0]]) =:= {incomplete, 38, IncompleteMsg}),
  ?assert(bowling:score([[Strike], [Strike]]) =:= {incomplete, 20, IncompleteMsg}),

  %% Tenth frame with strikes and spares
  ?assert(bowling:score([[Strike,Strike,Strike]]) =:= {incomplete, 30, IncompleteMsg}),
  ?assert(bowling:score([[Strike,5,Spare]]) =:= {incomplete, 20, IncompleteMsg}),
  ?assert(bowling:score([[3,Spare,9]]) =:= {incomplete, 19, IncompleteMsg}),
  ?assert(bowling:score([[3,Spare,Strike]]) =:= {incomplete, 20, IncompleteMsg}),

  %% Multiple frames with strikes and spares
  ?assert(bowling:score([[Strike], [0,Spare,Strike]]) =:= {incomplete, 40, IncompleteMsg}),
  ?assert(bowling:score([[Strike], [Strike,7,Spare]]) =:= {incomplete, 47, IncompleteMsg}),
  ?assert(bowling:score([[0,Spare], [Strike], [0,Spare,Strike]]) =:= {incomplete, 60, IncompleteMsg}),
  ?assert(bowling:score([[Strike], [9,0], [3,Spare], [9,0], [Strike,0,5]]) =:= {incomplete, 71, IncompleteMsg}),

  %% Complete games
  ?assert(
    bowling:score([
        [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0], [0,0]
        ]) =:= {complete, 0, SkunkyTownMsg}
    ),
  ?assert(
    bowling:score([
        [Strike], [Strike], [Strike], [Strike], [Strike], [Strike], [Strike], [Strike], [Strike], [Strike,Strike,Strike]
        ]) =:= {complete, 300, PerfectGameMsg}
    ),
  ?assert(
    bowling:score([
        [0,1], [2,3], [4,5], [0,1], [2,3], [4,5], [0,1], [2,3], [4,5], [0,1]
        ]) =:= {complete, 46, CompletedMsg}
    ),
  ?assert(
    bowling:score([
        [Strike], [Strike], [8,Spare], [Strike], [9,Spare], [8,Spare], [Strike], [Strike], [9,Spare], [Strike,Strike,Strike]
        ]) =:= {complete, 225, CompletedMsg}
    ),
  ?assert(
    bowling:score([
        [9,Spare], [8,Spare], [9,Spare], [9,0], [7,Spare], [8,Spare], [9,Spare], [7,0], [6,3], [9,Spare,9]
        ]) =:= {complete, 154, CompletedMsg}
    ).
