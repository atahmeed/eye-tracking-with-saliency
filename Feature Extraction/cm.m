clc; clear all;
load('SALMAPS3.mat');
% SALMAPS = SALMAPS_SHAFIN_SIR;
% sal_model = "CovSal";
img_index = [];
for i=1:100
    img_index = [img_index convertCharsToStrings(SALMAPS(i).imageNumber)];
end
clearvars -except SALMAPS img_index;
% load('SHAFINSIRSALMAPS2.mat');
SALMAPS = rmfield(SALMAPS,'ContextAware');

sal_model = "Wavelet";
take_original=true;
take_half= true;
take_quarter=true;


AUC_Judd_final=zeros(41,3);
AUC_Shuffled_final=zeros(41,3);
M=10;
AUC_Borji_final=zeros(41,3);
CC_final=zeros(41,3);
KLdiv_final=zeros(41,3);
NSS_final=zeros(41,3);
sim_final=zeros(41,3);
infogain_final=zeros(41,3);
EMD_final=zeros(41,3);
for sub=1:41
    disp("Starting "+int2str(sub));   % verbose
    disp("-------------------")
    AUC_Judd_s=[];AUC_Judd_h=[];AUC_Judd_q=[];
    AUC_Shuffled_s=[];AUC_Shuffled_h=[];AUC_Shuffled_q=[];
    M=10;
    AUC_Borji_s=[];AUC_Borji_h=[];AUC_Borji_q=[];
    CC_s=[];CC_h=[];CC_q=[];
    KLdiv_s=[];KLdiv_h=[];KLdiv_q=[];
    NSS_s=[];NSS_h=[];NSS_q=[];
    sim_s=[];sim_h=[];sim_q=[];
    infogain_s=[];infogain_h=[];infogain_q=[];
    EMD_s=[];
    
    
    fxp_dir=".\Subjectwise_fixpoints\"+int2str(sub);
    filespts = dir(fullfile(fxp_dir, '*.jpg'));
    for i=1:size(filespts,1)
        fxp = imread(convertStringsToChars(fxp_dir+"\"+filespts(i).name));
        fxp = double(fxp);
%         fxp = imresize(fxp,0.25);
        fxm = run_antonioGaussian(fxp,10);
        disp("Image "+int2str(i));
        Sal_map = SALMAPS(find(img_index==filespts(i).name)).(sal_model);
%         Sal_map = imresize(Sal_map,0.25);
        [salmap_w,salmap_h] = size(Sal_map);
        Fix = imresize(fxp,[salmap_w salmap_h]);
        FixD = imresize(fxm,[salmap_w salmap_h]);
        Fix(Fix<0)=0;
        FixD(FixD<0)=0;
%         disp('Calculating AUC_JUDD');
        
        
        
%         disp('Calculating AUC_Shuffled');
        Fix_other = zeros(salmap_w,salmap_h);
        for q = 1:M
            r = randi(100);
            get_random_im = double(imread(convertStringsToChars(fxp_dir+"\"+filespts(randi(45)).name)));
            Fix_cropped = imresize(get_random_im,[salmap_w salmap_h] );
            Fix_cropped(Fix_cropped<0)=0;
            Fix_other = double(Fix_other) + Fix_cropped;
        end
        Fix_other(Fix_other>=255)=255;

        Fix_base = zeros(salmap_w,salmap_h);

        for l = 1:100
            if l~=i
                get_img_serially = double(imread(convertStringsToChars(fxp_dir+"\"+filespts(randi(45)).name)));
                Fix_cropped = imresize(get_img_serially,[salmap_w salmap_h]);
                Fix_cropped(Fix_cropped<0)=0;
                Fix_base = double(Fix_base) + Fix_cropped;
            end
        end
        Fix_base(Fix_base>=255)=255;
        if(take_half)
            AUC_Judd_h =[AUC_Judd_h AUC_Judd(imresize(Sal_map,0.5),imresize(Fix,0.5))];
            AUC_Shuffled_h = [AUC_Shuffled_h AUC_shuffled(imresize(Sal_map,0.5),imresize(Fix,0.5),imresize(Fix_other,0.5))];
            AUC_Borji_h = [AUC_Borji_h AUC_Borji(imresize(Sal_map,0.5),imresize(Fix,0.5))];
            CC_h = [CC_h CC(imresize(Sal_map,0.5),imresize(FixD,0.5))];
            KLdiv_h = [KLdiv_h KLdiv(imresize(Sal_map,0.5),imresize(FixD,0.5))];
            NSS_h = [NSS_h NSS(imresize(Sal_map,0.5),imresize(Fix,0.5))];
            infogain_h = [infogain_h InfoGain(imresize(Sal_map,0.5), imresize(Fix,0.5), imresize(Fix_base,0.5))];
        end
%         disp('Calculating info_gain');

        if(take_original)
            AUC_Judd_s =[AUC_Judd_s AUC_Judd(Sal_map,Fix)];
            AUC_Shuffled_s = [AUC_Shuffled_s AUC_shuffled(Sal_map,Fix,Fix_other)];
            AUC_Borji_s = [AUC_Borji_s AUC_Borji(Sal_map,Fix)];
            CC_s = [CC_s CC(Sal_map,FixD)];
            KLdiv_s = [KLdiv_s KLdiv(Sal_map,FixD)];
            NSS_s = [NSS_s NSS(Sal_map,Fix)];
            infogain_s = [infogain_s InfoGain(Sal_map, Fix, Fix_base)];
        end
        if(take_quarter)
            AUC_Judd_q =[AUC_Judd_q AUC_Judd(imresize(Sal_map,0.25),imresize(Fix,0.25))];
            AUC_Shuffled_q = [AUC_Shuffled_q AUC_shuffled(imresize(Sal_map,0.25),imresize(Fix,0.25),imresize(Fix_other,0.25))];
            AUC_Borji_q = [AUC_Borji_q AUC_Borji(imresize(Sal_map,0.25),imresize(Fix,0.25))];
            CC_q = [CC_q CC(imresize(Sal_map,0.5),imresize(FixD,0.5))];
            KLdiv_q = [KLdiv_q KLdiv(imresize(Sal_map,0.25),imresize(FixD,0.25))];
            NSS_q = [NSS_q NSS(imresize(Sal_map,0.25),imresize(Fix,0.25))];
            infogain_q = [infogain_q InfoGain(imresize(Sal_map,0.25), imresize(Fix,0.25), imresize(Fix_base,0.25))];
   
        end
    end
    AUC_Judd_final(sub,1)= mean(AUC_Judd_s);
    AUC_Shuffled_final(sub,1)= mean(AUC_Shuffled_s);
    AUC_Borji_final(sub,1) = mean(AUC_Borji_s);
    CC_final(sub,1)= mean(CC_s);
    KLdiv_final(sub,1)= mean(KLdiv_s);
    NSS_final(sub,1)= mean(NSS_s);
%     sim_final(sub,1)= mean(sim_final);
    infogain_final(sub,1)= mean(infogain_s);
%     EMD_final(sub,1)= mean(EMD_s);
    
    AUC_Judd_final(sub,2)= mean(AUC_Judd_h);
    AUC_Shuffled_final(sub,2)= mean(AUC_Shuffled_h);
    AUC_Borji_final(sub,2) = mean(AUC_Borji_h);
    CC_final(sub,2)= mean(CC_h);
    KLdiv_final(sub,2)= mean(KLdiv_h);
    NSS_final(sub,2)= mean(NSS_h);
%     sim_final(sub,1)= mean(sim_final);
    infogain_final(sub,2)= mean(infogain_h);
%     EMD_final(sub,2)= mean(EMD_h);
    
    AUC_Judd_final(sub,3)= mean(AUC_Judd_q);
    AUC_Shuffled_final(sub,3)= mean(AUC_Shuffled_q);
    AUC_Borji_final(sub,3) = mean(AUC_Borji_q);
    CC_final(sub,3)= mean(CC_q);
    KLdiv_final(sub,3)= mean(KLdiv_q);
    NSS_final(sub,3)= mean(NSS_q);
%     sim_final(sub,1)= mean(sim_final);
    infogain_final(sub,3)= mean(infogain_q);
%     EMD_final(sub,3)= mean(EMD_q);
    
end


result = [AUC_Borji_final(:,1)  AUC_Judd_final(:,1) AUC_Shuffled_final(:,1) CC_final(:,1) infogain_final(:,1) KLdiv_final(:,1) NSS_final(:,1)];
result_half = [AUC_Borji_final(:,2)  AUC_Judd_final(:,2) AUC_Shuffled_final(:,2) CC_final(:,2) infogain_final(:,2) KLdiv_final(:,2) NSS_final(:,2)];
result_quarter = [AUC_Borji_final(:,3)  AUC_Judd_final(:,3) AUC_Shuffled_final(:,3) CC_final(:,3) infogain_final(:,3) KLdiv_final(:,3) NSS_final(:,3)];
result = real(result);
result_half = real(result_half);
result_quarter = real(result_quarter);