addpath('ncut_spectral_clustering');
addpath('extract_mask');

crop_para.crop_dim_x = 160;
crop_para.crop_dim_y = 160;
save('crop_para.mat', 'crop_para');

filename = 'test1.jpg';
cluster = segImg(filename, 0);
cluster = baseline(cluster,0.1,0);

load('SVM.mat');
img_mask_union = zeros(crop_para.crop_dim_x, crop_para.crop_dim_y);
for i = 1:size(cluster,3)
    svmr = svmclassify(SVMStruct, ...
        reshape(cluster(:,:,i), 1, ...
        crop_para.crop_dim_x * crop_para.crop_dim_y));
    if (svmr == 1)
        img_mask_union = img_mask_union + cluster(:,:,i);
    end
end


originalimg = imresize(imread(filename),[160,160]);
img_mask_union = img_mask_union(:,:,[1,1,1]);
originalimg(not(img_mask_union)) = 0;
%originalimg = bitand(originalimg,uint8 (img_mask_union));
%imwrite(uint8(img_mask_union),  strcat('./result_pos_maskunion/', prevfilename(5:length(prevfilename)-6), '.png'));

figure;
imshow(originalimg);
imwrite(originalimg,  strcat(filename,'_extracted', '.png'));