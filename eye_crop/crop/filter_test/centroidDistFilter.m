function result = centroidDistFilter(mask, x, y)
% Test if the centroid (x, y) is further than the given ground truth
% Input: mask, mask data
%        x & y, relative coordinates.
% Output: result, true if offset is within the threshold
Ilabel = bwlabel(mask);
stat = regionprops(Ilabel,'centroid');
%plot(stat.Centroid(1),stat.Centroid(2),'ro');
x1 = stat.Centroid(1);
y1 = stat.Centroid(2);
dim = min(crop_para.crop_dim_x, crop_para.crop_dim_y);
dist = euclidDistance(x1, y1, x, y)/dim;
result = (dist < 0.2);
  