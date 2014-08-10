function segImg_batch(filepath, fileformat, outputpath)
% This function use spectral clusteirng method to segment the given image
% in a batch fashion.
% Input: filepath, Original image's folder path.
%        fileformat, input file format, like '*.jpg'
%        outputpath, output image path.
% Output: Binary masks corresponding to derived clusters.
files = dir(strcat(filepath, fileformat));
for file = files'
    img_file_name = strcat(filepath,file.name);
    I = imread_ncut(img_file_name,160,160);
    nbSegments = 6;
    [SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);
    
    labelvector = unique(SegLabel);
    for j = 1:length(labelvector)
        mask = (SegLabel==j);
        %img = I;
        img = SegLabel;   % for mask
        img(not(mask)) = 0;
        imwrite(img,  strcat(outputpath, file.name(1:length(file.name)-4), '_', int2str(j), '.png'));
        
        %imwrite(img./255,  strcat('./leuko_seg/seg_', int2str(i), '_', int2str(j), '.png'));
    end
end