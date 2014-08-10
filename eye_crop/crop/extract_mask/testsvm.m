mask_pos = ReadImgs('train_mask_pos','*.png');
mask_pos_v = reshape(mask_pos, size(mask_pos,1), size(mask_pos, 2)*size(mask_pos, 3));
mask_neg = ReadImgs('train_mask_neg','*.png');
mask_neg_v = reshape(mask_neg, size(mask_neg,1), size(mask_neg, 2)*size(mask_neg, 3));


%s = regionprops( BW, 'BoundingBox' );
%AR = s.BoundingBox(4) / s.BoundingBox(3); 

trainData = [mask_pos_v ; mask_neg_v];

class_pos = ones(1,size(mask_pos,1));
class_neg = -1.*ones(1,size(mask_neg,1));

class = [class_pos class_neg];
SVMStruct = svmtrain (trainData, class);


test_folder_path = 'test_mask_pos'
%test_pos = ReadImgs('./leuko_seg','*.jpg');
%test_pos_v = reshape(test_pos, size(test_pos,1), size(test_pos, 2)*size(test_pos, 3));
%test_neg = ReadImgs('test_mask_neg','*.png');
%test_neg_v = reshape(test_neg, size(test_neg,1), size(test_neg, 2)*size(test_neg, 3));
%result_pos = svmclassify(SVMStruct, test_pos_v)
%result_neg = svmclassify(SVMStruct, test_neg_v)


% merge
%
%
% files = dir('./leuko_seg/*.jpg');
% prevfilename = ' '
% img_out = zeros(160,160);
% for file = files'
%     img_file_name = strcat('./leuko_seg/',file.name);
%     img_mask =  double(imread(img_file_name));
%     if ~strcmp(prevfilename,' ')
%         if ~strcmp(file.name(1:length(file.name)-6),prevfilename(1:length(file.name)-6))
%             display 'out'
%             imwrite(uint8(img_out),strcat('./result_pos/',file.name,'.jpg'));
%             img_out = zeros(160,160);
%         end
%     end
%     prevfilename = file.name;
%     if (svmclassify(SVMStruct, reshape(img_mask, 1, size(img_mask,1)*size(img_mask,2))) == 1)
%         %display 'new pos'
%         img_out = img_out + img_mask;
%     end
% end

%'./leuko_seg_mask'
origin_file_path = './dataset1/';
%files = dir('/*.jpg');
test_folder_path = './result_pos/';
files = dir(strcat(test_folder_path,'*.png'));
size(files)
prevfilename = ' ';
img_mask_union = zeros(160,160);
v_cen_x = zeros(1,1);
v_cen_y = zeros(1,1);
v_area = zeros(1,1);
stat = struct;
v_name = '';
i = 1;
for file = files'
    img_file_name = strcat(test_folder_path,file.name);
    img_mask =  double(imread(img_file_name));
    
    svmr = svmclassify(SVMStruct, reshape(img_mask, 1, size(img_mask,1)*size(img_mask,2)));
    
    
    if (svmr == 1)
        if ~strcmp(prevfilename,' ')
            if  (~strcmp(file.name(1:length(file.name)-6),prevfilename(1:length(prevfilename)-6)))
                
                % originalfilepath: the original file
                originalfilepath = strcat(origin_file_path,prevfilename(5:length(prevfilename)));
                originalfilepath = strcat(originalfilepath(1:length(originalfilepath)-6),'.jpg');
                
                originalimg = imresize(imread(originalfilepath),[160,160]);
                % originalimg(not(img_mask_union)) = 0;
                img_mask_union = img_mask_union(:,:,[1,1,1]);
                originalimg = bitand(originalimg,uint8 (img_mask_union));
                imwrite(uint8(img_mask_union),  strcat('./result_pos_maskunion/', prevfilename(5:length(prevfilename)-6), '.png'));
                %%% imwrite(originalimg,  strcat('./result_pos_origin/', prevfilename(5:length(prevfilename)-6), '.png'));
                cen_img_x = sum(v_cen_x.* v_area)/sum(v_area);
                cen_img_y = sum(v_cen_y.* v_area)/sum(v_area);
                %figure;
                %imshow(originalimg)
                %hold on;
                %plot(cen_img_x,cen_img_y, 'b*');
                stat(i).filename = prevfilename(5:length(prevfilename)-6);
                stat(i).mask_x = cen_img_x;
                stat(i).mask_y = cen_img_y;
                img_mask_union = zeros(160,160);
                v_cen_x = zeros(1,1);
                v_cen_y = zeros(1,1);
                v_area = zeros(1,1);
                i = i + 1;
            end
        end
        img_mask_union = img_mask_union + img_mask;
        prop_seg = regionprops(img_mask, 'basic');
        seg_area = [prop_seg.Area];
        centroid_seg = cat(1, prop_seg.Centroid);
        cen_x = sum(nanzero(centroid_seg(:,1)).* seg_area')/sum(seg_area);
        cen_y = sum(nanzero(centroid_seg(:,2)).* seg_area')/sum(seg_area);
        v_cen_x = [v_cen_x; cen_x];
        v_cen_y = [v_cen_y; cen_y];
        v_area = [v_area; sum(seg_area)];
        %%% imwrite(uint8(img_mask),strcat('./result_pos_2nd/',file.name(1:length(file.name)-4),'.png'));
        prevfilename = file.name;
    end
    if (svmr == -1)
        %%% imwrite(uint8(img_mask),strcat('./result_neg_2nd/',file.name(1:length(file.name)-4),'.png'));
    end
    
end