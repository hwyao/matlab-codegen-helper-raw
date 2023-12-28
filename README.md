# matlab-codegen-helper-raw
This repository is a helpful framework for matlab [codegen](https://www.mathworks.com/help/coder/ref/codegen.html) command that automates some common tasks.

## Quick start

1. clone the repository.
```
git clone https://github.com/hwyao/matlab-codegen-helper-raw
```
2. Load the matlab project.  
   Double-click `matlab-codegen-helper-raw.prj` in Matlab (R2019 or higher) 
3. Prepare your functions codegen. Remeber to add all functions to the matlab path.
4. Run `codegenRun` function to execute result.
```
codegenRun("adder",{{1,2}},{},outputPath=pwd);
```
Use `help` or see code in `/example/` folder to understand how this function and its parameters works. 

## When to use this repo

Codegen is a part of the [Matlab Coder Toolbox](https://www.mathworks.com/help/coder/index.html) that generates the C/C++ code from matlab files and compile it with different options. Possible benefits of using codegen include speeding up code execution, encapsulating function interfaces etc. However, not all code supports codegen. It takes a lot of effort to modify existing code (especially third-party repositories) to work with codegen, and re-releasing modified code may break the original design structure and encounter licensing issues.

This repository is especially helpful for the case:
- You want to clone a repo as a submodule and execute codegen for it.
- You want to automate modification scripts / code scanning / comparison test before or after executing codegen.

## Features

- Easily **specify output directory and name** of the MEX file.
- Automatically **generates accompanying comment file** with detailed information.
- **global and extrinsic** functionality support.
- (tbd) Automatic **preprocessing script exection** to modifiy the code as required.
- (tbd) Automatic **code scanning** indicating code that probably incompitable with codegen.
- (tbd) Automatic **test** after MEX generation.

## License

Copyright 2023 Haowen Yao

Use of this source code is governed by an MIT-style
license that can be found in the LICENSE file or at
https://opensource.org/licenses/MIT.