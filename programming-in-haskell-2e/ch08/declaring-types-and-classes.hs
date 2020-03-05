-- 8. Declaring types and classes

-- 8.1 Type declarations
-- NOTE: We capitalize the first letter of the type name for "concrete" types
type String_ = [Char]

-- * Types can be nested, e.g.
type Pos = (Int, Int)
type Trans = Pos -> Pos

-- * Types CANNOT BE RECURSIVE, e.g.
-- type Tree = (Int, [Tree])        # this will throw an exception

-- * Types can be parametrized (one or more parameters), e.g.
type Pair a = (a, a)                -- That is, a `Pair` is a tuple of *any* type
type Assoc k v = [(k, v)]           -- `Assoc` is a kind of strict dictionary,
                                    -- where all keys must be of the same type `k`,
                                    -- and all values must be of the same type `v`


-- With `Assoc` above, we can define a lookup function like so,
-- Q: Is this O(n)?
find :: Eq k => k -> Assoc k v -> v
find k d = head [v | (k', v) <- d, k == k']

-- 8.2 Data declarations
-- Enumerates all possible values. In the example below,
-- `False` and `True` are called *constructors*.
data Bool_ = False | True

-- * Constructor names must also begin with capital letters
-- * Types cannot share constructor names

-- !!! Names given to new types and constructors have no inherent meaning.
-- The following is the same data declaration of `Bool_` above:
data Foo = Bar | Baz
-- How the type behaves is ultimately defined by the programmer



-- - How is it different from other

-- 8.3 Newtype declarations
-- - How is it different from other

-- 8.4 Recursive types

-- 8.5 Class and instance declarations
-- - Similar to class and instances in OOP languages?

-- 8.5.1 Derived instances

-- 8.6 Tautology checker

-- 8.7 Abstract machine


-- Exercises
-- 1.
-- 2.
-- 3.


main = do
    print "8.1 Type declarations"
    let d = [('a', 1), ('b', 2), (3, 'c')]
    print (find 'a' d)
    print "Exercises"
