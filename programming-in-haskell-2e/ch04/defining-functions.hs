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
