function merge_pixels_procedure(LONLAT_DIR, PIXELS_OUT)
%filename of the i_j points obtained on search_data script
filename=LONLAT_DIR;
data=load(filename);
%lonLat is the name of the variable with the cell that contains i_j points
lonLat=data.lonLat;
[L, ~]=size(lonLat);

pixels=zeros(L, 2);

for i=1:L
    pixels(i, 1)=floor(mean(lonLat{i, 1}));
    pixels(i, 2)=floor(mean(lonLat{i, 2}));
end

filename=PIXELS_OUT;
save(filename, 'pixels', '-v7.3');