function cluster = segImg(filename, imwriteon)
% This function use spectral clusteirng method to segment the given image.
% Input: File name.
% Output: Binary masks corresponding to derived clusters.
addpath('ncut_spectral_clustering');
I = imread_ncut(filename,160,160);
nbSegments = 6;
[SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);
labelvector = unique(SegLabel);
cluster = zeros(size(SegLabel,1), size(SegLabel,2), labelvector);
for j = 1:length(labelvector)
    mask = (SegLabel==j);
    img = SegLabel;
    img(not(mask)) = 0;
    cluster(:,:,j) = img;
    if (imwriteon == 1)
        imwrite(img,  strcat(filename(1:length(filename)-4), '_', int2str(j), '.png'));
    end
end
