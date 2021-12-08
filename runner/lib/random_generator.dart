import 'dart:io';
import 'dart:core';
import 'grammar.dart';
import 'package:petitparser/petitparser.dart';
import 'dart:math';
import 'dart:isolate';

final grammar = DartGrammarDefinition().build();

void main() async {
  var file = File(Directory.current.path.replaceAll('\\', '/') + '/../../tests/test_${DateTime.now().millisecondsSinceEpoch}_gen.dart');

  var sink = file.openWrite();
  sink.write('import \'package:test/test.dart\'\;\n\n');
  sink.write('void main() {\n\n');

  //String testFunction = "int calculate(int a, int b, int c, String d) {return a + b;}";
  //String testFunction = "String calculate(int a, int b, int c, String d) {return (a + b).toString();}";
  //String testFunction = "double calculate(int a, int b, int c, String d) {return (a + b).toDouble();}";
  String testFunction = "double calculate(int a, int b, int c, String d, double e, bool f) {return (a + b).toDouble();}";
  //String testFunction = "bool calculate(int a, int b, int c, String d, double e, bool f) {return (a + b) == 0 ? false : true;}";

  if (grammar.accept(testFunction))
    {

      for (int i = 0; i < 20; i++) {
        sink.write( await generateRandomTest(testFunction));
      }
    }
  else
    {
      print("failed");
    }

  sink.write('}');

  sink.write('\n\n\n' + testFunction);
  sink.close();
}

Future<String> generateRandomTest(String currentFunction) async {
  var randomNumber = new Random();
  String buildTest = "test('Random_${DateTime.now().millisecondsSinceEpoch}', () {\n";

  var re3 = RegExp(r"[()]");
  var inputs = [];

  for (int j = 0; j < currentFunction.split(re3)[1].split(', ').length; j++)
  {
      //print (currentFunction.split(re3)[1].split(', ')[j]);
      if (currentFunction.split(re3)[1].split(', ')[j].toString().startsWith('int')) {
        inputs.add(randomNumber.nextInt(100));
      }

      if (currentFunction.split(re3)[1].split(', ')[j].toString().startsWith('String')) {
        inputs.add('\"' + getRandomString(15) + '\"');
      }

      if (currentFunction.split(re3)[1].split(', ')[j].toString().startsWith('double')) {
        inputs.add(randomNumber.nextDouble());
      }

      if (currentFunction.split(re3)[1].split(', ')[j].toString().startsWith('double')) {
        inputs.add(randomNumber.nextBool());
      }

      print(j.toString() + " " + inputs[j].toString()) ;
  }

  var re2 = RegExp(r"[ (),]"); //The second in this will show the fuction name
  String loaded_Function = currentFunction.split(re2)[1] + '(';

  for (int j = 0; j < currentFunction.split(re3)[1].split(', ').length; j++)
  {
    loaded_Function = loaded_Function + inputs[j].toString();
    if (j < currentFunction.split(re3)[1].split(', ').length - 1)
    {
      loaded_Function = loaded_Function + ', ';
    }
    else
    {
      loaded_Function = loaded_Function + ')' ;
    }
  }
  print (loaded_Function);
  String res = "Default Error Value";

  await eval_Function(currentFunction, loaded_Function).then((value) { res = value;} );

  buildTest = buildTest + 'expect(' + loaded_Function;

  if (currentFunction.split(re2)[0].startsWith('String')) {
    buildTest = buildTest + ', equals(\"' + res + '\"));';
  }
  if (currentFunction.split(re2)[0].startsWith('int')) {
    buildTest = buildTest + ', equals(' + res + '));';
  }

  if (currentFunction.split(re2)[0].startsWith('double')) {
    buildTest = buildTest + ', equals(' + res + '));';
  }

  if (currentFunction.split(re2)[0].startsWith('bool')) {
    buildTest = buildTest + ', equals(' + res + '));';
  }

  buildTest = buildTest + '});\n\n';
  return buildTest;
}

Future<String> eval_Function (String function_Text, String function_Call) async {

  String functions_name = 'import "dart:isolate";' + '\n\n';
  functions_name = functions_name + function_Text + '\n' + 'void main(_, SendPort port) {' + '\n';
  functions_name = functions_name + 'port.send(' + function_Call + '.toString());}';

  final uri = Uri.dataFromString(
    functions_name,
    mimeType: 'application/dart',
  );

  final port = ReceivePort();
  await Isolate.spawnUri(uri, [], port.sendPort);

  final String response = await port.first;
  return response;
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    //https://stackoverflow.com/questions/61919395/how-to-generate-random-string-in-dart
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));