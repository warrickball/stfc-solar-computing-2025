---
title: "The Python ecosystem"
teaching: 10
exercises: 5
---

:::::::::::::::::::::::::::::::::::::::: questions

- What are Python packages?
- Where do I find them?
- How do I know which are reliable?
- Which are the main libraries used for scientific research?

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: objectives

- Understand Python packages and know some places to find them.
- Know some ways of deciding if a library is reliable.
- Learn the main advantages of array-like objects, including NumPy arrays.

::::::::::::::::::::::::::::::::::::::::::::::::::

One of Python's biggest strengths is its rich ecosystem of packages.
The downside is that the user sometimes needs to take care to avoid
poor or unmaintained packages that present problems over time.

## The standard library

Python itself comes with a fairly extensive set of packages and modules
called the [*standard library*](https://docs.python.org/3/library/index.html).
These aren't loaded by default but are always available.

To start using a module (be it from the standard library or third-party),
we can use the `import` statement in several ways.

```python
import math               # use the whole module
import math as m          # use the whole module with an alias
from math import pi, sin  # use a few things
print(math.gcd(16,10))
root_half = 1/m.sqrt(2)
print((m.erf(root_half)-m.erf(-root_half))/2)
print(sin(pi))
```

```output
2
0.6826894921370859
1.2246467991473532e-16
```

Even if the standard library isn't exactly what you want,
sometimes comprimising a small amount of functionality is worth
the guarantee that the module is installed.

## The Python Package Index (PyPI)

Many Python packages are uploaded to the [*Python Package Index*](https://pypi.org/) (PyPI),
from which its easy to install packages using the package installer *pip*.
It's also quite easy to upload projects to PyPI, so many projects are uploaded
but then fall out of use.  When considering a package, it's worth having a look
at if there have been recent releases.  If there's a link to an issue tracker
(often part of a repository host like GitHub), you can also see if issues are
being responded to or contributions incorporated.

:::::::::::::::::::::::::::::::::::::::: challenge

Navigate to PyPI and search for packages using some keywords of your choice (e.g. "solar physics").
What projects turn up?
Do any look interesting?
Are they maintained?

::::::::::::::::::::::::::::::::::::::::::::::::::

## The scientific stack

Over many years, a core set of widely-used and well-maintained libraries for scientific computing has been established.
These are often referred to collectively as the *scientific stack*.

- [**NumPy**](https://numpy.org/) provides a fast array object and various core functions for working with them.
  By implementing a lot of the computation in a faster, lower-level programming language (mostly C),
  NumPy arrays are generally quite fast to use and overcome much of Python's apparent slowness.

- [**SciPy**](https://scipy.org/) is a large library of scientific algorithms,
  mostly designed to work with NumPy arrays. E.g. fast Fourier transforms, signal processing, interpolation.

- [**Matplotlib**](https://matplotlib.org/) is the de-facto standard for 2D plotting.
  Other libraries exist but Matplotlib is very well established and has become very versatile
  so you can always customise it to your liking.
  Matplotlib has some 3D plotting capability but there are other specific 3D-plotting libraries that are usually better
  (though often more complicated to use).

- [**Pandas**](https://pandas.pydata.org/) is a popular choice for data science.
  It implements an array-like object called a DataFrame (a bit like a spreadsheet)
  and is particularly good at handling messy data and dates.

## Domain-specific packages

Many particular research domains then build on the scientific stack
with their own domain-specific libraries.
The number of packages grows as we move further from the core packages above
but here are a few packages you might encounter.

- [**Cartopy**](https://scitools.org.uk/cartopy/) supplements Matplotlib to help you
  plot maps.

- [**Astropy**](https://www.astropy.org/) is the result of a big community effort
  to recreate common core tools for astronomy in Python.
  There is a core `astropy` module as well as a small ecosystem of affiliated packages.

- [**SunPy**](https://sunpy.org/) is like Astropy but specifically for solar physics.
  E.g. there are packages for working with SOHO and SDO data.

- [**PlasmaPy**](https://www.plasmapy.org/) is aimed at plasma physics generally
  (so including laboratory physics) but can be useful for calculating plasma parameters.

## NumPy basics

### Vectorisation

Python doesn't offer a built-in object in which we can operate on multiple elements at once.
Instead, we might explicitly loop over the elements of an iterable, like a list.

```python
x = list(range(10))
y = x**2
```
```output
Traceback (most recent call last):
  File "<python-input-1>", line 1, in <module>
    y = x**2
        ~^^~
TypeError: unsupported operand type(s) for ** or pow(): 'list' and 'int'
```
```python
y = [xi**2 for xi in x]
print(y)
```
```output
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```
It turns out that for specific reasons about how Python works as a language,
this is much slower than lower-level, compiled languages like C or Fortran.

With NumPy arrays, we *can* manipulate all the values at once.
```python
import numpy as np  # this is canonical
x = np.arange(10)
y = x**2
print(y)
```
```output
[ 0  1  4  9 16 25 36 49 64 81]
```
Rewriting an operation to use the whole array at once is called *vectorisation*.
It doesn't come for free because you need memory for complete arrays
but this isn't often an issue and can be worked around when necessary.
While usually still not quite as fast as some other languages,
vectorisation closes a lot of the gap and we get to retain the high-level interface of Python.

You might occasionally encounter something that doesn't handle NumPy arrays.
`math.sin` for example raises an error:
```python
x = np.linspace(0, 2*np.pi, 10)
import math as m
y = m.sin(x)
```
```output
Traceback (most recent call last):
  File "<python-input-13>", line 1, in <module>
    y = m.sin(x)
TypeError: only length-1 arrays can be converted to Python scalars
```
so we use `numpy.sin` instead.
```python
y = np.sin(x)
print(y)
```
```output
[ 0.00000000e+00  6.42787610e-01  9.84807753e-01  8.66025404e-01
  3.42020143e-01 -3.42020143e-01 -8.66025404e-01 -9.84807753e-01
 -6.42787610e-01 -2.44929360e-16]
```

Other libraries provide similar array operations (many implemented using NumPy).
In Python, avoid looping over arrays and array-like objects.
Try to manipulate whole arrays at once.

### Broadcasting

NumPy arrays all have a *shape*, the number of elements in each dimensions.
```python
x = np.arange(6)
print(x)
print(x.shape)
y = x.reshape((2,3))
print(y)
print(y.shape)
```

```output
[0 1 2 3 4 5]
(6,)
[[0 1 2]
 [3 4 5]]
(2, 3)
```

NumPy will usually try to sensibly combine dimensions.  E.g.
```python
print(x-2)
```
```output
[-2 -1  0  1  2  3]
```
works even though 2 is not an array.  If shapes are incompatible, you'll get errors:
```python
a = np.arange(2)
b = np.arange(3)
print(a + b)
```
```output
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
Cell In[20], line 1
----> 1 print(a + b)

ValueError: operands could not be broadcast together with shapes (2,) (3,)
```
If the shapes can be expanded sensibly, NumPy does so.
This is called *broadcasting*.
```python
c = a.reshape(2,1)
d = b.reshape(1,3)
print(c)
print(d)
print(c+d)
```
```output
[[0]
 [1]]
[[0 1 2]]
[[0 1 2]
 [1 2 3]]
```
You can pass `-1` as one argument of `reshape`, which will take on whichever value makes sense.
You can also slice with `np.newaxis` or `None` to create additional dimensions.

Mind you don't run out of memory, though.
```python
z = np.arange(100_000)
print(z[:,None] + z[None,:])
```
```output
---------------------------------------------------------------------------
MemoryError                               Traceback (most recent call last)
Cell In[27], line 1
----> 1 print(x[:,None] + x[None,:])

MemoryError: Unable to allocate 74.5 GiB for an array with shape (100000, 100000) and data type int64
```

:::::::::::::::::::::::::::::::::::::::: challenge

Compute $\sin(x)$ on $[0,2\pi]$, estimate the derivative using finite differences
and compare those to the analytic derivative.

Start off with
```python
x = np.linspace(0, 2*np.pi, 101)
y = np.sin(x)
# ...
```

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::: solution

You can estimate the derivative with forward (or backward, which is similar) differences,
```python
x = np.linspace(0, 2*np.pi, 101)
y = np.sin(x)
dy_dx = (y[1:]-y[:-1])/(x[1]-x[0])
```
or central differences,
```python
x = np.linspace(0, 2*np.pi, 101)
y = np.sin(x)
dy_dx = (y[2:]-y[:-2])/(x[2:]-x[:-2])
```
Taking care to compare the appropriate indices, we can try comparing the appropriate values.
E.g., for the fractional error in central differences,
```python
print(dy_dx - np.cos(x[1:-1]))
```
```
[-6.56545656e-04 -6.52656466e-04 -6.46191539e-04 -6.37176389e-04
 -6.25646595e-04 -6.11647660e-04 -5.95234830e-04 -5.76472881e-04
 -5.55435857e-04 -5.32206782e-04 -5.06877329e-04 -4.79547463e-04
 ...
 -5.06877329e-04 -5.32206782e-04 -5.55435857e-04 -5.76472881e-04
 -5.95234830e-04 -6.11647660e-04 -6.25646595e-04 -6.37176389e-04
 -6.46191539e-04 -6.52656466e-04 -6.56545656e-04]
 ```

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- The main libraries in the scientific stack are NumPy, SciPy, Matplotlib and Pandas.
- There are many more domain-specific libraries. e.g. Cartopy, Astropy, SunPy and PlasmaPy.
  Their quality and level of support can vary widely.
  Activity in the source repo is a useful proxy for whether a project is maintained.
- NumPy provides an array object that other libraries use in their objects (e.g. Pandas' `DataFrame`s).
  Manipulating these objects directly is much faster than looping over elements of a list or other collection.
- NumPy will combine the dimensions of arrays conveniently by *broadcasting*.

::::::::::::::::::::::::::::::::::::::::::::::::::
