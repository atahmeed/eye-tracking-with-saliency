% clear all; clc;
% load('age_pred.mat');
% 
% % FIX_PTS_SUBJECT = {};
% % FIX_MAP_SUBJECT = {};
% % disp('fixpoints and map\n');
% % for i=1:41
% %     disp(i);
% %     fxp = imread(convertStringsToChars("../dataset/merged/fixpts/subject_"+int2str(i)+".jpg"));
% %     fxm = imread(convertStringsToChars("../dataset/merged/fixmap/subject_"+int2str(i)+".jpg"));
% %     fxp_d = double(fxp);
% %     fxm_d = double(fxm);
% %     FIX_PTS_SUBJECT{i} = fxp_d;
% %     FIX_MAP_SUBJECT{i} = fxp_d;
% % end
% 
% SALMAPS = struct();
% salmodels = ["CEOS","LDS","UHM","GBVS","SimpSal","SigSal"];
% disp('saliency map\n');
% for i=1:size(salmodels,2)
%     disp(salmodels(i));
%     p = "../Saliency/"+salmodels(i)+"/";
%     files = dir(fullfile(convertStringsToChars(p), '*.jpg'));
%     for j =1:size(files,1)
%         disp(p+files(j).name);
%         salmap = double(imread(convertStringsToChars(p+files(j).name)));
%         SALMAPS(j).(salmodels(i)) = salmap;
%         if i==1
%             SALMAPS(j).imageNumber = files(j).name;
%         end
%     end    
% end
% 
% clearvars -except subject_image FIX_PTS_SUBJECT FIX_MAP_SUBJECT SALMAPS;
% 
% save('age_pred.mat')








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 
% 
% clear all; clc;
% % load('age_pred.mat');
% 
% FIX_PTS_18 = {};
% FIX_MAP_18 = {};
% FIX_PTS_30 = {};
% FIX_MAP_30 = {};
% 
% disp('fixpoints and map\n');
% fixptsdir18 = uigetdir(pwd, 'Select a folder');
% filespts18 = dir(fullfile(fixptsdir18, '*.jpg'));
% fixptsdir30 = uigetdir(pwd, 'Select a folder');
% filespts30 = dir(fullfile(fixptsdir30, '*.jpg'));
% 
% for i=1:size(filespts18,1)
%     disp(i);
%     fxp = imread(convertStringsToChars(fixptsdir18+"\"+filespts18(i).name));
%     fxp_18 = double(fxp);
%     fxm_18 = run_antonioGaussian(fxp_18,12);
%     FIX_PTS_18{i} = fxp_18;
%     FIX_MAP_18{i} = fxm_18;
% end
% 
% for i=1:size(filespts30,1)
%     disp(i);
%     fxp = imread(convertStringsToChars(fixptsdir30+"\"+filespts30(i).name));
%     fxp_30 = double(fxp);
%     fxm_30 = run_antonioGaussian(fxp_30,12);
%     FIX_PTS_30{i} = fxp_30;
%     FIX_MAP_30{i} = fxm_30;
% end
% 
% 
% SALMAPS = struct();
% salmodels = ["CEOS","LDS","UHM","GBVS","SimpSal","SigSal"];
% disp('saliency map\n');
% for i=1:size(salmodels,2)
%     disp(salmodels(i));
%     p = "../Saliency/"+salmodels(i)+"/";
%     files = dir(fullfile(convertStringsToChars(p), '*.jpg'));
%     for j =1:size(files,1)
%         disp(p+files(j).name);
%         salmap = double(imread(convertStringsToChars(p+files(j).name)));
%         SALMAPS(j).(salmodels(i)) = salmap;
%         if i==1
%             SALMAPS(j).imageNumber = files(j).name;
%         end
%     end    
% end
% 
% clearvars -except subject_image FIX_PTS_18 FIX_PTS_30 FIX_MAP_30 FIX_MAP_18 SALMAPS;
% 
% save('age_pred_image_wise.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('age_pred_image_wise.mat');
clearvars -except SALMAPS;
save('SALMAPS.mat');


