---
title: "Python basics"
teaching: 20
exercises: 10
---

:::::::::::::::::::::::::::::::::: questions

- What are Python's fundamental types?
- What basic operations does Python implement?

::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::: objectives

- Know Python's basic data types and operations.
- Understand accessing elements by index or key.
- Know about mutability and how it can lead to unexpected behaviour.

::::::::::::::::::::::::::::::::::::::

## Basic data types

* *Booleans*, which are either `True` or `False`.

* *Integers*, or `int`s, like -1 or 233.

* *Floating-point numbers*, or `floats`, like `3.14159` or `9.11e-28`.

* *Strings*, like `'hello'` or `'c'`.  Declare with `'` or `"` but don't mix.

* *None*, a special type that usually represents no value, e.g. if a function returns nothing.

Assign to variables with `=`.

## Basic operations

Python has basic arithmetic operations, as you'd expect: `+`, `-`, `*`, `/`.
There are more but we aren't going to worry about them now.

These should work roughly as you expect.  Python will convert sensibly.
Note in particular that division of two integers produces a float.
There is also the *floor divison* operator `//`, which is like Python 2 integer division and returns an integer.

```python
print(5/3, 5//3)
```

```output
1.6666666666666667 1
```

## Lists and tuples

Lists are a collection of things, in an order.
The things can be any mixture of types (including more lists).

```python
my_list = [0, 'a', True, 1.0]
```

Lists have a length, as many objects do.

```python
print(len(my_list))
```

```output
4
```

Python indexes start from zero and don't include the upper bound.

```python
print(my_list[0])
```

```output
0
```

I think of this like many of the ways we index time. E.g.

- when you're 25 years old, you're in the 26th year of your life; and
- 09:... on a clock means we're in the 10th hour.

Supposedly comes from the fact that the variable name points to the start of the item
and the index gives the relevant offset in memory.  So element `[0]` means no offset
and therefore the first element in the list.

You might be compelled by the [arguments by Edsger Dijkstra](https://www.cs.utexas.edu/~EWD/transcriptions/EWD08xx/EWD831.html).

We can count backwards from the end with negative indices.

```python
print(my_list[-1])
```

```output
1.0
```

which is conveniently the same as `len(my_list)-1`.

We can use special indices called *slices*, with syntax `start:stop:step`.

```python
print(my_list[1:4:2])
```

```output
[0, True]
```

`start` defaults to 0, `stop` to the length of the list, and `step` to 1.

:::::::::::::::::::::::::: challenge

Some fundamental operations work with lists.
Guess what the following expressions will produce before running them.

1. `['a', 'b', 'c'] + ['d', 'e', 'f']`
2. `['a', 'b', 'c']*3`
3. `[0, 1, 2] + 3`

:::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::: challenge

What is the output of the following sequence of Python statements?

```python
a = [0, 5, 10]
b = a
a.append(15)
print(b)
```

::::::::::::::::::::::::::::::::

:::::::::::::::::::::: solution

[0, 5, 10, 15]

::::::::::::::::::::::::::

:::::::::::::::::::::: callout

The challenge above is a demonstration of *mutability*:
the ability to modify a variable *in place*.
When we assign `b = a`, `b` becomes another *reference* to the data behind `a`
because `a` is mutable.

Tuples are a lot like lists but immutable.  You can declare them with `(...)`.

Strings are a bit like tuples of characters but with a lot of functions.

:::::::::::::::::::::::::::

## Dictionaries

Dictionaries are the other main kind of collection.
They're like lists but we declare them with `{...}`
and access elements using *keys* rather than indices.

```python
my_dict = {'a': 0, 'b': 1.0}
print(my_dict['a'])
```

```output
0
```

The keys can technically be anything "hashable" but we almost always strings.
Dictionaries are mutable.

## Functions and methods

We've been using `print`, which is a *function*: it takes some arguments (or sometimes none!)
and returns a value.

The usual arguments that appear in sequence are called *positional* arguments.
E.g. `'hello'` in `print('hello')`.

There are also *keyword* arguments that have a default value. e.g.

```python
print('hello', end=' ...')
```

```output
hello ...
```

Simplest way to get help is `help` function but most GUI tools offer more (e.g. `print?` in IPython)
and most documentation is rendered online (more on this later).

Functions always return a value but if it's nothing explicit it's just `None`.

```python
x = print("what's x?")
print(x)
```

```output
what's x?
None
```

Some functions are attached to objects, in which case they're sometimes called *methods*,
and they can modify (mutable) objects in place.

```python
x = my_list.append(25)
print(x)
print(my_list)
```

```output
None
[0, 'a', True, 1.0, 25]
```

::::::::::::::::::::::::::::::::: keypoints

- Python's basic types are `bool`s, `int`s, `float`s and `str`s.
- `None` is a special type that represents the absence of a value.
- Lists are mutable collections that can be accessed by index number.
- Dictionaries (`dict`s) are mutable collections that can be accessed by a key, which is usually a string.
- Functions may take positional arguments or keyword arguments.

:::::::::::::::::::::::::::::::::::::
