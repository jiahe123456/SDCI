import numpy as np
import PIL
from glob import glob
from PIL import Image
import matplotlib.pyplot as plt
from statistics import mean
from statistics import stdev
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
	all_landsat_bands_coca = glob(
	'AOI-espectro/coca/coca_p1_band*.tif')
	landsat_img_arroz=[]
	landsat_img_cana=[]
	landsat_img_coca=[]

	landsat_data_arroz=[]
	landsat_data_cana=[]
	landsat_data_coca=[]

	band_vectors_arroz=[]
	band_vectors_cana=[]
	band_vectors_coca=[]

	cana_bottom_limits=[181, 243, 531, 339, 2281, 1339, 558]
	cana_top_limits=[567, 658, 960, 1081, 3812, 2644, 1982]
	arroz_bottom_limits=[27, 158, 354, 168, 696, 175, 115]
	arroz_top_limits=[720, 830, 1123, 1430, 4060, 3363, 2236]
	coca_bottom_limits=[180, 243, 503, 402, 2815, 1708, 809]
	coca_top_limits=[282, 340, 623, 568, 3364, 2195, 1095]

	M=len(all_landsat_bands_arroz)
	for i in range(M):
		landsat_img_arroz.append(Image.open(all_landsat_bands_arroz[i]))
		landsat_img_cana.append(Image.open(all_landsat_bands_cana[i]))
		landsat_img_coca.append(Image.open(all_landsat_bands_coca[i]))

		landsat_data_arroz.append(np.array(landsat_img_arroz[i]))
		landsat_data_cana.append(np.array(landsat_img_cana[i]))
		landsat_data_coca.append(np.array(landsat_img_coca[i]))

		band_vectors_cana.append(matrix2vector(landsat_data_cana[i], cana_bottom_limits[i], cana_top_limits[i]))
		band_vectors_arroz.append(matrix2vector(landsat_data_arroz[i], arroz_bottom_limits[i], arroz_top_limits[i]))
		band_vectors_coca.append(matrix2vector(landsat_data_coca[i], coca_bottom_limits[i], coca_top_limits[i]))
	x=[i+1 for i in range(7)]
	y=[mean(band_vectors_arroz[i]) for i in range(7)]
	y1=[mean(band_vectors_cana[i]) for i in range(7)]
	y2=[mean(band_vectors_coca[i]) for i in range(7)]

	ySD=[stdev(band_vectors_arroz[i]) for i in range(7)]
	y1SD=[stdev(band_vectors_cana[i]) for i in range(7)]
	y2SD=[stdev(band_vectors_coca[i]) for i in range(7)]

	for i in range(7):
		print("*__Banda "+str(i+1)+": "+str(y[i])+" - "+str(ySD[i])+"__")
	for i in range(7):
		print("*__Banda "+str(i+1)+": "+str(y1[i])+" - "+str(y1SD[i])+"__")
	for i in range(7):
		print("*__Banda "+str(i+1)+": "+str(y2[i])+" - "+str(y2SD[i])+"__")
"""
	plt.subplot(2, 1, 1)
	plt.plot(x, y, '-g', label='arroz')
	plt.plot(x, y1, '-b', label='caña')
	plt.plot(x, y2, '-r', label="coca")
	plt.legend()

	plt.subplot(2, 1, 2)
	plt.plot(x, ySD, 'go', label="stdev arroz")
	plt.plot(x, y1SD, 'bo', label="stdev caña")
	plt.plot(x, y2SD, 'ro', label="stdev coca")
	plt.legend()
	plt.show()
"""

main()
