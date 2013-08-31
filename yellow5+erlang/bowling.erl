-module(bowling).
-export([score/1, tweetable_score/1, tweetable_ermahgerd_score/1]).

score(Frames) ->
  Score = score(lists:flatten(Frames), 0),
  FrameCount = length(Frames),
  case {FrameCount, Score} of
    {10, 0}   -> {complete, 0, "Skunky town..."};
    {10, 300} -> {complete, 300, "Perfect game!"};
    {10, _}   -> {complete, Score, "Game over."};
    _         -> {incomplete, Score, "Don't give up, keep playing!"}
  end.

tweetable_score(Frames) ->
  {Status, Score, Msg} = score(Frames),
  case Status of
    complete   ->
      lists:flatten(io_lib:format("~s Bowling score: ~w", [Msg, Score]));
    incomplete ->
      lists:flatten(io_lib:format("~s Incomplete bowling score: ~w", [Msg, Score]))
  end.

tweetable_ermahgerd_score(Frames) ->
  {Status, Score, _} = score(Frames),
  case {Status,Score} of
    {complete, 0} ->
      "Ermahgerd, skernker tern... Berlin scer: 0";
    {complete, 300} ->
      "Ermahgerd, perferct germ! Berlin scer: 300";
    {complete, _} ->
      lists:flatten(io_lib:format("Ermahgerd, germ erver. Berlin scer: ~w", [Score]));
    {incomplete, _} ->
      lists:flatten(io_lib:format("Ermahgerd, dernt gerv erp, kerp plin! Erncermplert berlin scer: ~w", [Score]))
  end.

score([], Score) ->
  Score;
score([Strike], _) when Strike =:= <<"X">> ->
  10;
score([Bowl1,Bowl2], Score) ->
  case {Bowl1,Bowl2} of
    {<<"X">>,<<"X">>} -> Score+20;
    {_,<<"/">>}       -> Score+10;
    _                 -> Score+Bowl1+Bowl2
  end;
score([Bowl1,Bowl2,Bowl3], Score) ->
  Strike = <<"X">>,
  Spare  = <<"/">>,
  case {Bowl1,Bowl2,Bowl3} of
    {Strike,Strike,Strike} -> Score+30;
    {Strike,_,Spare}       -> Score+20;
    {Strike,_,_}           -> Score+10+Bowl2+Bowl3;
    {_,Spare,Strike}       -> Score+20;
    {_,Spare,_}            -> Score+10+Bowl3;
    _                      -> Score+Bowl1+Bowl2+Bowl3
  end;
score([_,Spare,Bowl|Tail], Score) when Spare =:= <<"/">> ->
  NewTail = [Bowl]++Tail,
  case Bowl of
    <<"X">> -> score(NewTail, Score+20);
    _       -> score(NewTail, Score+10+Bowl)
  end;
score([Strike,Bowl1,Bowl2|Tail], Score) when Strike =:= <<"X">> ->
  NewTail = [Bowl1,Bowl2]++Tail,
  case {Strike,Bowl1,Bowl2} of
    {Strike,Strike,Strike} -> score(NewTail, Score+30);
    {Strike,Strike,_}      -> score(NewTail, Score+20+Bowl2);
    {Strike,_,<<"/">>}     -> score(NewTail, Score+20);
    _                      -> score(NewTail, Score+10+Bowl1+Bowl2)
  end;
score([Bowl|Tail], Score) ->
  score(Tail, Score+Bowl).
