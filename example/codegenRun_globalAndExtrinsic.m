clear
clc

outputPath = [pwd,'/build/'];

global a; global b; %#ok<*GVMIS>
a = 1; b = 1;
codegenRun("global_update_func",{{1,2}},{},outputPath=outputPath,globalCell={'a',a,'b',b})
codegenRun("global_get_func",{},{},outputPath=outputPath,globalCell={'a',a,'b',b})

codegenVararg = {'-launchreport'};
codegenRun("extrinsic_call_func",{{1}},codegenVararg,outputPath=outputPath)