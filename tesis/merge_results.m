clear
clc

%filename of the i_j points obtained on search_data script
filename='/media/ruben4181/Games/Putumayo/results/puntos_i_j_putumayo_20171112.mat';
load(filename);
%lonLat is the name of the variable with the cell that contains i_j points
[L, ~]=size(lonLat);

pixels=zeros(L, 2);

for i=1:L
    pixels(i, 1)=floor(mean(lonLat{i, 1}));
    pixels(i, 2)=floor(mean(lonLat{i, 2}));
end

outFolder='/media/ruben4181/Games/Putumayo/results/';
filename=strcat(outFolder, 'pixels_20171211.mat');
save(filename, 'pixels', '-v7.3');