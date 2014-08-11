function result = ccNumFilter(mask)
% Test if mask has only one connected component.
% Output: true if it has only one connected component.
Bw = imfill(mask,'holes');
se = strel('ball',5,5);
Bw = imdilate(Bw,se);
Bw = im2bw(Bw, 0.5);
CC = bwconncomp(Bw);
result = (CC.NumObjects == 1);
return 