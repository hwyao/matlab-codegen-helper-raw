function output = extrinsic_call_func(inputArg)
    coder.extrinsic("global_get_func_mex");
    result = 0;
    result = global_get_func_mex();
    output = result + inputArg;
end

