---
title: "Line plots with Matplotlib"
teaching: 10
exercises: 5
---

:::::::::::::::::::::::::::::::::: questions

- How do I make simple plots with Matplotlib?

::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::: objectives

- Know that Matplotlib has a functional and an object-oriented API.

::::::::::::::::::::::::::::::::::::::

## Functional API

The simplest way to use Matplotlib is through the *functional* API,
where we call functions in the main library.  The simplest is just
`matplotlib.plot`.

In a JupyterLab Notebook, you probably need to run this "magic" command
before importing Matplotlib.

```python
%matplotlib inline
```
```python
import matplotlib.pyplot as plt  # this is canonical
plt.plot([0,1], [0,1])
```
Depending on where you're running this, you might also need
```python
plt.show()
```

We'll usually call Matplotlib functions on NumPy arrays or other
array-like objects, though just about any collection will work.
```python
x = np.linspace(0., 2*np.pi, 101)
plt.plot(x, np.sin(x))
```

## Object-oriented API

Users are encouraged to use Matplotlib's *object-oriented* API,
where we create plot *objects* on which we then call functions.
This makes it easier to control multiple plots or plots with multiple elements.

```python
fig, ax = plt.subplots()
ax.plot([0,1], [0,1])
```

The functional API uses methods from the `Figure` and `Axes` types.
I usually experiment with plot basics using the functional API.

## Plotting data

Either API will usually work with iterable things that contain numbers.
As a simple start with our data, we could plot:

```python
plt.plot(ds['Earth_TIME'], ds['Earth_Density']/1.672e-27/1e6)
```

where I've borrowed the units from an IDL script I found.

:::::::::::: challenge

Plot separately the plasma density at STEREO A,
the radial velocity at Earth
and the radial velocity at STEREO A.

::::::::::::::::::

:::::::::::: solution

For example,
```python
time = ds['Earth_TIME']/86400.0
plt.plot(time, ds['STEREO_A_Density']/1.672e-27/1e6)
plt.plot(time, ds[Earth_V1]/1000)
plt.plot(time, ds['STEREO_A_V1]/1000)
```

::::::::::::::::::

## How do I make my favourite kind of plot?

The Matplotlib has galleries of [plot types](https://matplotlib.org/stable/plot_types/index.html)
and [examples](https://matplotlib.org/stable/gallery/index.html)
with the code provided alongside the plot.
This is an excellent place for finding out how to embellish plots or use particular features.

::::::::::::::::::::::::::::::::: keypoints

- Matplotlib is a widely used plotting package.
- The *functional* API allows for rapid, common plots.
- The *object-oriented* API allows much finer control over a plot's appearance.
- Use the gallery of examples to find features you may wish to use.

:::::::::::::::::::::::::::::::::::::
