import '../runner/lib/runner.dart';

main(List<String>? args) {
  //inject tests into main function of the project
  Runner runner = Runner(testDir: '../tests/');
  runner.inject();
}