# DUnit
A testing framework for the dart programming language

# How it is made
- DUnit is composed of 3 main modules that could be run seperately: 
## AST generator
Generates the AST from a dart file
## File generator
a backbone test structure generator that generates a ready to convert file with all ast testing methods empty to write tests in
## Runner
Generates a runnable file using the flutter test plugin that could be run directly in a Flutter project

# Get Started 
First you have to cd to each of the modules and run ``` dart pub get ```

- To run DUnit on the example file located in tests folder you need to do the following

1. ``` cd dUnit ```
2. ``` dart --no-sound-null-safety generate.dart [absolute path to your DUnit directory]/examples/test.dart ```

this will generate a backbone file in the tests folder for each class in the file the file will look as follows:

``` 
const test = 'TEST';
class ExampleClass1Test{
//test methods

  @test
  Testmethod(){

  }

  @test
  TestgetField(){

  }

  @test
  TestsetField(){

  }

} 
```

3. after writing your tests for each methods you just have to : 
``` dart --no-sound-null-safety run.dart ```

This will generate the runnable file in tests folder it should look as follows 
```
import 'package:test/test.dart';

void main(){
test('Testmethod', () {"your written tests here"});
test('TestgetField', () {"your written tests here"});
test('TestsetField', () {"your written tests here"});
}
```

this file is then runnable if you copy it to your flutter project.

# Future improvments

1. Random test generation for each method
2. Random + feedback test generation for sequences of tests
3. VScode plugin that moves the runnable file to Flutter projects directly

# Documentation
Documentation of each module is being written and will be available in upcoming days! 

Cheers!