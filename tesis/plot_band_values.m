function plot_band_values(SPECTRAL_FILENAME, BANDS_DIR)
spectralFilename=SPECTRAL_FILENAME;
data=load(spectralFilename);
spectral_info=data.spectral_info;
bands=7;
[L, ~]=size(spectral_info);
baseFilename=BANDS_DIR;
for i=1:bands
    figure1=figure;
    axes1=axes('Parent', figure1);
    hold(axes1, 'all');
    plot([1:L], spectral_info(1:L, i), '.r');
    labelY=strcat('Radiación electromagnética banda[', num2str(bands), ']');
    labelX=strcat('Numero de muestras banda [', num2str(bands), ']');
    xlabel(labelX);
    ylabel(labelY);
    filename=strcat(baseFilename, num2str(i), '.png');
    saveas(figure1, filename)
end
end