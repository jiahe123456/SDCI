function readtiff_ms_procedure(TIFF_DIR, BANDS, MATLAB_FILE_DIR)
clc;
fprintf('Starting to reading files\n');

Bands=BANDS;
MS_Bands=cell(Bands);
%TIFF_DIR MUST BE THE PATH OF THE .TIF FILES WITHOUT UNTIL THE LAST 'B'
for i=1:Bands
    is=num2str(i);
    filename=strcat(TIFF_DIR, is, '.TIF');
    [MS_Bands{i}, ~]=geotiffread(filename);
end

fprintf('Reading images succed\nStarting to creating Multi Spectral Matlab File\n');

% N=7731;
% M=7581;
[N, M]=size(MS_Bands{1}); %The 2D dimensions of the image
MS_I=uint16(zeros(N, M, Bands));

for k=1:Bands
    for i=1:N
        for j=1:M
            MS_I(i, j, k)=MS_Bands{k}(i,j);
        end
    end
end

fprintf('Image created succesfuly, starting to save the Matlabfile\n');
save(MATLAB_FILE_DIR', 'MS_I', '-v7.3');
fprintf('Data saved succesfuly\n');
end