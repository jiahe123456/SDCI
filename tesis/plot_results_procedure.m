function plot_results_procedure(SPECTRAL_FILENAME, BANDS_FOLDER, MOSAICO_FOLDER)
    %SPECTRAL_FILENAME = the .mat file where all the spectral signs are
    %stored
    %BANDS_FOLDER = the directory where the bands images where saved
    %MOSAICO_FOLDER = the directory where the Mosaico Pics where saved
    BANDS_FOLDER=strcat(BANDS_FOLDER, '/');
    plot_band_values(SPECTRAL_FILENAME, BANDS_FOLDER);
    MOSAICO_FOLDER=strcat(MOSAICO_FOLDER, '/');
    mosaico(SPECTRAL_FILENAME, MOSAICO_FOLDER);
end