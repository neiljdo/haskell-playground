import Data.Char

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
-- f (x:xs)     = x # f xs, where '#' is an operator (infix here)
--              = (#) x (f xs)      (alternative prefix notation, sometimes more useful)
-- e.g.
-- sum []       = 0
-- sum (x:xs)   = x + sum xs
-- Using `foldr`, this can be more succinctly written as
-- sum :: Num a => [a] -> a
-- sum = foldr (+) 0
-- NOTE: For the `foldr` function, the operator `#` is assumed to associate to the right

-- Q: is it possible to write `foldr` using recursion?

-- 7.4 The `foldl` function
-- This is the analog of `foldr` for the following recursion pattern:
-- NOTE: Notice the use of the first argument as an **accumulator**
-- f v []       = v
-- f v (x:xs)   = f (v # x) xs
-- NOTE: For the `foldl` function, the operator `#` is assumed to associate to the left.
-- For associative operators, i.e. left and right associative, the choice should be based
-- on efficiency considerations.

-- 7.5 The composition operator
dot :: (b -> c) -> (a -> b) -> (a -> c)
dot g f = \x -> g (f x)

-- 7.6 Binary string transmitter
-- 7.6.1 Binary numbers
-- 7.6.2 Base conversion
type Bit = Int

-- NOTE: [Bit] here is the right to left representation of a binary number,
-- e.g. 1101 (base 2) = [1,0,1,1]
bin2int :: [Bit] -> Int
bin2int bits = sum [w * b | (w, b) <- zip weights bits] where
                    weights = iterate (*2) 1

-- Simpler `bit2int` using some algebra:
-- (1 * a) + (2 * b) + (4 * c) + (8 * d)
-- = a + 2 * (b + (2 * c) + (4 * d))
-- = a + 2 * (b + 2 * (c + (2 * d)))
-- = a + 2 * (b + 2 * (c + 2 * (d + (2 * 0))))
bin2int_ :: [Bit] -> Int
bin2int_ = foldr (\x y -> x + 2 * y) 0
-- bin2int_ [] = 0
-- bin2int_ (x:xs) = (\x y -> x + 2 * y) x (bin2int_ xs)
--                 = x + 2 * (bin2int_ xs), and so on..

-- While the reverse process could be implemented as
int2bin_ :: Int -> [Bit]
int2bin_ 0 = []
int2bin_ n = n `mod` 2 : int2bin_ (n `div` 2)

-- Function that makes sure we have an 8-bit representation
-- NOTE: `repeat` here creates an infinite list, but since the `take` call only asks for
-- 8 elements, it will eventually terminate.
make8 :: [Bit] -> [Bit]
make8 bits = take 8 (bits ++ repeat 0)

-- 7.6.3 Transmission
-- By composing the functions above, we can create a function that "transmits" an input
-- string as a sequence of bits.
encode :: String -> [Bit]
encode = concat . map (make8 . int2bin_ . ord)          -- There is even a `concatMap`

-- To decode a transmission
chop8 :: [Bit] -> [[Bit]]
chop8 [] = []
chop8 bits = take 8 bits : chop8 (drop 8 bits)

decode :: [Bit] -> String
decode = map (chr . bin2int) . chop8

-- 7.7 Voting algorithms
-- 7.7.1 First past the post
-- 7.7.2 Alternative vote


-- Exercises
-- 1. Show how the list comprehension `[f x | x <- xs, p x]` can be expressed using
--    the higher-order functions `map` and `filter`.
lc :: (a -> b) -> (a -> Bool) -> [a] -> [b]
lc f p xs = [f x | x <- xs , p x] 

lc2 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
lc2 f p xs = map f (filter p xs)

-- 2. Without looking at the definitions from the standard prelude, define the following
--    higer-order library functions on lists:
all__ :: (a -> Bool) -> [a] -> Bool
all__ p [] = True
all__ p (x:xs) = (&&) (p x) (all__ p xs)

-- Using `foldr`
all_ :: (a -> Bool) -> [a] -> Bool
all_ p = foldr ((&&) . p) True

any_ :: (a -> Bool) -> [a] -> Bool
any_ p = foldr ((||) . p) False

-- TODO: Is it possible to use `foldX`?
takeWhile_ :: (a -> Bool) -> [a] -> [a]
takeWhile_ p [] = []
takeWhile_ p (x:xs) | p x           = x : takeWhile_ p xs
                    | otherwise     = []

dropWhile_ :: (a -> Bool) -> [a] -> [a]
dropWhile_ p [] = []
dropWhile_ p (x:xs) | p x           = dropWhile_ p xs
                    | otherwise     = x : xs

-- 3. Redefine the functions `map f` and `filter p` using `foldr`.

-- 4. Using `foldl`, define a function `dec2int` that converts a decimal number into
--    an integer. For example:
--    > dec2int [2,3,4,5]
--    2345
-- dec2Int :: [Int] -> Int


main = do
    print (twice (*2) 4)

    print "Binary string transmitter"
    print (bin2int [1,0,1,1])
    print (bin2int_ [1,0,1,1])
    print (int2bin_ (bin2int_ [1,0,1,1]))
    let encoded = encode "abc"
    print encoded
    print (decode encoded)

    print "Exercises"
    let a = [0,1,2,3,4,5]
    print (lc (+1) odd a)
    print (lc2 (+1) odd a)

    let allTrue = [True, True, True]
    let anyTrue = [True, False, True]
    print (all_ id allTrue)        -- returns True
    print (all_ id anyTrue)        -- returns False
    print (any_ not allTrue)       -- returns False
    print (any_ id anyTrue)        -- returns True

    let someInts = [2,4,6,7,8]
    print (takeWhile even someInts)
    print (takeWhile_ even someInts)        -- returns [2,4,6] which ends at 6, since the next element is odd

    let someMoreInts = [1,3,5,6,7]
    print (dropWhile odd someMoreInts)
    print (dropWhile_ odd someMoreInts)     -- returns [6,7] which starts at 6, since it is first even element
