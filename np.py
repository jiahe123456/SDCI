import numpy as np
import PIL
from glob import glob
from PIL import Image
import matplotlib.pyplot as plt

def matrix2vector(npArray):
	result=[]
	n, m, v = npArray.shape
	for i in range(n):
		for j in range(m):
			result.append(npArray[i][j])
	return result

def main():
	all_landsat_post_bands = glob(
	'AOI/arroz_band*.tif')#"coldspringsfire/landsat_collect/LC080340322016072301T1-SC20180214145802/crop/*band*.tif")
	#all_landsat_post_bands=glob(
	#	"LC080090582019081801RT-SC20190823150055/*band*.tif")
	all_landsat_post_bands.sort()
	landsat_img=[]
	landsat_data=[]
	band_vectors=[]
	for i in  range(len(all_landsat_post_bands)):
		landsat_img.append(Image.open(all_landsat_post_bands[i]))
		landsat_data.append(np.array(landsat_img[i]))
		band_vectors.append(matrix2vector(landsat_data[i]))
	fig, ax = plt.subplots(1, 7)
	fig.set_size_inches(30, 30)

	for i in range(7):
		ax[i].plot(band_vectors[5], band_vectors[i], 'ro')
	plt.show()
main()