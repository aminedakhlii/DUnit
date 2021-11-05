import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';

void processFile(AnalysisSession session, String path) {
  var result = session.getParsedUnit(path);
  if (result is ParsedUnitResult) {
    CompilationUnit unit = result.unit;
    printMembers(unit); 
  }
}

void main(){
  List<String> paths = ["/home/amine/projects/alive/flutter_ast/lib/src/test.dart"]; 
  AnalysisContextCollection collection = new AnalysisContextCollection(includedPaths: paths);
  analyzeSomeFiles(collection,paths); 
}

void analyzeSomeFiles(
    AnalysisContextCollection collection, List<String> includedPaths) {
  for (String path in includedPaths) {
    AnalysisContext context = collection.contextFor(path);
    analyzeSingleFile(context, path);
  }
}

void analyzeSingleFile(AnalysisContext context, String path) {
  AnalysisSession session = context.currentSession;
  // ...
  processFile(session, path); 
}

void printMembers(CompilationUnit unit) {
  Map<String,String> ast = Map();
  for (CompilationUnitMember unitMember in unit.declarations) {
    if (unitMember is ClassDeclaration) {
      print(unitMember.name.name);
      for (ClassMember classMember in unitMember.members) {
        if (classMember is MethodDeclaration) {
          print('method :  ${classMember.name}');
        } else if (classMember is FieldDeclaration) {
          for (VariableDeclaration field in classMember.fields.variables) {
            print('field :   ${field.name.name}');
          }
        } else if (classMember is ConstructorDeclaration) {
          if (classMember.name == null) {
            print('constructor :  ${unitMember.name.name}');
          } else {
            print('constructor :  ${unitMember.name.name}.${classMember.name.name}');
          }
        }
      }
    }
  }
}