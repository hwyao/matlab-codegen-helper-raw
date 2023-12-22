% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function txt = generateComment(codegenVararg, functionName, outputName, parameterCell, language)
%GENERATECOMMENT generate the commend text for a specific function name.
%
%  txt = generateComment(functionName)
%
% Input:
%  functionName: the name of the function (the normal m function.)
%  outputName: the name of the output file (the mex file)
%  parameterCell: the cell array of the parameter used to generate the mex
%  language: the language used to generate the mex file. (usually: 'C', 'C++')
%
% Output:
%  txt: the comment text generated from the text
%
% This function generates the commented text from a specific file. It can
% be used as the comment after generates as MEX file.
% The comment contains:
% - the original comment in the m file
% - the example parameter used to generate the mex file
% - the codegen compiling information
% - the git repository information (if exists)
    arguments
        codegenVararg(1,:) cell
        functionName(1,:) char
        outputName(1,:) char
        parameterCell(1,:) cell
        language(1,:) char {mustBeMember(language,{'C','C++'})}
    end
    
    txtVararg = strjoin(codegenVararg, ' ');
    txtComment = help(functionName);
    txtParameter = parameterInfo(parameterCell);
    txtCodegen = codegenInfo(language);
    txtRepo = repoInfo();
    nl = newline;

    txt = [upper(outputName), ' The MEX function generated from ', functionName,'()', nl, ...
            ' %%%Comment section%%%', nl, txtComment, ...
            ' %%%Parameter section%%%', nl, txtParameter, ...
            ' %%%codegen section%%%', nl, '  varargin: ', txtVararg, nl, txtCodegen, ...
            ' %%%repo section%%%', nl, txtRepo, nl];
    txt = str2comment(txt);
end

