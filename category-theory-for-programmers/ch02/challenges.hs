-- Challenges
-- 1. Define a higher-order function `memoize` in your favorite language. This function
--    takes a pure function `f` as an argument and returns a function that behaves almost
--    exactly like `f`, except that it only calls the original function once for every
--    argument, storeos the result internally, and subsequently returns this stored result
--    every time it's called with the same argument.
memoize :: (a -> b) -> (a -> b)
memoize f = f


-- 2. Try to memoize a function from your standard library that you normally use to
--    produce random numbers. Does it work?


-- 3. Most random number generators can be initialized with a *seed*. Implement a function
--    that takes a seed, calls the random number generator with that seed, and returns the
--    result. Memoize that function. Does it work?


-- 4. Which of these C++ functions are pure? ...
--    TODO: C++??


-- 5. How many different functions are there from `Bool` to `Bool`? Can you implemnet them all?


-- 6. Draw a picture of a category whose only objects are the types `Void`, `()` (unit),
--    and `Bool`; with arrows correspondting to all possible functions between these types.
--    Label the arrows with the name of the functions. 