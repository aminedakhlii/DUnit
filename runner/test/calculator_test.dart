import 'package:test/test.dart';

import 'package:runner/calculator.dart';

void main() {
  group('Calculator', () {
    Calculator ? calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('add', () {
      expect(calculator!.add(2, 3), equals(5));
      expect(calculator!.add(0, 0), equals(0));
      expect(calculator!.add(-1, 1), equals(0));
    });

    test('subtract', () {
      expect(calculator!.subtract(5, 3), equals(2));
      expect(calculator!.subtract(0, 0), equals(0));
      expect(calculator!.subtract(-1, -1), equals(0));
    });

    test('divide', () {
      expect(calculator!.divide(6, 3), equals(2));
      expect(() => calculator!.divide(4, 0), throwsException);
      expect(calculator!.divide(-4, 2), equals(-2));
      expect(calculator!.divide(10, 3), closeTo(3.333, 0.001));
    });

    test('multiply', () {
      expect(calculator!.multiply(2, 3), equals(6));
      expect(calculator!.multiply(0, 0), equals(0));
      expect(calculator!.multiply(-2, 3), equals(-6));
    });
  });
}
