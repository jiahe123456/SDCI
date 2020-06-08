clear;
clc;

t=tic;

%Here goes the filename of the nc files, the file to load the matrix of
%latitude and longitude

ncFilename='/media/ruben4181/Games/Putumayo/nc/LC08_L1TP_008060_20171211_20171223_01_T1.nc';

lon=ncread(ncFilename, 'lon');

fprintf('Longitude NC File readed on %.2f seconds\n', toc(t));

%Here goes the excel file that have the coords of each coca crop in the
%area
excelFilename='/media/ruben4181/Games/Putumayo/Centroides/putumayo_est.xls';
data=xlsread(excelFilename);
[L, ~]=size(data);

%delta=1.1369e-07/2; %delta caqueta
delta=1.3482e-04/2; %delta putumayo

count=0;

t=tic;

lonOK=cell(L, 2);

total=tic;

for i=1:L
    % 13 Columna con el valor "x" (longitud) del punto
    % 14 Columna con el valor "y" (latitud) del punto
    [x, y]=find(lon>=data(i, 13)-delta & lon <=(data(i, 13))+delta);
    if ~isempty(x)
        count=count+1;
        lonOK{count}={i, unique(x)};
    end
end

clear lon;

t=tic;

lat=ncread(ncFilename, 'lat');

fprintf('Latitude NC File readed on %.2f seconds\n', toc(t));


%delta=2e-08; %delta caqueta
delta=6.1670e-08/2; %delta putumayo
latOK=cell(L, 2);
count2=0;
for i=1:L
    % 13 Columna con el valor "x" (longitud) del punto
    % 14 Columna con el valor "y" (latitud) del punto
    [x, y]=find(lat>=data(i, 14)-delta & lat <=(data(i, 14))+delta);
    if ~isempty(x)
        count2=count2+1;
        latOK{count2}={i, unique(y)};
    end
end
tCount=1;
allOK=cell(min(count, count2), 2);
%Merge latitude and longitude results

c1=1;
c2=1;
c3=0;

while c1<=count && c2<=count2
    if lonOK{c1}{1}==latOK{c2}{1}
        c3=c3+1;
        allOK{c3}={lonOK{c1}{2}, latOK{c2}{2}};
        c1=c1+1;
        c2=c2+1;
    elseif lonOK{c1}{1}<latOK{c2}{1}
        c1=c1+1;
    else
        c2=c2+1;
    end
end

clear data;
clear lat;
clear lonOK;
clear latOK;

fprintf('\n%d puntos encontrados exitosamente en %.2f segundos\n', c3, toc(total));
outFoldername='/media/ruben4181/Games/Putumayo/results/';
outFilename='puntos_i_j_putumayo_20171211.mat';
outPath=strcat(outFoldername, outFilename);
save(outPath, 'allOK', '-v7.3');