# Method from https://github.com/NashFP/bowling/blob/master/luketopia%2Bfsharp/bowling_golf.fsx
# Added additional cases because I wanted to use "X" and "/" notation for strike and spare.

defmodule Bowling do

	def score([]), do: 0
	def score(frames=[_head|tail]) do
		value=case List.flatten(frames) do
			["X",_,"/"|_]  -> 20
			["X",r1,r2|_]  -> 10 + val(r1) + val(r2)
			["X",roll]     -> 10 + val(roll)
			["X"]          -> 10
			[_,"/",roll|_] -> 10 + val(roll)
			[_,"/"]        -> 10
			[r1,r2|_]      -> r1 + r2
			[roll|_]       -> roll
		end
		value + score(tail)
	end

	defp val("X"), do: 10
	defp val(roll), do: roll

end