import earthpy.spatial as es
import numpy as np
import PIL
import earthpy.plot as ep
from glob import glob
from PIL import Image
import matplotlib.pyplot as plt

def realValue(bottom, top, value):
	l=top-bottom
	relate=l/255
	return relate*value+bottom

def matrix2vector(npArray, bottom, top):
	result=[]
	n, m, v = npArray.shape
	for i in range(n):
		for j in range(m):
			result.append(realValue(bottom, top, npArray[i][j][0]))
	return result

def main():
	all_landsat_post_bands = glob(
	#'AOI/cana_band*.tif')
	'AOI/arroz_band*.tif')
	all_landsat_post_bands.sort()
	landsat_img=[]
	landsat_data=[]
	band_vectors=[]
	for i in  range(len(all_landsat_post_bands)):
		landsat_img.append(Image.open(all_landsat_post_bands[i]))
		landsat_data.append(np.array(landsat_img[i]))
		#band_vectors.append(matrix2vector(landsat_data[i], cana_bottom_limits[i], cana_top_limits[i]))
		band_vectors.append(matrix2vector(landsat_data[i], arroz_bottom_limits[i], arroz_top_limits[i]))
	fig, ax = plt.subplots(1, 7)
	fig.set_size_inches(30, 30)

	naip_ndvi = es.normalized_diff(landsat_data[3], landsat_data[0])
	ep.plot_bands(naip_ndvi, cmap="PiYG", scale=False, vmin=-1, vmax=1)
	plt.show()
main()