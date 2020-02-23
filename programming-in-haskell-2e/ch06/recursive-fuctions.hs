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
-- 1.
-- 2.
-- 3.



main = do
    print (productz [1..10])
    print (reversez [1,2,10])

    print (insert 3 [1,2,4,5])
    print (insertionSort [5,4,2,-1,0,-2,3])
    print (quickSort [5,4,2,-1,0,-2,3])
    print "Exercises"