import '../runner/lib/runner.dart';
import "dart:convert";
import 'dart:io';

main(List<String>? args) async {
  //inject tests into main function of the project
  Runner runner = Runner();
  runner.inject();

  //running the tests and collecting coverage
}
