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
--    EDIT: This **ACTUALLY** works! Here, the return function must be:
--    a) a function;
--    b) whose input type is a; and,
--    c) whose output type is b
compose2 :: (b -> c) -> (a -> b) -> (a -> c)
compose2 g f = \x -> g (f x)

dblThenInc1      = compose (\x -> x + 1) (\x -> 2 * x)
dblThenInc1Again = compose (\x -> x + 1) (\x -> 2 * x)

-- 3. Write a program that tries to test that your composition function respects identity.
--    TODO: Missing answer.

-- 4. Is the world-wide web a category in any sense? Are links morphisms?
--    Answer: If web pages are the objects with links as morphisms, then it is not a category.

-- 5. Is Facebook a category, with people as objects and friendships as morphisms?
--    Answer: No. The "friendship morphism" is not composable, i.e. the friend of
--    my friend is not necessarily my friend.

-- 6. When is a directed graph a category?
--    Answer: Given any directed graph, we can turn it into a category by adding:
--    a) arrows from a node to itself (identity); and,
--    b) arrows connecting the endpoints of any length-2 path (composition), like so:

{-
NOTE: Identity arrows not drawn for brevity.
                                    ___________
                                   /           v             
      o ---> o ---> o             o ---> o ---> o
              \            =>      \     \
               \---> o              \     \---> o
                                     \---------^
-}


main = do
    print (id_ 10)
    print (id_ "works on strings, too")

    print (((\x -> x + 1) . (\x -> 2 * x)) 3)
    print (dblThenInc1 3)
    print (dblThenInc1Again 3)
    