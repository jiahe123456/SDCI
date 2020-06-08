r=load('results_20_11.mat');
points=r.pixels;
clear r;

T=58;
dimen=2048;

basePSHFileName='/media/ruben4181/Games/Putumayo/Pansharp_20160311/';

data=cell(T, 1);

for x=1:T
    i=floor(points{x,1}/dimen);
    j=floor(points{x,2}/dimen);
    if i<7 && j<7
        sub_i=mod(points{x,1}, dimen);
        sub_j=mod(points{x,2}, dimen);

        is=num2str(i+1);
        js=num2str(j+1);

        fileName=strcat(basePSHFileName, is, '_', js, '.mat');

        im=load(fileName);
        I_MS=im.I_BDSD;
        clear im;
        data{x}=I_MS(sub_i, sub_j, :);
    end
end

band1=uint16(zeros(1, 48));
band2=uint16(zeros(1, 48));
band3=uint16(zeros(1, 48));
band4=uint16(zeros(1, 48));
band5=uint16(zeros(1, 48));
band6=uint16(zeros(1, 48));
band7=uint16(zeros(1, 48));
for i=10:58
    