clear
clc

parameterCell = {{1,2}};
codegenVararg = {'-launchreport'};
outputPath = [pwd,'/build/']; % the code is robust to accept [pwd,'/build']

codegenRun("adder",parameterCell,codegenVararg,outputPath=outputPath);