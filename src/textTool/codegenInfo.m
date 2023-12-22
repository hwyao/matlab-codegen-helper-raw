% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function txt = codegenInfo(lang)
%CODEGENINFO generate the information connected to the codegen
%functionality
    
    v = ver('matlab');
    release = v.Release;

    archstr = computer('arch');
    ext = mexext;

    cc = mex.getCompilerConfigurations(lang,'Selected');
    compiler = cc.Name;

    nl = newline;
    txtPadding = [nl,'  '];

    txt = ['  Release: ',release,txtPadding, ...
           'Architecture: ',archstr,txtPadding, ...
           'Mex extension: ',ext,txtPadding, ...
           'Language: ',lang,txtPadding, ...
           'Compiler: ',compiler,nl,nl];
end

