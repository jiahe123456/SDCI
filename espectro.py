import numpy as np
import PIL
from glob import glob
from PIL import Image
import matplotlib.pyplot as plt
from statistics import mean

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
	all_landsat_bands_arroz = glob(
	'AOI-espectro/arroz/arroz_band*.tif')
	all_landsat_bands_arroz.sort()
	all_landsat_bands_cana = glob(
	'AOI-espectro/cana/cana_band*.tif')
	landsat_img_arroz=[]
	landsat_img_cana=[]
	landsat_data_arroz=[]
	landsat_data_cana=[]
	band_vectors_arroz=[]
	band_vectors_cana=[]
	cana_bottom_limits=[181, 243, 531, 339, 2281, 1339, 558]
	cana_top_limits=[567, 658, 960, 1081, 3812, 2644, 1982]
	arroz_bottom_limits=[27, 158, 354, 168, 696, 175, 115]
	arroz_top_limits=[720, 830, 1123, 1430, 4060, 3363, 2236]
	M=len(all_landsat_bands_arroz)
	for i in range(M):
		landsat_img_arroz.append(Image.open(all_landsat_bands_arroz[i]))
		landsat_img_cana.append(Image.open(all_landsat_bands_cana[i]))

		landsat_data_arroz.append(np.array(landsat_img_arroz[i]))
		landsat_data_cana.append(np.array(landsat_img_cana[i]))

		band_vectors_cana.append(matrix2vector(landsat_data_cana[i], cana_bottom_limits[i], cana_top_limits[i]))
		band_vectors_arroz.append(matrix2vector(landsat_data_arroz[i], arroz_bottom_limits[i], arroz_top_limits[i]))

	x=[i+1 for i in range(7)]
	y=[0 for _ in range(7)]
	y1=[0 for _ in range(7)]
	for i in range(M):
		y[i]=mean(band_vectors_arroz[i])
		y1[i]=mean(band_vectors_cana[i])
	plt.plot(x, y, '-g', label='arroz')
	plt.plot(x, y1, '-b', label='caña')
	plt.legend()
	plt.show()
main()
