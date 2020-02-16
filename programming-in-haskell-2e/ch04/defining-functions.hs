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


-- 7. Show how the meaning of the following curried function definition can be formalised
--    in terms of lambda expressions:
--    mult :: Int -> Int -> Int -> Int
--    mult x y z = x * y * z

-- For the innermost lambda function, it should take a single input and a function of
-- the other variables. We build upon this innermost function, removing argument layers
-- along the way.
mult :: Int -> Int -> Int -> Int
mult = \x -> (\y -> (\z -> x * y * z))

multBy3 = mult 3            -- returns a function of y and z, i.e. we fix x = 3
multBy12 = multBy3 4        -- returns a function of z, i.e. we fix x = 3, y = 4


-- 8. The _Luhn algorithm_ is used to check bank card numbers for simple errors such as
--    mistyping a digist, and proceeds as follows:
--    * consider each digit as a separate number;
--    * moving left, double every other number from the second last;
--    * subtract 9 from each number that is now greater than 9;
--    * add all the resulting numbers together;
--    * if the total is divisible by 10, the card number is valid
--    Define a function `luhnDouble` that doubles a digit and subtracts 9 if the result
--    is greater than 9.
luhnDouble :: Int -> Int
luhnDouble x = (2 * x) `mod` 9 

--    Using `luhnDouble` and the integer remainder function `mod`, define
--    a function `luhn` that decides if a four-digit bank card number is valid.
luhn :: Int -> Int -> Int -> Int -> Bool
luhn x y z w = ((luhnDouble x + y + luhnDouble z + w) `mod` 10) == 0 


main = do
    print (multBy12 5)
    print (multBy12 10)

    -- luhnDouble
    print (luhnDouble 3)
    print (luhnDouble 6)

    -- luhn (naïve)
    print (luhn 1 7 8 4)
    print (luhn 4 7 8 3)
