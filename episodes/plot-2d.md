---
title: "2D plots with Matplotlib"
teaching: 10
exercises: 5
---

:::::::::::::::::::::::::::::::::::::::: questions

- How do I plot 2D datasets with Matplotlib?

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: objectives

- Matplotlib methods for many plots of 2D data.
- Matplotlib supports different projections, like polar coordinates.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Some plot functions

A reasonable start for viewing 2D data is usually
`matplotlib.pyplot.imshow`, which takes an array as an argument and plots
it as if the data represented a grayscale image.
```python3
import matplotlib.pyplot as plt  # this is canonical
x = np.linspace(-2, 2, 101)
y = np.linspace(-2, 2, 101)
z = 1/(1 + x[:,None]**2 + y[None,:]**2)
plt.imshow(z)
```
Most 2D plots take a `cmap=` keyword argument to specify the colour map.
Matplotlib includes many options that you can see in
[Matplotlib's colour map reference](https://matplotlib.org/stable/users/explain/colors/colormaps.html).

:::::::::::::::::::::::::::::::::::::::::: callout

The default colour map is called *viridis* and was introduced in 2015.
There is an [excellent talk](https://www.youtube.com/watch?v=xAoljeRJ3lU)
by Nathaniel Smith at the SciPy 2015 conference, in which he explains
the colour theory behind this colour map (and why *jet* is bad).

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: challenge

Use `matplotlib.pyplot.imshow` to plot any of the 2D data sets in the WSA Enlil data.

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::: solution

```python
plt.imshow(ds['vv13_3d'].isel(t=0))
```

::::::::::::::::::::::::::::::::::::::::::::::::::

## Projections

While we've now plotted some data, it has at least one *angular* co-ordinate,
so it would be nice to use `'polar'` co-ordinates.
To do so, we need to create an axis using the object-oriented API
and pass the `projection=` keyword argument.

`pcolormesh` works better than `imshow` in polar co-ordinates.
Let's first check that it does roughly the same thing:

```python
plt.pcolormesh(ds['vv13_3d'].isel(t=0))
```

Now let's go ahead in polar coordinates:

```python
ax = plt.subplot(projection='polar')
ax.pcolormesh(ds['z_coord'], ds['x_coord'], ds['vv13_3d'].isel(t=0).T)
```

Matplotlib includes some other projections, including
[geographic projections](https://matplotlib.org/stable/gallery/subplots_axes_and_figures/geo_demo.html).
More are available through other libraries, like [Cartopy](https://scitools.org.uk/cartopy/).

:::::::::::::::::::::::::::::::::::::::: challenge

Make the appropriate plot for the plasma density.
Note that the SWPC dashboard actually has a 2D plot of the number density times $(r/\mathrm{1 AU})^2$
and remember to convert the mass density array by using the attributes.

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::: solution

Here's a fairly complete solution I used to check I'd understood the density units correctly.

```python
proton_mass = 1.6726e-27
fig, ax = plt.subplots(subplot_kw={'projection': 'polar'})
lower = ds['dd13_3d'].attrs['dd13_min']
upper = ds['dd13_3d'].attrs['dd13_max']
data = ds['dd13_3d'].isel(t=0).astype(float).astype(float)  # otherwise max-min overflows
density = (data - data.min())/(data.max() - data.min())*(upper-lower) + lower
density = density/proton_mass/1e6
r = ds['x_coord']/1.49e11
phi = ds['z_coord']
cm = ax.pcolormesh(phi, r, r**2*density, cmap='jet', vmin=0, vmax=22.5)
plt.colorbar(cm)
```

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Matplotlib provides many plot functions for 2D data.
- Matplotlib provides several built in projections.

::::::::::::::::::::::::::::::::::::::::::::::::::
