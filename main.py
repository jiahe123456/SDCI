import os
import numpy as np
# File manipulation
from glob import glob

import matplotlib.pyplot as plt
import matplotlib as mpl

import rasterio as rio
import geopandas as gpd
import earthpy as et
import earthpy.spatial as es
import earthpy.plot as ep

#os.chdir(os.path.join(et.io.HOME, 'earth-analytics'))

mpl.rcParams['figure.figsize'] = (10, 10)
mpl.rcParams['axes.titlesize'] = 20

all_landsat_post_bands = glob(
	"coldspringsfire/landsat_collect/LC080340322016072301T1-SC20180214145802/crop/*band*.tif")
all_landsat_post_bands.sort()

titles = ["Ultra Blue", "Blue", "Green", "Red", "NIR", "SWIR 1", "SWIR 2"]

array_stack, meta_data = es.stack(all_landsat_post_bands, nodata=-9999)

NDVI = es.normalized_diff(array_stack[4], array_stack[3])

fig, ax = plt.subplots(figsize=(20, 20))

ep.plot_rgb(array_stack, rgb=(5, 4, 3), ax=ax, title="Landsat 8 RGB Image")
ep.plot_bands(NDVI, scale=False, cmap="RdYlGn")
ep.plot_bands(array_stack, title=titles, cols=4)
plt.show()