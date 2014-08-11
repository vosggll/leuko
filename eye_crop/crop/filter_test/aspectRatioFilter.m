function result = aspectRatioFilter(mask)
% This function returns the aspect ratio of a given image.
% input: 
%    path: the path of the binary image.
% output:
%    AR: the aspect ratio.

s = regionprops( mask, 'BoundingBox' );
AR1 = s(end).BoundingBox(4) / s(end).BoundingBox(3); 
AR2 = s(end).BoundingBox(3) / s(end).BoundingBox(4); 
AR = max(AR1, AR2);
result = (AR < 5);