function mosaico(SPECTRAL_FILENAME, MOSAICO_FOLDER)
data=load(SPECTRAL_FILENAME);
spectral_info=data.spectral_info;
bands=7;
baseFilename=MOSAICO_FOLDER;
for i=1:bands
    for j=1:bands
        figure1=figure;
        axes1=axes('Parent', figure1);
        hold(axes1, 'all');
        plot(spectral_info(:, i), spectral_info(:, j), '.r');
        is=num2str(i);
        js=num2str(j);
        labelX=strcat('Banda ', is);
        labelY=strcat('Banda ', js);
        xlabel(labelX);
        ylabel(labelY);
        filename=strcat(baseFilename, is, '_', js, '.png');
        saveas(figure1, filename);
    end
end
end