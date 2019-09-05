from PIL import Image
from glob import glob
import numpy as np
from matplotlib import pyplot as plt


def numpyToVector(numpyArray):
	vector=[]
	for (i, j), value in np.ndenumerate(numpyArray):
		vector.append(numpyArray[i][j])
	return vector

def mixBands(first_band, second_band):
	result = first_band
	for (i, j), value in np.ndenumerate(first_band):
		pass


def main():
	#all_landsat_post_bands = glob(
	#"coldspringsfire/landsat_collect/LC080340322016072301T1-SC20180214145802/crop/*band*.tif")
	all_landsat_post_bands = glob(
		"LC080090582019081801RT-SC20190823150055/*band*.tif")
	all_landsat_post_bands.sort()
	landsat_band_data=[]

	for band in all_landsat_post_bands:
		landsat_band_data.append(plt.imread(band))
	print(landsat_band_data[0][2000][2000])
"""	fig, ax = plt.subplots(7, 7)
	fig.set_size_inches(15, 15)

	ax[0, 0].matshow(landsat_band_data[0], cmap='viridis')
	ax[1, 0].matshow(landsat_band_data[1], cmap='viridis')
	ax[2, 0].imshow(landsat_band_data[2], cmap='viridis')
	ax[3, 0].imshow(landsat_band_data[3], cmap='viridis')
	ax[4, 0].imshow(landsat_band_data[4], cmap='viridis')
	ax[5, 0].imshow(landsat_band_data[5], cmap='viridis')
	ax[6, 0].imshow(landsat_band_data[6], cmap='viridis')
	plt.show()
"""
main()