% fixptsdir = uigetdir(pwd, 'Select a folder');
files = dir(fullfile(fixptsdir, '*.jpg'));

for sub = 1:41
    disp("Subject"+int2str(sub));
    inpath = "Subjectwise_fixpoints/"+int2str(sub);
    outpath = "Subjectwise_fixmaps/"+int2str(sub);
    files = dir(fullfile(inpath, '*.jpg'));
    for i =1:size(files,1)
        disp("Image"+int2str(i));
        im = imread(convertStringsToChars(inpath+"\"+files(i).name));
        out = run_antonioGaussian(im,12);
        imwrite(out,convertStringsToChars(outpath+"\"+files(i).name));
    end
end

% fixmapdir = uigetdir(pwd, 'Select a folder');
% 
% for i =1:size(files,1)
%     disp(i);
%     a = imread(convertStringsToChars(fixptsdir+"\"+files(i).name));    
%     out = run_antonioGaussian(a,12);
%     imwrite(out, convertStringsToChars(fixmapdir+"\"+files(i).name))
% end