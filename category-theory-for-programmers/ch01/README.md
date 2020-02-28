# Category: The Essence of Composition

## Definitions

A **category** is a collection of *objects* and *arrows* (or *morphisms*) between objects.

Morphisms **compose** if the end of one is the start of another.

e.g. If objects `A`, `B`, and `C`, and morphisms `f := A -> B` and `g := B -> C` are in a category, then we must also have `g . f := A -> C`.

## Properties of composition

Composition obeys:

-   *Associativity*

    If `f := A -> B`, `g := B -> C`, `h := C -> D`, then:
    `(h . g) . f = h . (g . f) = h . g . f`

-   *Identity*

    Each object `X` in a category has its identity morphism `id_X`.
    If `f := A -> B`, then:
    `f . id_A = f = id_B . f`.

## A change of perspective

In set theory, we can look at each individual elements of a set but in category theory, we zoom out far enough that we abstract entire sets into a single point.