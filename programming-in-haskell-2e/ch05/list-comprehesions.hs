import Data.Char

-- 5 List comprehensions

-- 5.1 Basic concepts
a = [x^2 | x <- [1..5]]

-- e.g. generate cartesian product of two sets
b = [(x, y) | x <- [1..3], y <- [4..5]]

-- e.g. concatenate a list of lists into a single list
concatt :: [[a]] -> [a]
concatt xss = [x | xs <- xss, x <- xs]
-- i.e. for a list of lists, xss,
--      for each list, xs, in xss,
--          for each element, x, in the current xs
--              put that element into the output

-- 5.2 Guards (for filtering values)
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

-- 5.3 The `zip` function
-- TL;DR similar to `zip` in other programming languages

-- 5.4 String comprehensions
-- TL;DR "abc" :: String is just the same as ['a', 'b', 'c'] :: [Char]

-- 5.5 The Caesar cipher
-- 5.5.1 Encoding and decoding
let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

shift :: Char -> Int -> Char
shift c n | isLower c = int2let ((let2int c + n) `mod` 26)
          | otherwise = c

encode ::  String -> Int -> String
encode s n = [shift c n | c <- s]


-- Exercises
-- 1. Using a list comprehension, give an expression that calculates the sum of squares
--    of the first 100 integers
sumsquares :: Int -> Int
sumsquares n = sum [x^2 | x <- [1..n]]

-- 2. Suppose that a coordinate grid o fsize m x n is given by the list of all pairs (x, y)
--    of integers s.t. 0 <= x <= m, and 0 <= y <= n. Using list comprehension, define
--    a function that returns a coordinate grid of a given size. For example:
--    > grid 1 2
--    [(0,0),(0,1),(0,2),(1,0),(1.1),(1,2)]
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(x, y) | x <- [0..m], y <- [0..n]]

-- 3. Using list comprehension and `grid` above, define a function that returns a coordinate
--    square of size n, excludin gthe diagonal from (0, 0) to (n, n). For example:
--    > square 2
--    [(0,1),(0,2),(1,0),(1.2),(2,0),(2,1)]
square :: Int -> [(Int, Int)]
square n = [(x, y) | (x, y) <- grid n n, x /= y]

-- 4. In a similar way to the function `length`, show how the library function `replicate`
--    that produces a list of identical element scan be defined using a list comprehension.
--    For example:
--    > replicate 3 True
--    [True,True,True]
replicatez :: Int -> a -> [a]
replicatez n a = [a | _ <- [1..n]]


main = do
    print a
    print b
    print (concatt [[1], [2, 3], [], [4..9]])
    print (factors 36)
    print (factors 71)

    print "Start Caesar cipher tests"
    print (let2int 'a')
    print (int2let 0)
    print (shift 'a' 3)
    print (shift 'z' 3)
    print (shift 'c' (-3))
    print (shift ' ' 3)
    print (encode "haskell is fun" 3)
    print (encode "kdvnhoo lv ixq" (-3))

    print "Exercises"
    print (sumsquares 100)
    print (grid 1 2)
    print (square 2)
    print (replicatez 3 True)