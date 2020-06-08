function band = compose_band(PSH_DIR, BAND, dimen, TYPE)
band=uint16(zeros(dimen*7, dimen*7));
for i=0:6
    for j=0:6
        is=num2str(i+1); %Donde voy en i
        js=num2str(j+1); %Donde voy en j
        filename=strcat(PSH_DIR, '/', is, '_', js);
        data=load(filename);
        if strcmp(TYPE, 'PSH')
            data=data.I_BDSD;
        elseif strcmp(TYPE, 'MS')
            data=data.sub_I_MS;
        else
            data=data.sub_I_PAN;
        end
        band((1+i*dimen):(dimen*(i+1)), (1+j*dimen):(dimen*(j+1)))=data(:, :, BAND);
    end
end
end