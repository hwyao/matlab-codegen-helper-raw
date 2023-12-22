% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function txt = repoInfo()
%REPOINFO get the repository information 
% Now it is only the connection to the repository. Some other information like 
% branch, commit, etc. can be added later.
    txt = ['  This MEX file is compiled from the hwyao/matlab-codegen-helper-raw repository.', newline];
end

