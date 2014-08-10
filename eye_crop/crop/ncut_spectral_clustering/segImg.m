function cluster = segImg(filename, img_output)
% This function use spectral clusteirng method to segment the given image.
% Input: File name.
%        img_output, switch on outputing image.
% Output: Binary masks corresponding to derived clusters.
I = imread_ncut(filename,160,160);
nbSegments = 6;
[SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);
labelvector = unique(SegLabel);
cluster = zeros(size(SegLabel,1), size(SegLabel,2), labelvector);
for j = 1:length(labelvector)
    mask = (SegLabel==j);
    img = ones(size(SegLabel));
    img(not(mask)) = 0;
    cluster(:,:,j) = img;
    if (img_output == 1)
        imwrite(img,  strcat(filename(1:length(filename)-4), '_', int2str(j), '.png'));
    end
end
