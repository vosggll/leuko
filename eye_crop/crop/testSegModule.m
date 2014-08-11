addpath('ncut_spectral_clustering');
addpath('extract_mask');
addpath('filter_test');

crop_para.crop_dim_x = 160;
crop_para.crop_dim_y = 160;
save('crop_para.mat', 'crop_para');

filename = 'test1.jpg';
cluster = segImg(filename, 0);
cluster = baseline(cluster,0.1,0);

load('SVM.mat');

mask = testSVM(SVMStruct, cluster, crop_para);
if max(mask(:))==0
    disp('The SVM does not find a positive mask')
else
    % We can perform some action based on filter test, here we only display
    % the test result
    [concaveResult, ccNumResult, centroidDistResult, ...
    aspectRatioResult] = assertValidity(mask, true, true, ...
    false, true)
    
    mergeImg(filename, mask, crop_para);
    figure;
    imshow(originalimg);
    imwrite(originalimg,  strcat(filename,'_extracted', '.png'));
end