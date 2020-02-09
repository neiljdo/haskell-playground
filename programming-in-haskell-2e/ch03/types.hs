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

