-module(main).
-compile(export_all).

inversion_count(StartSeq, TargetSeq) ->
  if StartSeq =:= TargetSeq -> io:format("Works!");
    true -> io:format("NAH~n")
  end.

do_work(StartSeq, TargetSeq, PID) ->
  io:format("PID: ~p, StartSeq: ~p, TargetSeq: ~p~n", [PID, StartSeq, TargetSeq]),
  inversion_count(StartSeq, TargetSeq),
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
