clear
clc

parameterCell = {{1,2}};
codegenVararg = {};
outputPath = [pwd,'/build/']; % the code is robust to accept [pwd,'/build']

codegenRun("adder",parameterCell,codegenVararg,outputPath=outputPath);