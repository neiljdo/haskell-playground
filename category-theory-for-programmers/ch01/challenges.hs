-- Challenges
-- 1. Implement, as best as you can, the identity function in your favorite language.
id_:: a -> a
id_ x = x

-- 2. Implement the composition function in your favorite language. It takes two functions
--    as arguments and returns a function that is their composition.
compose :: (b -> c) -> (a -> b) -> a -> c
compose g f x = g (f x)

--    My initial attempt for the compose function above was as follows:
--    compose :: (b -> c) -> (a -> b) -> (a -> c)
--    Why wouldn't this type work?

dblThenInc1 = compose (\x -> x + 1) (\x -> 2 * x)


main = do
    print (id_ 10)
    print (id_ "works on strings, too")

    print (((\x -> x + 1) . (\x -> 2 * x)) 3)
    print (dblThenInc1 3)
    