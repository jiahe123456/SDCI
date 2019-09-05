import numpy as np
import PIL
from glob import glob
from PIL import Image
import matplotlib.pyplot as plt

def matrix2vector(npArray):
	result=[]
	for (i, j), value in np.ndenumerate(npArray):
		result.append(value)
	return result

def main():
	all_landsat_post_bands = glob(
	"coldspringsfire/landsat_collect/LC080340322016072301T1-SC20180214145802/crop/*band*.tif")
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
	"""ax[0, 0].imshow(landsat_data[0])
	ax[1, 0].imshow(landsat_data[1])
	ax[2, 0].imshow(landsat_data[2])
	ax[3, 0].imshow(landsat_data[3])
	ax[4, 0].imshow(landsat_data[4])
	ax[5, 0].imshow(landsat_data[5])
	ax[6, 0].imshow(landsat_data[6])"""


	for i in range(7):
		ax[i].plot(band_vectors[0], band_vectors[i], 'ro')
	plt.show()
main()