import 'dart:convert';
import 'dart:io';

//String input = '[{"class" : "Car", "fields": [{"name":"wheels","type":"int"},{"name":"color","type":"String"}], "methods": [{"name":"changeWheels","type":"void"},{"name":"start","type":"int"}]}]';

class FileGenerator {
  void generateFile(input) async {
    var inputJSON = jsonDecode(input);
    print(input);
    for (var c in inputJSON) {
      String filename = c["class"] + "Test";
      String methods =
          "const test = 'TEST';\nclass " + filename + "{\n//test methods\n";
      for (var m in c["methods"]) {
        methods = methods + '\n  @test\n  Test' + m['name'] + '(){\n\n  }\n';
      }
      methods = methods + '\n}\n';
      var file = await File('../runner/lib/tests/' + filename + '.dart')
          .writeAsString(methods);
    }
  }
}
