-- 7. Higher-order functions

-- 7.1 Basic concepts
-- Higher-order functions := functions that take **functions as arguments**
-- NOTE: Formally, it can also pertain to functions **that return fuctions**
--       but we already have _currying_ for this.
-- NOTE: (a -> b) is a function type, i.e. something that takes in an input of type a
--       and returns an output of type b. In the following type definition, (a -> a)
--       signifies that one of the inputs is a function.
twice :: (a -> a) -> a -> a
twice f x = f (f x)

-- 7.2 Processing lists
-- `map`
map_ :: (a -> b) -> [a] -> [b]
map_ f xs = [f x | x <- xs]

-- Recursively (useful for exploring properties later), 
mapr :: (a -> b) -> [a] -> [b]
mapr f []       = []
mapr f (x:xs)   = f x : map f xs

-- `filter`
-- NOTE:
-- 1.  Function type should be something that returns Bool
-- 2.  Output is a list of the same type, since we're just returning a subset
filter_ :: (a -> Bool) -> [a] -> [a]
filter_ f xs = [x | x <- xs, f x]

-- Again, recursively,
filterr :: (a -> Bool) -> [a] -> [a]
filterr f []                        = []
filterr f (x:xs) | f x              = x : filterr f xs
                 | otherwise        = filterr f xs

-- A few more higher-order functions
-- > all even [2,4,6,8]
-- True
-- > any odd [2,4,6,8]
-- False
-- > takeWhile even [2,4,6,7,8]
-- [2,4,6]              # ends at 6, since the next element is odd
-- > dropWhile odd [1,3,5,6,7]
-- [6,7]                # starts at 6, since the next element is even

-- 7.3 The `foldr` function
-- The following is a common recursion pattern on lists:
-- f []         = v
-- f (x:xs)     = x # f xs, where '#' is an operator
-- e.g.
-- sum []       = 0
-- sum (x:xs)   = x + sum xs
-- Using `foldr`, this can be more succinctly written as
-- sum :: Num a => [a] -> a
-- sum = foldr (+) 0
-- NOTE: For the `foldr` function, the operator `#` is assumed to associate to the right

-- 7.4 The `foldl` function
-- This is the analog of `foldr` for the following recursion pattern:
-- NOTE: Notice the use of the first argument as an **accumulator**
-- f v []       = v
-- f v (x:xs)   = f (v # x) xs
-- NOTE: For the `foldl` function, the operator `#` is assumed to associate to the left.
-- For associative operators, i.e. left and right associative, the choice should be based
-- on efficiency considerations.

-- 7.5 The composition operator

-- 7.6 Binary string transmitter
-- 7.6.1 Binary numbers
-- 7.6.2 Base conversion
-- 7.6.3 Transmission

-- 7.7 Voting algorithms
-- 7.7.1 First past the post
-- 7.7.2 Alternative vote

-- Exercises
-- 1.
-- 2.
-- 3.


main = do
    print (twice (*2) 4)
    print "Exercises"