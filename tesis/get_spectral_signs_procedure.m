function get_spectral_signs_procedure(ALLOK_FILENAME, PSH_DIR, FOLDER, AOI, DATE)
%ALLOK = path where the result of search_data_procedure were saved
%PSH_DIR = the splited pansharped images directory path
%FOLDER = the "results" folder that must contain AllOK, LonLat and Pixels
%subdirectories
%AOI = The name of the region of the satellite image e.g. 'Guaviare'
%DATE = The date when the sattelite image was captured

OUT_FILENAME=strcat(FOLDER, '/LonLat/', AOI, '_', DATE, '.mat');
convertAllOK(ALLOK_FILENAME, OUT_FILENAME);

clearvars -except OUT_FILENAME ALLOK_FILENAME PSH_DIR FOLDER AOI DATE;

LONLAT_DIR=OUT_FILENAME;
PIXELS_FILENAME=strcat(FOLDER, '/Pixels/', AOI, '_pixels_', DATE, '.mat');
merge_pixels_procedure(LONLAT_DIR, PIXELS_FILENAME);

clearvars -except PIXELS_FILENAME OUT_FILENAME ALLOK_FILENAME PSH_DIR FOLDER AOI DATE;

OUT_FILENAME=strcat(FOLDER, '/spectral_info_', DATE, '.mat');
get_ms_info_procedure(PIXELS_FILENAME, PSH_DIR, OUT_FILENAME);

clearvars -except OUT_FILENAME ALLOK_FILENAME PSH_DIR FOLDER AOI DATE;

no_zeros_procedure(OUT_FILENAME);
end