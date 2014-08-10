addpath('ncut_spectral_clustering');
addpath('extract_mask');
addpath('util');

crop_para.crop_dim_x = 160;
crop_para.crop_dim_y = 160;
save('crop_para.mat', 'crop_para');

% Put training data set into 'train_orig_img' folder, the segments will go
% into 'train_mask' folder
segImg_batch('./train_orig_img/','*.jpg', './train_mask/')
baseline_patch('./train_mask/', '*.png','./preprocessed/',0.1);

% Baseline preprocess will output positive masks into 'preprocessed' folder
% then you will need to classify them into 'train_mask_pos' and
% 'train_mask_neg' folders manually, then run the following parts to train
% a support vector machine.

pause;
mask_pos = ReadImgs('train_mask_pos','*.png');
mask_pos_v = reshape(mask_pos, size(mask_pos,1), ...
    size(mask_pos, 2)*size(mask_pos, 3));
mask_neg = ReadImgs('train_mask_neg','*.png');
mask_neg_v = reshape(mask_neg, size(mask_neg,1), ...
    size(mask_neg, 2)*size(mask_neg, 3));
 

trainData = [mask_pos_v ; mask_neg_v];
class_pos = ones(1,size(mask_pos,1));
class_neg = -1.*ones(1,size(mask_neg,1));
class = [class_pos class_neg];
SVMStruct = svmtrain (trainData, class);
save('SVM','SVMStruct');