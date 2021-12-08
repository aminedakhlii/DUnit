import '../ast/lib/ast.dart';
import '../file_generator/lib/file_generator.dart';

class Dunit {
  genrate(List<String>? args) {
    //generate the ast of the file
    AST ast = AST(files: args!);
    ast.process();

    //Generate the test structure file in tests directory
    FileGenerator fileGenerator = FileGenerator();
    fileGenerator.generateFile(ast.toJson());
  }
}