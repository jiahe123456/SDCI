function no_zeros_procedure(SPECTRAL_FILENAME)
filename=SPECTRAL_FILENAME;
load(filename);
c=0;
[L, bands]=size(spectral_info);
ceros=uint16(ones(1, L));
unos=logical(zeros(1, L));

for i=1:L
    if 0<spectral_info(i, 1) && 0<spectral_info(i, 3) && 0<spectral_info(i,7)
        unos(i)=1;
    end
end

tmp=spectral_info(unos, :);
spectral_info=tmp;
if contains(SPECTRAL_FILENAME, '.mat')
    fprintf('Existe un .mat');
    SPECTRAL_FILENAME=SPECTRAL_FILENAME(1:length(SPECTRAL_FILENAME)-4);
end
filename=strcat(SPECTRAL_FILENAME, '_NO_ZEROS.mat');
save(filename, 'spectral_info', '-v7.3');
