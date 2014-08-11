function mergedImg = mergeImg(filename, img_mask_union, crop_para)
% This function applies the mask on the original image file with given name
% Input: filename, original image file
%        img_mask_union, mask data
%        crop_para, crop parameter
% Output: merged image
mergedImg = imresize(imread(filename),[crop_para.crop_dim_x,crop_para.crop_dim_y]);
img_mask_union = img_mask_union(:,:,[1,1,1]);
mergedImg(not(img_mask_union)) = 0;