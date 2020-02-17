-- 5 List comprehensions

-- 5.1 Basic concepts
a = [x^2 | x <- [1..5]]

-- e.g. generate cartesian product of two sets
b = [(x, y) | x <- [1..3], y <- [4..5]]

-- e.g. concatenate a list of lists into a single list
concatt :: [[a]] -> [a]
concatt xss = [x | xs <- xss, x <- xs]
-- i.e. for a list of lists, xss,
--      for each list, xs, in xss,
--          for each element, x, in the current xs
--              put that element into the output


main = do
    print a
    print b
    print (concatt [[1], [2, 3], [], [4..9]])
