function extractedMask = testSVM(SVMStruct, cluster, crop_para)
% This function use given SVM to classify each mask in the cluster
% Input: SVMStruct, trained Support vector machine.
%        cluster, mask data corresponding to clusters from image
%        segmentation.
%        crop_para, crop parameter
% Output: the extracted mask
img_mask_union = zeros(crop_para.crop_dim_x, crop_para.crop_dim_y);
for i = 1:size(cluster,3)
    svmr = svmclassify(SVMStruct, ...
        reshape(cluster(:,:,i), 1, ...
        crop_para.crop_dim_x * crop_para.crop_dim_y));
    if (svmr == 1)
        img_mask_union = img_mask_union + cluster(:,:,i);
    end
end
extractedMask = img_mask_union;