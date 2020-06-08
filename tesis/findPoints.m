clear all
clc

data=xlsread('/media/ruben4181/Games/Tesis/shp/Centroides coca Cauca 16 17.xlsx');

[L, ~]=size(data);

points= zeros(L, 2);

for i=1:L
    points(i, 1)=data(i, 12);
    points(i, 2)=data(i, 13);
end


t=tic;

N=15181;
M=15501;
%coords=zeros(N, M, 2);
lon=ncread('/media/ruben4181/Games/LC08_L1TP_009058_20160825_20170322_01_T1.nc', 'lon');
lat=ncread('/media/ruben4181/Games/LC08_L1TP_009058_20160825_20170322_01_T1.nc', 'lat');
%t_reading=toc(t);
%fprintf('Time reading: %.2f [sec]\n', t_reading);
b1=lon(1,1);
b2=lon(1, 15501);
dif=((b2-b1)/15501)*8;
dif=dif/1000;
b1=lat(1,1);
b2=lat(15181, 1);
dif2=((b2-b1)/15181)*8;
count=1;

pixels=cell(L, 2);

for i=1:L
    [x, y]=find(lon>=points(i, 1)-dif & lon<=points(i, 1)+dif);
    if ~isempty(x)
        [R, S]=size(x);
        for k=1:R
            if(lat(x(k), y(k))>=points(i, 2)-dif2 && lat(x(k), y(k))<=points(i,2)+dif2)
                if ~(count>L)
                    pixels{count, 1}=x(k);
                    pixels{count, 2}=y(k);
                    count=count+1;
                else
                    break
                end
            end
        end
        if(count>L)
            break
        end
    end
end