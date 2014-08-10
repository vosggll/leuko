function cluster = baseline(cluster, threshold_percentage, img_output)
% This function performs a pre-process that excludes clusters having too
% much adjacent area to the border.
% Input: cluster, mask data corresponding to clusters from image
%        segmentation.
%        threshold_percentage, percent of the threshold
%        img_output, switch on outputing image.
% Ouptut: Binary masks corresponding to derived clusters.
if (exist('crop_para','var') == 0)
    load ('crop_para.mat');
end
shapesize = 2 * (crop_para.crop_dim_x + crop_para.crop_dim_y);
threshold = threshold_percentage * shapesize;
clustersize = size(cluster,3);
for i = 1:clustersize
img = cluster(:,:,i);
if (border_num(img, 1) > threshold)
    cluster(:,:,i) = NaN;
    if (img_output == 1)
    imwrite(img, strcat(num2str(i),'n.png'));
    end
else
    img = imfill(img,'holes');
    if (img_output == 1)
    imwrite(img, strcat(num2str(i),'p.png'));
    end
    cluster(:,:,i) = img;
end
end