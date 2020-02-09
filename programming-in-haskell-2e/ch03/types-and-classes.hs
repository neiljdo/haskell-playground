-- A *type* is a collection of related values
-- `v :: T` means that v has type T
-- NOTE: More generally, v can be an unevaluated expression
a = 2^63 :: Int

{-
> :type head
head :: [a] -> a
-}

{-
Lists := sequence of elements of the same type (could be infinite)
Tuple := finite sequence of components, could be of different types
-}

{-
Function types := mapping from arguments of type, T1, to results of another type, T2

Example 1:
Adding two numbers is a function on a 2-tuple of numbers, or integers in this case,
that returns a single numeric output

add :: (Int, Int) -> Int

Example 2:
`head` takes in a list of any type, a, and returns the first element of that list,
which should be of the same type

head :: [a] -> a

Question: But what about the head of an empty list?
-}

{-
Currying
Another way of looking at functions with multiple input arguments -
we interpret the function as function of just the first argument that returns
a new function of one-less argument.

Example 3:
add` :: Int -> (Int -> Int)

or, with less parentheses (associates to the right on declaration, to the left on eval)

add` :: Int -> Int -> Int
-}
add :: (Int, Int) -> Int
add (x, y) = x + y
b = add (3, 5)

add' :: Int -> Int -> Int
add' x y = x + y
c = add' 3 5

-- More interestingly, we can use `add'` to create more functions or partial applications
add3 :: Int -> Int
add3 = add' 3
d = add3 5