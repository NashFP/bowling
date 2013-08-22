Code.require_file "test_helper.exs", __DIR__

defmodule :'Simple Tests' do
	use ExUnit.Case
	
	test "given no frames, score should be zero" do
		score=Bowling.score([])
		assert score==0
	end

	test "given a single frame with one roll for 1 pin, score should be 1" do
		score=Bowling.score([1])
		assert score==1
	end

	test "given a single frame with two rolls 1 and 2, score should be 3" do
		score=Bowling.score([[1,2]])
		assert score==3
	end

	test "given one pin is knocked down per roll, score should be 20" do
		score=Bowling.score([[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]])
		assert score==20
	end
end


defmodule :'Spare Tests' do
	use ExUnit.Case

	test "given a spare followed by a single pin, score should be 12" do
		score=Bowling.score([[1,"/"],[1]])
		assert score==12
	end

	test "given two spares followed by a single pin, score should be 23" do
		score=Bowling.score([[1,"/"],[1,"/"],[1]])
		assert score==23
	end

	test "given a strike followed by a spare, score should be 30" do
		score=Bowling.score(["X",[1,"/"]])
		assert score==30
	end

	test "given nine strikes and spare on last frame with roll remaining, score should be 269" do
		score=Bowling.score(["X","X","X","X","X","X","X","X","X",[9,"/"]])
		assert score==269
	end

	test "given nine strikes and spare on last frame followed by a single pin, score should be 270" do
		score=Bowling.score(["X","X","X","X","X","X","X","X","X",[9,"/",1]])
		assert score==270
	end

	test "given nine strikes and spare on last frame followed by a strike, score should be 279" do
		score=Bowling.score(["X","X","X","X","X","X","X","X","X",[9,"/","X"]])
		assert score==279
	end
end


defmodule :'Strike Tests' do
	use ExUnit.Case

	test "given a strike, score should be 10" do
		score=Bowling.score(["X"])
		assert score==10
	end

	test "given two strikes, score should be 30" do
		score=Bowling.score(["X","X"])
		assert score==30
	end

	test "given three strikes, score should be 60" do
		score=Bowling.score(["X","X","X"])
		assert score==60
	end

	test "given twelve strikes, score should be 300" do
		score=Bowling.score(["X","X","X","X","X","X","X","X","X",["X","X","X"]])
		assert score==300
	end

	test "given eleven strikes and missing last pin, score should be 299" do
		score=Bowling.score(["X","X","X","X","X","X","X","X","X",["X","X",9]])
		assert score==299
	end
end
