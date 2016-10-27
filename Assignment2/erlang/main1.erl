-module(main1).
-compile(export_all).

invert(StartSeq, _, _) when StartSeq == [] -> [300, []];
invert(_, TargetSeq, _) when TargetSeq == [] -> [400, []];
invert(StartSeq, TargetSeq, Characters) when hd(StartSeq) =:= TargetSeq ->
  io:format("JOIN ELEMENTS: ~p + ~p~n", [Characters, StartSeq]),
  [0, lists:append([Characters], tl(StartSeq))];
invert(StartSeq, TargetSeq, Characters) when hd(StartSeq) =/= TargetSeq ->
  io:format("COMBINING ~p + ~p~n", [Characters, hd(StartSeq)]),
  ReturnValue = invert(tl(StartSeq), TargetSeq, lists:append(Characters, hd(StartSeq))),
  [1 + lists:nth(1, ReturnValue), lists:append(Characters, lists:nth(2, ReturnValue))].

inversion_count(StartSeq, TargetSeq) when StartSeq == [] -> 0;
inversion_count(StartSeq, TargetSeq) when hd(StartSeq) =:= hd(TargetSeq) -> 0 + inversion_count(tl(StartSeq), tl(TargetSeq));
inversion_count(StartSeq, TargetSeq) when hd(StartSeq) =/= hd(TargetSeq) ->
  Values = invert(StartSeq, hd(TargetSeq), []),
  io:format("RETURN VALUES ~p, EXISTING START SEQUENCE ~p, NEW START SEQUENCE ~p~n", [Values, tl(StartSeq), [lists:nth(2, Values)]]),
  lists:nth(1, Values) + inversion_count(lists:nth(2, Values), tl(TargetSeq)).

do_work(StartSeq, TargetSeq, PID) ->
  io:format("PID: ~p, StartSeq: ~p, TargetSeq: ~p~n", [PID, StartSeq, TargetSeq]),
  Count = inversion_count(StartSeq, TargetSeq),
  io:format("Number of Inversions: ~p~n", [Count]),
  PID ! {ok, 4}.

wait_for_done() ->
  receive
    {ok, Result} -> io:fwrite("~B~n", [Result])
  end.

start() ->
  {ok, [StartSequence]} = io:fread("", "~s"),
  {ok, [TargetSequence]} = io:fread("", "~s"),
  spawn(main, do_work, [StartSequence, TargetSequence, self()]),
  wait_for_done().
