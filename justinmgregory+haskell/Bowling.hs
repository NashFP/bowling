module Bowling where

bowling :: [[Int]] -> Int
bowling [] = 0
bowling ([10]:[a]:b:t) = 10 + a + head b + bowling ([a]:b:t)
bowling ([10]:(a:b:r):t) = 10 + a + b + bowling ((a:b:r):t)
bowling (a:b:t)
	| sum a == 10 = 10 + head b + bowling (b:t)
	| otherwise   = sum a + bowling (b:t)
bowling [a] = sum a
