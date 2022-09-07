function concatenatedMat = concatenateMat(mat1, mat2, method)
% concatenatedMat = concatenateMat(mat1, mat2, method)
%
% Function concatenates two matrices of any dimensions by appending the
% smaller matrix with trailing zeros or NaNs.
% Input: mat1.
%        mat2.
%        method - concatenate either vertically ('vertical') or
%                 horizontally ('horizontal'). This input is optional and
%                 the default method is vertical. In case when trailing
%                 NaNs are needed rather than zeros, corresponding methods
%                 are 'verticalnan' and 'horizontalnan', respectively.
% Output: concatenatedMat.

if nargin < 3
  method = 'vertical';
end

if ~isempty(mat1) && ~isempty(mat2)
  if strcmp(method, 'vertical')
    diff = size(mat1,2) - size(mat2,2);
    if diff > 0
      trailingMat = zeros(size(mat2,1), abs(diff));
      mat2 = [mat2 trailingMat];
    elseif diff < 0
      trailingMat = zeros(size(mat1,1), abs(diff));
      mat1 = [mat1 trailingMat];
    end
    concatenatedMat = [mat1; mat2];
  elseif strcmp(method, 'horizontal')
    diff = size(mat1,1) - size(mat2,1);
    if diff > 0
      trailingMat = zeros(abs(diff), size(mat2,2));
      mat2 = [mat2; trailingMat];
    elseif diff < 0
      trailingMat = zeros(abs(diff), size(mat1,2));
      mat1 = [mat1; trailingMat];
    end
    concatenatedMat = [mat1 mat2];
  elseif strcmp(method, 'verticalnan')
    diff = size(mat1,2) - size(mat2,2);
    if diff > 0
      trailingMat = nan(size(mat2,1), abs(diff));
      mat2 = [mat2 trailingMat];
    elseif diff < 0
      trailingMat = nan(size(mat1,1), abs(diff));
      mat1 = [mat1 trailingMat];
    end
    concatenatedMat = [mat1; mat2];
  elseif strcmp(method, 'horizontalnan')
    diff = size(mat1,1) - size(mat2,1);
    if diff > 0
      trailingMat = nan(abs(diff), size(mat2,2));
      mat2 = [mat2; trailingMat];
    elseif diff < 0
      trailingMat = nan(abs(diff), size(mat1,2));
      mat1 = [mat1; trailingMat];
    end
    concatenatedMat = [mat1 mat2];
  end
elseif ~isempty(mat1) && isempty(mat2)
  concatenatedMat = mat1;
elseif isempty(mat1) && ~isempty(mat2)
  concatenatedMat = mat2;
else
  concatenatedMat = [];
end