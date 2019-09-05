from osgeo import gdal
import os

inputPath = '/LC080090582019081801RT-SC20190823150055/'
outputPath = '/Output/'
shp_clip = '../Shp/AOI.shp'

bandList=glob(
		"LC080090582019081801RT-SC20190823150055/*band*.tif")
	all_landsat_post_bands.sort()
for band in bandList:
	print(outputPath + band[:-4]+'_c2'+band[-4:])
	options = gdal.WarpOptions(cutlineDSName=shp_clip,cropToCutline=True)
    outBand = gdal.Warp(srcDSOrSrcDSTab=inputPath + band,
                        destNameOrDestDS=outputPath + band[:-4]+'_c2'+band[-4:],
                        options=options)
    outBand=None
#clip image python file
