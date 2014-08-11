function [concaveResult, ccNumResult, centroidDistResult, ...
    aspectRatioResult] = assertValidity(mask, testConcave, testCCNum, ...
    testCentroidDist, testAspectRatio, x, y)
% This function performs an array of filter tests. See each subfunction for
% more details.
% Input: mask, the mask data to be tested.
%        testConcave, set true if you want to test concave.
%        testCCNum, set true if you want to test connected component.
%        testCentroidDist, set true if you want to test centoid offset.
%        testAspectRatio, set true if you want to test aspect ratio.
%        x & y, relative coordinates required by centroid offset test.

if (testConcave)
    concaveResult = concaveFilter(mask);
end

if (testCCNum)
    ccNumResult = ccNumFilter(mask);
end

if (testCentroidDist)
    if (nargin ~= 7)
        disp('Should provide ground true of the centroid.');
        centroidDistResult = false;
    else
        %relative coordinates are required.
        centroidDistResult = centroidDistFilter(mask, x, y);
    end
else
    centroidDistResult = false;
end

if (testAspectRatio)
    aspectRatioResult = aspectRatioFilter(mask);
end
