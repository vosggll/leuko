function baseline_patch(filepath, fileformat, outputpath, threshold_percentage)
% This function performs a pre-process that excludes clusters having too
% much adjacent area to the border.
% Input: filepath, input mask image.
%        fileformat, input file format, like '*.png'
%        outputpath, output image path.
%        threshold_percentage, percent of the threshold
if (exist('crop_para','var') == 0)
load ('crop_para.mat');
end
shapesize = 2 * (crop_para.crop_dim_x + crop_para.crop_dim_y);
threshold = threshold_percentage * shapesize;
files = dir(strcat(filepath, fileformat));
for file = files'
    img_file_name = strcat(filepath, file.name);
    img = imread(img_file_name);
    if (border_num(img, 255) > threshold)
        %imwrite(img, strcat(outputpath, file.name(1:length(file.name)-4),'.png'));
    else
        img = imfill(img,'holes');
        imwrite(img, strcat(outputpath, file.name(1:length(file.name)-4),'.png'));
    end
end