---
title: "Exploring the WSA Enlil data"
teaching: 10
exercises: 5
---

:::::::::::::::::::::::::::::::::::::::: questions

- What are some main formats for sharing data?
- How do I explore a given data set?

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: objectives

- Know which libraries are suitable for some common data types.
- Practice exploring a dataset.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Common data formats

For small amounts of data, it's common to use simple formats that are quite easy for people to view directly
(e.g. comma-separated values = CSV).
For large amounts of numerical data, it's more common to use formats that efficiently encode numbers
rather than writing them out as text.  Some common formats for this are:

- The [Hierarchical Data Format](https://www.hdfgroup.org/solutions/hdf5/) v5 (HDF5).
  Everything in an HDF5 file is either a dataset or a group, which can nest other groups or datasets.
  Groups and datasets can have attributes.
  The standard Python library for working with them is [h5py](https://www.h5py.org/).

- The [Network Common Data Form](https://www.unidata.ucar.edu/software/netcdf/),
  usually v4 (netCDF4) though I still occasionally find v3.
  NetCDF4 is actually implemented using HDF5.
  The standard Python library for working with the files directly is
  [netcdf4-python](https://unidata.github.io/netcdf4-python/).

- The [Flexible Image Transport System (FITS)](https://heasarc.gsfc.nasa.gov/docs/heasarc/fits.html)
  is (still!) widely used for astronomical images.  You can handle these files using
  [Astropy's FITS module](https://docs.astropy.org/en/latest/io/fits/index.html).

## Exploring the WSA Enlil file

We're going to work with data from the WSA Enlil solar wind model provided by the SWPC
[WSA Enlil Solar Wind dashboard](https://www.swpc.noaa.gov/products/wsa-enlil-solar-wind-prediction).
Under the main plot, you should see a set of tabs, of which the fifth is "Data".
Click on that and then follow the link to the
[model output files for the last 48 hours](https://nomads.ncep.noaa.gov/pub/data/nccf/com/wsa_enlil/prod/).
There, click on either date and download a file that ends with `.suball.nc`,
where the final `.nc` is the usual extension for netCDF4 files.
It should be about 131MB.

If you search online about reading netCDF4 files, you'll probably find the
[netCDF4 Python library](https://unidata.github.io/netcdf4-python/).
We'll use a higher-level library called [Xarray](https://xarray.dev/).

```python
import xarray as xr
ds = xr.load_dataset('wsa_enlil.mrid00000000.suball.nc')
print(ds)
print(ds.attrs)        # these produce quite a lot of output
print(ds.data_vars)
```

```output
<xarray.Dataset> Size: 138MB
Dimensions:               (x: 512, y: 60, z: 180, t: 169, earth_t: 13166)
Dimensions without coordinates: x, y, z, t, earth_t
Data variables: (12/50)
    x_coord               (x) float32 2kB 1.519e+10 1.566e+10 ... 2.541e+11
    y_coord               (y) float32 240B 0.5411 0.576 0.6109 ... 2.566 2.601
    z_coord               (z) float32 720B 0.01745 0.05236 ... 6.231 6.266
    time                  (t) float32 676B -1.727e+05 -1.691e+05 ... 4.32e+05
    dd12_3d               (t, y, x) int16 10MB -20419 -21067 ... -32744 -32744
    vv12_3d               (t, y, x) int16 10MB 23687 23506 23602 ... -7065 -6824
    ...                    ...
    STEREO_B_V2           (earth_t) float32 53kB 0.0 0.07604 ... 4.227e+03
    STEREO_B_V3           (earth_t) float32 53kB 0.0 0.2118 ... 1.314e+04
    STEREO_B_B1           (earth_t) float32 53kB 4.713e-09 ... 2.491e-09
    STEREO_B_B2           (earth_t) float32 53kB 0.0 -1.095e-22 ... 1.949e-11
    STEREO_B_B3           (earth_t) float32 53kB 0.0 -1.914e-22 ... -2.306e-09
    STEREO_B_BP_POLARITY  (earth_t) float32 53kB 0.9426 0.9426 ... -0.4937
Attributes: (12/14)
    REFDATE_MJD:           60829.0
    REFDATE_CAL:           2025-06-03T00:00:00
    OBSDATE_MJD:           60829.0
    OBSDATE_CAL:           2025-06-03T00:00:00
    program:               enlil
    enlil_version:         2.9
    ...                    ...
    wsa_vel_file:          wsa.gong.fits
    observatory:           gongb
    model_run_id:          0
    execution_start_time:  2025-06-03 00:05
    PDY:                   20250603
    cyc:                   00

# ...
```

We can access attributes or variables (datasets) by key or attribute.
```python
print(ds['Earth_Density'])
print(ds.Earth_Density)
```
```output
<xarray.DataArray 'Earth_Density' (earth_t: 13166)> Size: 53kB
array([7.546841e-21, 7.546859e-21, 7.546876e-21, ..., 6.989431e-21,
       6.980635e-21, 6.971527e-21], dtype=float32)
Dimensions without coordinates: earth_t
<xarray.DataArray 'Earth_Density' (earth_t: 13166)> Size: 53kB
array([7.546841e-21, 7.546859e-21, 7.546876e-21, ..., 6.989431e-21,
       6.980635e-21, 6.971527e-21], dtype=float32)
Dimensions without coordinates: earth_t
```

NetCDF4 and `xarray.Dataset` objects support named co-ordinates
but they're recorded as data variables in our WSA-Enlil data.
```python
print(ds['coords'])
```

```output
Coordinates:
    *empty*
```

:::::::::::::::::::::::::::::::::::::::: challenge

Let's start making sense of the WSA Enlil data.

1. What are the values of the radial velocity time series, e.g. `'STEREO_A_V1'`?
2. What are the co-ordinates in `{x,y,z}_coord`?
3. What do the `{1,2,3}` indices of the `vv12_3d` data variable mean?
4. What are units of these fields?

Note that none of the answers are particularly easy to find!
It's good practice to embed such metadata in the file but happens to not be the case here.
You can find some of answers by looking at the dimensions associated with each data variable
and by comparing with the actual SWPC WSA-Enlil dashboard.

::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::: solution

1. You can see the values with `print(ds['STEREO_A_V1'])`.
   They should mostly be between about 300,000 and 700,000.

2. `x`, `y` and `z` correspond to the radial distance from the Sun $r$,
   a heliocentric latitude $\theta$ and
   a heliocentric longitude $\phi$.

3. These indicate which of $r$, $\theta$ and $\phi$ the data variable depends on.
   E.g. `vv12_3d` depends on $r$ and $\theta$, so is a meridional slice.

4. The raw data is stored  as 16-bit signed integers, so range from -32767 to 32768.
   Each variable has attributes `'..._min'` and `'..._max'` that specifies the physical range.
   The data is mostly between about 300,000 and 700,000.
   From the SWPC dashboard, we can see the actual solar wind typically has velocities around 300 to 700 km/s,
   so the data is presumably in m/s.

::::::::::::::::::::::::::::::::::::::::::::::::::

The units of the density variables is much more difficult to infer,
so to save some time I'll just tell you what it is.
Part of this is based on a difficult to find [data note](https://www.ngdc.noaa.gov/stp/enlil/data_note.html)
that links to a plotting script written in the [Interactive Data Language](https://en.wikipedia.org/wiki/IDL_(programming_language)) (IDL), which I used to get some of this information.

The density in the data files is a *mass* (rather than *number*) density in kg/m³.
The plots are of *number* density in 1/cm³ and mass is converted to number by dividing by the mass of a proton.
So, for example, the number density at Earth is
```python
proton_mass = 1.6726e-27
number_density = ds['Earth_Density']/proton_mass/1e6
print(number_density)
```
```output
<xarray.DataArray 'Earth_Density' (earth_t: 13166)> Size: 53kB
array([4.512042 , 4.5120525, 4.5120625, ..., 4.178782 , 4.1735234,
       4.1680775], dtype=float32)
Dimensions without coordinates: earth_t
```

## Broadcasting, selecting and slicing Xarray datasets

Note that Xarray combines datasets along common axes when appropriate.
```python
print(ds['x_coord']**2*ds['dd13_3d'])
```
```
<xarray.DataArray (x: 512, t: 169, z: 180)> Size: 62MB
array([[[-3.15502734e+24, -3.54123933e+24, -3.84827011e+24, ...,
         -1.24589756e+24, -1.85072465e+24, -2.61830117e+24],
        [-3.01213108e+24, -3.43735707e+24, -3.76216301e+24, ...,
         -1.07760792e+24, -1.67920308e+24, -2.40130203e+24],
        [-2.86000107e+24, -3.32793415e+24, -3.67420923e+24, ...,
         -9.10010815e+23, -1.50583481e+24, -2.18199445e+24],
        ...,
        [ 7.92277282e+23,  1.24428171e+23, -1.09469083e+24, ...,
         -2.89901478e+24, -4.70010645e+23,  1.10530995e+24],
        [ 9.18090561e+23,  3.02875253e+23, -7.76579535e+23, ...,
         -3.55947653e+24, -1.17017879e+24,  1.12447050e+24],
        [ 1.01781777e+24,  5.36264612e+23, -3.93830168e+23, ...,
         -3.81271920e+24, -1.74176348e+24,  6.69465057e+23]],

       [[-3.60161437e+24, -3.99699727e+24, -4.28911933e+24, ...,
         -1.71103668e+24, -2.38407046e+24, -3.03797295e+24],
        [-3.45592112e+24, -3.89471757e+24, -4.21210331e+24, ...,
         -1.54449501e+24, -2.19226569e+24, -2.86211092e+24],
        [-3.29403970e+24, -3.77968367e+24, -4.12552121e+24, ...,
         -1.38899083e+24, -2.00168718e+24, -2.67423054e+24],
...
         -2.10546739e+27, -2.10623920e+27, -2.10662511e+27],
        [-2.10681814e+27, -2.10681814e+27, -2.10694682e+27, ...,
         -2.10514568e+27, -2.10611052e+27, -2.10662511e+27],
        [-2.10668945e+27, -2.10681814e+27, -2.10701102e+27, ...,
         -2.10482412e+27, -2.10598198e+27, -2.10656077e+27]],

       [[-2.11013781e+27, -2.11104155e+27, -2.11188081e+27, ...,
         -2.10529576e+27, -2.10678065e+27, -2.10865292e+27],
        [-2.10981492e+27, -2.11084794e+27, -2.11168719e+27, ...,
         -2.10516664e+27, -2.10632878e+27, -2.10820090e+27],
        [-2.10942754e+27, -2.11058968e+27, -2.11142894e+27, ...,
         -2.10516664e+27, -2.10600589e+27, -2.10768454e+27],
        ...,
        [-2.11459233e+27, -2.11472146e+27, -2.11485059e+27, ...,
         -2.11343033e+27, -2.11414046e+27, -2.11439871e+27],
        [-2.11459233e+27, -2.11465697e+27, -2.11472146e+27, ...,
         -2.11304295e+27, -2.11394684e+27, -2.11439871e+27],
        [-2.11459233e+27, -2.11459233e+27, -2.11478610e+27, ...,
         -2.11272021e+27, -2.11388221e+27, -2.11433408e+27]]],
      dtype=float32)
Dimensions without coordinates: x, t, z
```
so we don't have to do as much manual broadcasting if the coordinates are well defined.

We can select axis by axis using NumPy syntax or we can select axes explicitly with `Dataset.isel`.
```python
print(ds['dd13_3d'][0])
print(ds['dd13_3d'].isel(t=0))
```

```output
<xarray.DataArray 'dd13_3d' (z: 180, x: 512)> Size: 184kB
array([[-13667, -14684, -15816, ..., -32680, -32682, -32685],
       [-15340, -16296, -17349, ..., -32696, -32697, -32699],
       [-16670, -17487, -18462, ..., -32709, -32710, -32712],
       ...,
       [ -5397,  -6976,  -8889, ..., -32608, -32609, -32610],
       [ -8017,  -9720, -11388, ..., -32627, -32630, -32633],
       [-11342, -12386, -13773, ..., -32656, -32659, -32662]], dtype=int16)
Dimensions without coordinates: z, x
Attributes:
    dd13_max:  1.8502355e-18
    dd13_min:  8.190748e-22
```

We can slice with `isel` by passing a `slice` object,
where `slice(start, stop, step)` is equivalent to `start:stop:step`
and we can use `None` where we would have blanks.
```
print(ds['dd13_3d'].isel(t=slice(None,5)))
```

:::::::::::::::::::::::::::::::::::::::: keypoints

- Some common binary (not plain-text) formats for numerical data are HDF5, netcdf4 and FITS.
- The corresponding lowest-level Python libraries are h5py, netCDF4 and Astropy.
- Xarray is commonly used to work with netCDF4 data.
- All formats support metadata in attributes that is worth looking for.
- Add useful metadata to your own data!

::::::::::::::::::::::::::::::::::::::::::::::::::
