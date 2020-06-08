%Script to apply pansharpenign algorithm from a PAN image and a MS image
function pansharp_procedure(MS_DIR, PAN_DIR, PSH_DIR)
baseMSFileName=MS_DIR;
basePANFileName=PAN_DIR;
basePSHFileName=PSH_DIR;

% for Ni=1:subImages
%     for Mi=1:subImages
for Ni=1:7
    for Mi=1:7
        fprintf('Now working on subimage [%d, %d]\n', Ni, Mi);
        t=tic;

        is=int2str(Ni);
        js=int2str(Mi);

        fprintf('Starting to reading PAN and MS images\n');
        MS_filename = strcat(baseMSFileName, is, '_', js, '.mat');
        PAN_filename = strcat(basePANFileName, is, '_', js, '.mat');
        
        DATA_I_MS=load(MS_filename);
        DATA_I_PAN=load(PAN_filename);

        I_MS_N=DATA_I_MS.sub_I_MS;
        I_PAN=DATA_I_PAN.sub_I_PAN;

        %figure
        %imshow(I_PAN);
        
        [N, M, B]=size(I_MS_N);

        I_MS=uint16(zeros(N*2, M*2, B));

        %upscaled to the MS_I at PAN_I scale
        for i=1:B
            I_MS(:,:,i)=repelem(I_MS_N(:,:,i), 2, 2);
        end

        clear I_MS_N;
        
        %figure
        %imshow(I_MS(:,:,5));

        clear DATA_I_MS;
        clear DATA_I_PAN;

        fprintf('Time reading images : %.2f [sec]\n', toc(t));

        t=tic;

        fprintf('Starting pansharpening procces\n');

        ratio=4;
        sensor='LANDSAT8';
        cd '/home/ruben4181/Pansharpening Tool ver 1.3/BDSD'
        I_BDSD = uint16(BDSD(I_MS,I_PAN,ratio,128,sensor));

        %figure
        %imshow(I_BDSD(:,:,5));

        time_PANALG=toc(t);
        fprintf('Pansharpening finished succesfully: %.2f seconds\n', time_PANALG);
        fprintf('Saving pansharped image as .mat file\n');
        t=tic;
        PSH_filename = strcat(basePSHFileName, is, '_', js, '.mat');
        save(PSH_filename', 'I_BDSD', '-v7.3');
        time_SAVING=toc(t);
        fprintf('Pansharped image saved succesfully: %.2f seconds', time_SAVING);
        clear I_BDSD;
    end
end
clear
load handel
sound(y, Fs);