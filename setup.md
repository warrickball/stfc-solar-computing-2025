---
title: Setup
---

## Data Sets

SWPC provides the latest WSA-Enlil snapshot in [this remote folder](https://nomads.ncep.noaa.gov/pub/data/nccf/com/wsa_enlil/prod/),
linked from the "Data" tab of the dashboard.  Go to that folder, click on the oldest date,
and download the file with a name that ends `.suball.nc`.  It should be about 130MB in size.

## Software Setup

The course material presumes you'll use [JupyterLab](https://jupyter.org/).
You may wish to edit and run your code in another way that you're familiar with (e.g. an *integrated development environment*, IDE)
but the instructors might not be able to help with questions specific to the software you're using.

If you already have Python installed, you can probably use that.
(If your operating system is Linux, you almost certainly already have Python installed.)
You might need to [install JupyterLab](https://jupyter.org/install) and some other Python packages but we'll point to these along the way.

If you don't have a Python distribution installed, we recommend [Miniforge](https://conda-forge.org/download/).
The best-tested method here is to follow the [instructions in the main Carpentries course](https://carpentries.github.io/workshop-template/#python-1) for your operating system.
Ask an instructor if you have a problem.

If you're specifically using one of the University of Birmingham lab computers, then you should be able to install Miniforge by using AppsAnywhere as follows:

1. Open [AppsAnywhere](https://apps.bham.ac.uk) from the Windows Desktop.
2. Login to your University of Birmingham Microsoft account when prompted.
3. Allow the browser to open the AppsAnywhere browser.
4. In the search bar, search for "miniforge", which should bring up something like "Miniforge Python 24.3.0-0 with All school addons".
5. Select "Launch" next to Miniforge or on its description page.
6. When ready, launch Miniforge by pressing the Launch icon or double-clicking.
7. This brings up a file folder, where you should double-click on "Jupyter Lab (Network drive)".
