function readtiff_pan_procedure(TIFF_DIR, MATLAB_FILE_DIR)
clc;
fprintf('Starting to reading files\n');

[PAN_I, ~] = geotiffread(TIFF_DIR);

fprintf('Reading images succed\nStarting to creating Multi Spectral Matlab File\n');

save(MATLAB_FILE_DIR', 'PAN_I', '-v7.3');
fprintf('Data saved succesfuly\n');
end