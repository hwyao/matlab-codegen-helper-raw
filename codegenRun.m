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
        parameterCell(1,:) cell {mustBeParameterCell(parameterCell)}
        codegenVararg(1,:) cell

        % output configuration
        option.outputPath(1,:) char = ''          % the output mex folder destination. Left blank for current root folder, we strongly suggest to use full path.
        option.outputName(1,:) char = ''          % the output mex name. Left blank for default output (func - func_mex).
        option.outputComment(1,1) logical = true  % automatically generate a commend file alongside the codegen toolbox.
        option.globalCell(1,:) cell {mustBeGlobalCell(option.globalCell)} = {}       % tell the codegen use the global variable

        % automated execution configuration (tbd)
        option.enableModify(1,1) logical = false  % execute automated script to modify code before the comparison
        option.enableCheck(1,1) logical = true    % check if there are some code that is obviously incompitable with codegen
        option.enableTest(1,1) logical = false    % use matlab test to compare the difference between two functions.
        
        % logging (tbd)
        option.logLevel(1,:) char {mustBeMember(option.logLevel,{'INFO','DEBUG'})} = 'INFO' % the logging level in command window
    end

    % prepare the variables
    codegenVarargFinal = codegenVararg;

    % prepare argument parameter block
    nCell = numel(parameterCell);
    argCell = cell(1, 2*nCell);
    for iCell = 1:nCell
        iCurrent = iCell * 2 - 1;
        argCell{iCurrent} = '-args';
        argCell{iCurrent + 1} = parameterCell{iCell};
    end
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
        codegenVarargFinal = [codegenVarargFinal,{'-o',outputPathValue}];
    end

    % prepare global parameter block
    if ~isempty(option.globalCell)
        option.globalCell = {'-global',option.globalCell};
        codegenVarargFinal = [codegenVarargFinal, option.globalCell];
    end

    if option.enableModify == true %tbd
    end
    
    if option.enableCheck == true  %tbd
    end

    % generate mex file
    codegen(functionName,argCell{:},codegenVarargFinal{:});

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

function mustBeParameterCell(parameterCell)
    mustBeA(parameterCell,'cell')
    for iCell = 1:numel(parameterCell)
        try
            mustBeA(parameterCell{iCell},'cell')
        catch ME
            msg = [ME.message, newline, newline, ...
                   'Hint: Each element of the parameterCell must be also a cell demonstrating all parameters.', newline, ...
                   'e.g {{1,2},{int(1),int(2)}}', newline, ...
                   'Element number ', num2str(iCell), ' cannot satisfy.'];
            causeException = MException('MATLAB:codegenRun:mustBeParameterCell',msg);
            throw(causeException)
        end
    end
end

function mustBeGlobalCell(globalCell)
    mustBeA(globalCell,'cell')
    nCell = numel(globalCell);
    try
        mustBeInteger(nCell/2);
    catch ME
        msg = [newline,...
               'The length of the globalCell must be even.', newline,...
               'Current length ', num2str(nCell), ' cannot satisfy.'];
        causeException = MException('MATLAB:codegenRun:mustBeGlobalCell',msg);
        throw(causeException)
    end
    for iCell = 1:(nCell/2)
        iCellUse = 2 * iCell - 1;
        try
            mustBeA(globalCell{iCellUse},{'char','string'})
        catch ME
            msg = [ME.message, newline, newline, ...
                'Hint: The input should be repeated combination of text and value.', newline, ...
                'e.g {"a",1,''b'',3}', newline, ...
                'Element number ', num2str(iCellUse), ' cannot satisfy.'];
            causeException = MException('MATLAB:codegenRun:mustBeParameterCell',msg);
            throw(causeException)
        end
    end
end
