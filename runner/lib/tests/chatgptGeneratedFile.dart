import 'package:test/test.dart';
import 'package:runner/calculator.dart';

void main() {
  group('Calculator', () {
    Calculator calculator = Calculator();

    test('should add two numbers', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-2, 3), equals(1));
    });

    test('should subtract two numbers', () {
      expect(calculator.subtract(3, 2), equals(1));
      expect(calculator.subtract(-2, -3), equals(1));
    });

    test('should divide two numbers', () {
      expect(calculator.divide(6, 3), equals(2));
      expect(calculator.divide(5, 2), equals(2.5));
    });

    test('should throw an Exception when dividing by zero', () {
      expect(() => calculator.divide(6, 0), throwsException);
    });

    test('should multiply two numbers', () {
      expect(calculator.multiply(2, 3), equals(6));
      expect(calculator.multiply(-2, 3), equals(-6));
    });
  });
}