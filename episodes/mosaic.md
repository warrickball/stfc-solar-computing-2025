---
title: "Putting it all together with subplots"
teaching: 10
exercises: 5
---

:::::::::::::::::::::::::::::::::::::::: questions

- How do I work out how to use Python packages and modules?
- How should I tackle a big project with multiple components?

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: objectives

- Practice exploring API documentation.
- Recognise the value of breaking a larger software project into smaller components.

::::::::::::::::::::::::::::::::::::::::::::::::::

To start bringing it all together, we'll combine the plots we've made
in the previous lessons into a single dashboard.  From here things are
quite open-ended but the main objective is for you to start looking at
the Matplotlib documentation yourself to find out how to fine tune the
plots.

## Navigating API documentation

There are many ways that we interact with software.  Most people are used
to *graphical user interfaces* (GUIs) and you might have run some programs
as an executable or *command line interface* (CLI).  When call functions
from an external library in our own scripts, we say that we're using the
*application programming interface* (API), though the term can also refer
to how web services respond to HTTP requests, and other things.

The major Python libraries have API documentation where you can find
a list of all the classes, functions, and other things you can use in your own code.
It's good programming practice to embed this documentation in the source code itself.
In Python these snippets of documentation are called *docstrings*.
You can view them by navigating to the projects webpages (or searching online),
by running the `help` function on a given object or, nowadays,
they're quite often accessible via your code editor.

:::::::::::::::::::::::::::::::::::::::: challenge

1. Look up the `subplot_mosaic` function in the [Matplotlib API documentation](https://matplotlib.org/stable/api/index)
   and devise a value of the first argument to get the shape of the SWPC dashboard.

2. Add one of the line plots.

3. Find the keyword argument that will apply a polar projection to some, but not all, of the plots.

4. Add one of the 2D data plots.

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::: solution

1. There are multiple solutions here but I would use
```python
fig, axs = plt.subplot_mosaic(
    """
    AACEEE
    AACFFF
    BBDGGG
    BBDHHH
    """
)
```

2. This would work for the top right plot:
```python
axs['E'].plot(ds['Earth_TIME'], ds['Earth_Density']/1.672e-27/1e6)
```

3. I used the `per_subplot_kw` argument:
```python
fig, axs = plt.subplot_mosaic(
    # ...
    per_subplot_kw={
        'A': {'projection': 'polar'},
        'B': {'projection': 'polar'},
        'C': {'projection': 'polar'},
        'D': {'projection': 'polar'},
    }
)
```

4.

```python
axs['B'].pcolormesh(ds['z_coord'], ds['x_coord'], ds['vv13_3d'].isel(t=0).T)
```

::::::::::::::::::::::::::::::::::::::::::::::::::

The challenge above should put the main elements of the plot in place.
From this point, you can add more detail, like filling in the missing panels.

It's usually a good idea to get a reasonable complete version of each component (e.g. the plot panels)
before integrating them (e.g. in the dashboard).
So I recommend iterating on each plot in a separate cell before integrating it into the dashboard.
This is generally good practice though we don't have time to delve too deeply into it now.

:::::::::::::::::::::::::::::::::::::::: keypoints

- High-quality libraries will have API documentation that describes everything you can use in your own code.
- Matplotlib offers multiple ways to combine plots.  `subplot_mosaic` is new and useful.
- When working on a large piece of software, it's better to identify small parts that can be developed in isolation.

::::::::::::::::::::::::::::::::::::::::::::::::::
