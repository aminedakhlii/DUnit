import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';

class AST {
  List<String>? files = [];
  List classes = [];

  AST({this.files});

  void process() {
    AnalysisContextCollection collection =
        new AnalysisContextCollection(includedPaths: files);
    analyzeSomeFiles(collection, files!);
  }

  void processFile(AnalysisSession session, String path) {
    var result = session.getParsedUnit(path);
    if (result is ParsedUnitResult) {
      CompilationUnit unit = result.unit;
      printMembers(unit);
    }
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
    processFile(session, path);
  }

  void printMembers(CompilationUnit unit) {
    for (CompilationUnitMember unitMember in unit.declarations) {
      if (unitMember is ClassDeclaration) {
        List fields = []; 
        List methods = [];
        List constructors = [];
        for (ClassMember classMember in unitMember.members) {
          if (classMember is MethodDeclaration) {
            methods.add('{"name":' + '"' + classMember.name.toString() + '","type":"' + classMember.returnType.toString() + '"}');
          } else if (classMember is FieldDeclaration) {
            for (VariableDeclaration field in classMember.fields.variables) {
              fields.add('{"name": "' + field.name.toString() + '"}');
            }
          } else if (classMember is ConstructorDeclaration) {
            if (classMember.name == null) {
              constructors.add(unitMember);
            } else {
              constructors.add(unitMember);
            }
          }
        }
        String c = '{"class": ' + '"' + unitMember.name.toString() + '", "fields":' + fields.toString()+ ', "methods": ' + methods.toString() + '}';
        classes.add(c);
      }
    }
  }

  toJson(){
    return (classes).toString();
  }
}