% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function txtOut = str2comment(txtIn)
%STR2COMMENT add comment(%) in txtIn before each line
%
%  txtOut = STR2COMMENT(txtIn)
%
% Input:
%  txtIn: input text
%
% Output:
%  txtOut: output text that have % before each line.
    expression='\n';
    txtOut = regexprep(txtIn,expression,'\n%');
    txtOut = ['%',txtOut];
end

