function result =  border_num(x, val)
% This function calculate the number of entries on four borders of a matrix
% equaling the given value.
% Input: x, the matrix to be evaluated.
%        val, the value want to be checked.
% Output: result, the number of entries equaling to the given value val
%         on four borders of the matrix x.
[m,n] = size(x);
result = sum(x(1,:) == val);
result = result + sum(x(m,:) == val);
result = result + sum(x(:,1) == val);
result = result + sum(x(:,n) == val);