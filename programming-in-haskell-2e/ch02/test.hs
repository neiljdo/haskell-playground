double x = x + x
quadruple x = double (double x)

-- Factorial of a positive integer
factorial n = product [1..n]

-- Average of a list of numbers
average ns = sum ns `div` length ns

n = a `div` length xs
    where
        a  = 10
        xs = [1..5]


-- `last` as a function of other library functions
a = last [1..5]
-- is the same as
b = head (reverse [1..5])


-- `init` as a function of other library functions
c = init [1..7]
-- is the same as
d = reverse (tail (reverse [1..7]))
-- and also the same as
e = take (length [1..7] - 1) [1..7]

{-
$> c
[1,2,3,4,5,6]
$> d
[1,2,3,4,5,6]
$> e
[1,2,3,4,5,6]
-}