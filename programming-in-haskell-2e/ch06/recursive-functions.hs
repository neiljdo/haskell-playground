-- 6. Recursive functions

-- 6.1 Basic concepts
facR :: Int -> Int
facR 0 = 1                          -- Base case
facR n = n * facR (n - 1)           -- Recursive case
{-
Why?
*   Correctness proof via induction
*   Some functions have simple and natural defns using recursion
-}

-- 6.2 Recursion on lists
productz :: Num a => [a] -> a
productz []      = 1                    -- Base case
productz (x:xs)  = x * productz xs      -- Recursive case

reversez :: [a] -> [a]
reversez []         = []
reversez (x:xs)     = reversez xs ++ [x]

-- e.g. Given a sorted a list, insert a new element while keeping the order
insert :: Ord a => a -> [a] -> [a]
insert x []                     = [x]
insert x (y:ys) | x <= y        = x : y : ys
                | otherwise     = y : insert x ys

-- e.g Insertion sort
insertionSort :: Ord a => [a] -> [a]
insertionSort []                = []
insertionSort (x:xs)            = insert x (insertionSort xs)

-- 6.3 Multiple arguments
-- TL;DR Just need to (possibly) handle more base cases since we have more arguments

-- 6.4 Multiple recursion
-- TL;DR Function is applied more than once in its definition
-- e.g. Fibonacci number
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)       -- Function `fib` applied 2x here

-- e.g. Quick sort
quickSort :: Ord a => [a] -> [a]
quickSort []     = []
quickSort (x:xs) = quickSort smaller ++ [x] ++ quickSort larger
                   where
                       smaller = [a | a <- xs, a <= x]
                       larger  = [b | b <- xs, b > x]

-- 6.5 Mutual recursion
-- TL;DR Two or more functions defined recursively in terms of each other
-- e.g. Odd and even - simply put, the following recursive definition uses the property:
--      * 0 is even; and,
--      * A number is even if the number before it is odd (and vice versa)
--      (obviously, remainder modulo 2 is easier)
even_ :: Int -> Bool
even_ 0 = True
even_ n = odd_ (n - 1)

odd_ :: Int -> Bool
odd_ 0 = False
odd_ n = even_ (n - 1)

-- 6.6 Advice on recursion
-- Steps:
-- 1. Define the type
-- 2. Enumerate the cases
-- 3. Define the simple cases
-- 4. Define the other cases
-- 5. Generalise and simplify


-- Exercises
-- 1. How does the recursive version of the factorial function behave
--    if applied to arguments < 0
--    Answer: It goes into infinite recursion since we keep on subtracting 1
--    from the argument during the recursive step. An improvement would be
facR2 :: Int -> Int
facR2 0 = 1                                          -- Base case
facR2 n | n < 0         = -1                         -- Bad case, but need to return an Int output
        | otherwise     = n * facR2 (n - 1)          -- (Proper) recursive case

-- 2. Define a recursive function `sumdown` that returns the sum of the non-negative
--    integers from a given value down to zero. For example
--    > sumdown 3
--    6
sumdown :: Int -> Int
sumdown 0 = 0
sumdown n | n < 0       = -1
          | otherwise   = n + sumdown (n - 1)

-- 3. Define the exponentiation operator `^` for non-negative integers using
--    the same pattern of recursion as the multiplication operator `*`, and show how
--    the expressions 2 ^ 3 is evaluated using your definition.
--    > pow 2 3
--      = 2 * pow 2 2
--      = 2 * 2 * pow 2 1
--      = 2 * 2 * 2 * pow 2 0
--      = 2 * 2 * 2 * 1
--    8
pow :: Int -> Int -> Int
pow _ 0 = 1
pow a b = a * pow a (b - 1)

-- 4. Define a recursive function `euclid` that implements _Euclid's algorithm_
--    for calculating the greatest common divisor of two non-negative integers: if
--    the two numbers are equal, this number is the result; otherwise, the smaller
--    number is subtracted from the larger, and the same process is then repeated.
--    For example:
--    > euclid 6 27
--    3
euclid :: Int -> Int -> Int
euclid m n | m == n         = m
           | m > n          = euclid (m - n) n
           | otherwise      = euclid m (n - m)

-- 5. Using the recursive definitinos givin in this chapter, show how the following
--    are evaluated:
--    a) > length [1,2,3]
--       = 1 + length [2,3]
--       = 1 + 1 + length [3]
--       = 1 + 1 + 1 + length []
--       = 1 + 1 + 1 + 0
--       3
--    b) > drop 3 [1,2,3,4,5]
--       = drop 2 [2,3,4,5]
--       = drop 1 [3,4,5]
--       = drop 0 [4,5]
--       [4,5]
--    c) > init [1,2,3]
--       = 1 : init [2,3]
--       = 1 : 2 : init [3]
--       = 1 : 2 : []
--       [1,2]

-- 6. Without looking at the definitions from the standard prelude, define the following
--    library functions on lists using recursion:
and_ :: [Bool] -> Bool
and_ [True] = True
and_ (False:xs) = False
and_ (True:xs) = and_ xs

concat_ :: [[a]] -> [a] 
concat_ [x] = x
concat_ (x:xs) = x ++ concat_ xs

replicate_ :: Int -> a -> [a]
replicate_ 0 _ = []
replicate_ n x = x : replicate_ (n - 1) x

elementAt :: [a] -> Int -> a
elementAt (x:xs) 0 = x
elementAt (x:xs) n = elementAt xs (n - 1)

elem_ :: Eq a => a -> [a] -> Bool
elem_ y [] = False
elem_ y (x:xs) = (y == x) || elem_ y xs

-- 7. Define a recursive function `merge` that merges two sorted lists to give a single
--    sorted list. For example:
--    > merge [2,5,6] [1,3,4]
--    [1,2,3,4,5,6]
merge :: Ord a => [a] -> [a] -> [a]
merge l [] = l
merge [] r = r
merge (l:ls) (r:rs) | l < r         = l : merge ls (r:rs)
                    | otherwise     = r : merge (l:ls) rs

-- 8. Using `merge`, define a function `msort` that implements _merge sort_, in which
--    the empty list and singleton lists are already sorted, and any other list is sorted
--    by merging together the two lists that result from sorting the two halves of
--    the list separately. Hint: first define a function `halve` that splits a list into
--    two two halves whose lengths differ by at most one.
halve :: [a] -> ([a], [a])
halve xs = splitAt n xs where
    n = length xs `div` 2

msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]
msort xs  = merge (msort left) (msort right) where
    (left, right) = halve xs

-- 9. Using the five-step process, construct the library functions that:
--    a) calculate the `sum` of a list of numbers;
--    b) `take` a given number of elements from the start of a list;
--    c) select the `last` element of a non-empty list


main = do
    print (productz [1..10])
    print (reversez [1,2,10])

    print (insert 3 [1,2,4,5])
    print (insertionSort [5,4,2,-1,0,-2,3])
    print (quickSort [5,4,2,-1,0,-2,3])

    print "Exercises"
    print (facR2 (-1))
    print (sumdown (3))
    print (sumdown (-1))
    print (pow 2 3)
    print (euclid 6 27)
    print (euclid 5 27)
    print (euclid 18 27)

    print (merge [2,5,6] [1,3,4])
    print (msort [6,5,4,3,2,1])