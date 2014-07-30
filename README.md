ClaferGrammar
=============

This repository is created to support development of experimental Clafer grammar. 

Currently repository includes syntax checker tool which checks if test models conform to experimental grammar.

Grammar is defined in clafer.cf and follows BNFC format.

ClaferSyntaxer
=============

### Building Clafer syntax checker
Building the tool follows same steps as Clafer Compiler. Just issue:
* `make init`
* `make`
* `make install to=<Installation Path>`

### Using Clafer syntax checker

Clafer syntax checker does not support any options and simply expects model files as argument. 
* `claferSyntaxer [input files...]`

### Generating parser after changing grammar

After changing grammar (clafer.cf) it is necessary to generate new parser, lexer and other supporting files. [Custom BNFC tool](https://github.com/juodaspaulius/bnfc) is required.

Command to generate parser and other files: 
* `make grammar` 


Clafer References
==============
[Clafer](http://clafer.org) is a general-purpose lightweight structural modeling language developed by 
[GSD Lab](http://gsd.uwaterloo.ca/), [University of Waterloo](http://uwaterloo.ca), and 
[MODELS](http://www.itu.dk/research/models/) group at [IT University of Copenhagen](http://www.itu.dk/).

