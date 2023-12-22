% Copyright 2023 Haowen Yao
%
% This file is part of the matlab-codegen-helper-raw repository.
% 
%     Use of this source code is governed by an MIT-style
%     license that can be found in the LICENSE file or at
%     https://opensource.org/licenses/MIT.

function codegenRun(functionName,parameterCell,codegenVararg,option)
% CODEGENRUN - run the codegen function with some helpful framework.
%
% CODEGENRUN(functionName,parameterCell,codegenVararg,option)
%
% Input:
%  functionName: the function name for codegen to generate
%  parameterCell: the cell for cell for function parameter. The double layered cell is designed to 
%    parameterCell = {{1,2}}  -> -args,{1,2}
%    parameterCell = {{1,2},{int32(1),int32(2)}} -> -args, {1,2}, -args, {int32(1),int32(2)} 
%  codegenVararg: the parameter that could be directly passed to codegen.
%    Be careful when using -o paramater, it might have conflict with the parameter 
%    generated from option.outputPath and option.outputName, unless you leave them both empty.
%  option: optional parameter that controls some minor behaviour.
%    See source argument list to check for the details.
%
    arguments
        functionName(1,:) char
        parameterCell(1,:) cell
        codegenVararg(1,:) cell

        % output configuration
        option.outputPath(1,:) char = ''          % the output mex folder destination. Left blank for current root folder, we strongly suggest to use full path.
        option.outputName(1,:) char = ''          % the output mex name. Left blank for default output (func - func_mex).
        option.outputComment(1,1) logical = true  % automatically generate a commend file alongside the codegen toolbox.
        
        % automated execution configuration (tbd)
        option.enableModify(1,1) logical = false  % execute automated script to modify code before the comparison
        option.enableCheck(1,1) logical = true    % check if there are some code that is obviously incompitable with codegen
        option.enableTest(1,1) logical = false    % use matlab test to compare the difference between two functions.
        
        % logging (tbd)
        option.logLevel(1,:) char {mustBeMember(option.logLevel,{'INFO','DEBUG'})} = 'INFO' % the logging level in command window
    end

    % prepare argument parameter block
    nCell = numel(parameterCell);
    argCell = cell(1, 2*nCell);
    for iCell = 1:nCell
        iCurrent = iCell * 2 - 1;
        argCell{iCurrent} = '-args';
        argCell{iCurrent + 1} = parameterCell{iCell};
    end

    % prepare codegen named argument
    if ~(isempty(option.outputPath) && isempty(option.outputName))
        if ismember({'-o'},codegenVararg)
            error("Either use -o in codegenVararg, or use outputPath and outputName as non-empty value!")
        end

        if option.outputPath(end) ~= '/'
            option.outputPath = [option.outputPath,'/'];
        end

        if exist(option.outputPath,"dir") ~= 7
            mkdir(option.outputPath)
        end

        if isempty(option.outputName)
            option.outputName = [functionName,'_mex'];
        end
        
        outputPathValue = [option.outputPath,option.outputName];
        codegenVararg = [codegenVararg,{'-o',outputPathValue}];
    end

    if option.enableModify == true %tbd
    end
    
    if option.enableCheck == true  %tbd
    end

    % generate mex file
    codegen(functionName,argCell{:},codegenVararg{:});

    % generate comment for mex file
    if option.outputComment == true
        language = 'C';
        if ismember({'-lang:c++'},codegenVararg)
            language = 'C++';
        end
        txt = generateComment(codegenVararg,functionName,option.outputName,parameterCell,language);
        fid = fopen([option.outputPath,option.outputName,'.m'],'w');
        if fid == -1
            error("Cannot open file %s for writing!",[option.outputPath,option.outputName,'.m'])
        else
            fprintf(fid,"%s",txt);
            fclose(fid);
        end
    end

    if option.enableTest == true   %tbd
    end
end

