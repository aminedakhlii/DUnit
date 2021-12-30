import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

class Runner {

  String? testDir;

  Runner({this.testDir});

  List getParams(String method){
    var re = RegExp(r"[()]");
    var params = method.split(re)[1].split(', ');
    return params;
  }

  String getName(String method){
    var re = RegExp(r"[\t(),]");
    return method.split(re)[0].split(', ')[0];
  }

  String getBody(String method){
    //var re = RegExp(r"[\t(),]");
    var split = (method.split(getName(method) + '()'));
    var body = ""; 
    for (int i = 1; i < split.length; i++) {
      body +=split[i];
    }
    //var body = method.split(re).last;
    print(body);
    return body;
  }

  String runnable(String name, String body){
    String testStr = "test('" + name + "', () " + body + ");";
    return testStr; 
  }

  generateMain(f,methods) async {
    String content = "import 'package:test/test.dart';\n\nvoid main(){\n";
    for (var method in methods){
      content += runnable(getName(method), getBody(method)); 
      content += "\n";
    }
    content += "}\n";
    print(content);
    var file = await File(testDir! + 'mainTest' + f).writeAsString(content);
  }

  inject() {
    Directory dir = Directory(testDir!);
    // execute an action on each entry
    dir.list(recursive: false).forEach((f) {
      String content;
      File(f.path).readAsString().then((String contents) {
        content = contents;
        var arr = content.split("//test methods\n");
        var methods = arr[1].split("@test");
        methods.removeAt(0);
        for (int i = 0; i<methods.length; i++) {
          methods[i] = methods[i].replaceAll('\n', '');
          methods[i] = methods[i].replaceAll('\t', ' ');
          methods[i] = methods[i].replaceAll('  ', '');
          if(i == methods.length - 1) methods[i] = methods[i].substring(0, methods[i].length - 1);
        }
        generateMain(basename(f.path),methods);
      });
    });
  }
}