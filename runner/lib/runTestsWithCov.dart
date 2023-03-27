import 'package:test/test.dart';
import 'package:coverage/coverage.dart';
import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  // Define the paths to the test file and the output file
  final testPath = '/home/alaa/Documents/sqa/DUnit/runner/lib/tests/test';
  final outputDirectory = '/home/alaa/Documents/sqa/DUnit/coverage';

  // Create a directory to store the coverage information
  await Directory(outputDirectory).create(recursive: true);

  print('here');
  // Collect coverage information for the tests
  final coverage = await runAndCollect(testPath);
  print('here');
  print(coverage);
  // Write the coverage information to a file
  final outputFile = File('$outputDirectory/coverage.json');

  await outputFile.writeAsString(jsonEncode(coverage), flush: true);
  //write the coverage information to a file
}
