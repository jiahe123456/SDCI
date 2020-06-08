function img_pre_process(TIF_FILE, BANDS, FOLDER, DATE)
%TIF_FILE = path of one tif file until last 'B' character
%BANDS = number of bands for multispectral image
%FOLDER = path of the file where all files will be save e.g. Caqueta_nubes
%DATE = date when image was captured in format YYYYMMdd
MATLAB_FILES='/MS_PAN_MAT/';
MATLAB_MS_FILE_DIR=strcat(FOLDER, MATLAB_FILES, 'MS_', DATE, '.mat');

readtiff_ms_procedure(TIF_FILE, BANDS, MATLAB_MS_FILE_DIR);
clearvars -except TIF_FILE MATLAB_FILES BANDS FOLDER DATE MATLAB_MS_FILE_DIR;

%path of the PAN Image in tiff format
PAN_FILE=strcat(TIF_FILE, '8.TIF');

%path were the PAN IMAGE on matlab format will be saved
MATLAB_PAN_FILE_DIR=strcat(FOLDER, MATLAB_FILES, 'PAN_', DATE, '.mat');

readtiff_pan_procedure(PAN_FILE, MATLAB_PAN_FILE_DIR);
clearvars -except TIF_FILE BANDS MATLAB_FILES FOLDER DATE MATLAB_MS_FILE_DIR MATLAB_PAN_FILE_DIR;

SUB_SPLITED_PAN_DIR=strcat(FOLDER, '/Splited_', DATE, '/PAN/');
DIMEN=2048;
I_TYPE='PAN';

split_image_procedure(MATLAB_PAN_FILE_DIR, SUB_SPLITED_PAN_DIR, DIMEN, I_TYPE);
clearvars -except TIF_FILE BANDS FOLDER DATE MATLAB_FILES MATLAB_MS_FILE_DIR MATLAB_PAN_FILE_DIR SUB_SPLITED_PAN_DIR;

SUB_SPLITED_MS_DIR=strcat(FOLDER, '/Splited_', DATE, '/MS/');
I_TYPE='MS';
DIMEN=1024;
split_image_procedure(MATLAB_MS_FILE_DIR, SUB_SPLITED_MS_DIR, DIMEN, I_TYPE);

clearvars -except TIF_FILE BANDS FOLDER DATE MATLAB_FILES MATLAB_MS_FILE_DIR MATLAB_PAN_FILE_DIR SUB_SPLITED_PAN_DIR SUB_SPLITED_MS_DIR;

SUB_SPLITED_PSH_DIR=strcat(FOLDER, '/Pansharp_', DATE, '/');
pansharp_procedure(SUB_SPLITED_MS_DIR, SUB_SPLITED_PAN_DIR, SUB_SPLITED_PSH_DIR);
clear;
end