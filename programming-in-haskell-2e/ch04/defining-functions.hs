-- Conditional expressions vs Guarded equations
signumC :: Int -> Int
signumC n = if n < 0 then -1 else
            if n == 0 then 0 else 1

-- But using guards...
signumG :: Int -> Int
signumG n | n < 0       = -1
          | n == 0      = 0
          | otherwise   = 1

-- How beautiful is that? O_O

-- Pattern matching
-- i.e. explicitly listing out all possible input (combinations)
not :: Bool -> Bool
not False = True
not True  = False
-- NOTE: Useful for functions w/ small input space

-- Using wildcards
(&&) :: Bool -> Bool -> Bool
True && True = True
_    && _    = False

{-
How the prelude defines (&&):

True && b  = b
False && _ = False
-}

-- Tuple and list patterns
a = [1, 2, 3] == 1: 2: 3: []        -- Associates to the right
-- (:) :: a -> [a] -> [a]

-- Lambda expressions
b = \x -> x + x
c = b 2

-- Operator sections
-- Recall from previous code:
mult10 x = x * 10
mult10again = (* 10)


-- Exercises
-- 1. Using library functions, def a function `halve` that splits an even-lengthed list
--    into two halves. For example:
--    > halve [1, 2, 3, 4, 5, 6]
--    ([1, 2, 3], [4, 5, 6])
halve :: [a] -> ([a], [a])
halve xs = (h1, h2) where
    h1 = take sizehalf xs
    h2 = drop sizehalf xs
    sizehalf = length xs `div` 2

-- 2. Define a function `third` that returns the third element in a list that contains
--    at least this many elements using:
third1 :: [a] -> a
third1 xs = head (tail (tail xs))

third2 :: [a] -> a
third2 xs = xs !! 2

third3 :: [a] -> a
third3 (_:_:x:_) = x

-- 3. Consider a function `safetail :: [a] -> [a]` that behaves in the same way as
--    `tail` except that it maps the empty list to itself rather than producing an error.
--    Using `tail` and the function `null :: [a] -> Bool` that decides if a list is empty
--    or not, define `safetail` using:
safetail1 :: [a] -> [a]
safetail1 xs = if null xs then [] else tail xs

safetail2 :: [a] -> [a]
safetail2 xs | null xs      = []
             | otherwise    = tail xs

safetail3 :: [a] -> [a]
safetail3 (_:xs) = xs
