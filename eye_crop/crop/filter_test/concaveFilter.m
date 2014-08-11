function result = concaveFilter(mask)
% This function test if the mask center is within the mask(concave).
% Output: result, true if it is a concave shape.
Ilabel = bwlabel(mask);
stat = regionprops(Ilabel,'centroid');
%plot(stat.Centroid(1),stat.Centroid(2),'ro');
x = stat.Centroid(1);
y = stat.Centroid(2);
result = (mask( uint8(x), uint8(y)) ~= 0);