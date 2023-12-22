% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function txt = parameterInfo(parameterCell)
%PARAMETERINFO convert the content in parameterCell to readable text
%containing the size, value and type.
    
    txt = '';
    nl = newline;

    nCell = numel(parameterCell);
    for iCell = 1:nCell
        txt = [txt, '  Parameter set ', num2str(iCell), ': ',nl];  %#ok<*AGROW>
        currentCell = parameterCell{iCell};
        nParam = numel(currentCell);
        for iParam = 1:nParam
            % size
            txt = [txt, '    ', mat2str(size(currentCell{iParam})), ' ']; 
            % type
            txt = [txt, class(currentCell{iParam}), ': '];
            % value
            txt = [txt, jsonencode(currentCell{iParam}), nl];
        end
    end

    txt = [txt, nl];
end

