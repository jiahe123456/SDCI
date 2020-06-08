function get_ms_info_meta_procedure(PIXELS_FILENAME, PSH_DIR, OUT_FILENAME)
%File that store the i, j position of coca crops in some specific region
pixelsFilename=PIXELS_FILENAME;
load(pixelsFilename);
pixels=double(pixels);

dimen=2048; %Clipped size of PansharpedImage (Because of BDSD Algorithm limitations)
subImagesN=7; %Number of subimages
nMax=dimen*subImagesN; %Maximun iterator index on clipped images
bands=7; %number of bands in PansharpedImage

[L, ~]=size(pixels); %L is the total of found points (i, j pair of positions)

spectral_info=ones(L, bands+2);

count=0;

basePSHFilename=strcat(PSH_DIR, '/');
is='';
js='';

for i=1:L
    if pixels(i, 1) < nMax && pixels(i, 2)<nMax
        count=count+1;
        i_img=floor(pixels(i, 1)/(dimen))+1;
        j_img=floor(pixels(i, 2)/(dimen))+1;
        i_data=mod(pixels(i, 1), (dimen));
        j_data=mod(pixels(i, 2), (dimen));
        if i_data==0
            i_img=i_img-1;
            i_data=dimen;
        end
        if j_data==0
            j_img=j_img-1;
            j_data=dimen;
        end
        if i==1 || (i_img ~= uint16(str2double(is)) || j_img ~= uint16(str2double(js)))
            clear I_BDSD;
            is=num2str(i_img);
            js=num2str(j_img);
            filename=strcat(basePSHFilename, is, '_', js, '.mat');
            load(filename);
        end
        for j=1:bands
            spectral_info(count, j)=I_BDSD(i_data, j_data, j);
        end
        spectral_info(count, bands+1)=pixels(i, 3);
        spectral_info(count, bands+2)=pixels(i, 4);
    end
end

filename=OUT_FILENAME;
save(filename, 'spectral_info', '-v7.3');
load handel
sound(y, Fs);