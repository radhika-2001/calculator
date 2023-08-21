import 'package:demo_testing/src/calculator.dart';
import 'package:test/test.dart';

void main(){
  Calculator? calculator;

  setUp((){
    calculator = Calculator();
  });

  group('Calculator', () {
    test('add return 4 when adding 2 and 2', () {
      expect(calculator!.add(2, 2), 4);
    });

    test('subtract return 0 when adding 2 and 2', () {
      expect(calculator!.substract(2, 2), 0);
    });

    test('multipy return 4 when adding 2 and 2', () {
      expect(calculator!.multiply(2, 2), 4);
    });

    test('divide return 1 when adding 2 and 2', () {
      expect(calculator!.divide(2, 2), 1);
    });
  });

  group('powerOfTwo', () {
    test('returns 81 when the input is 9',()async {
      expect(await calculator!.powerOfTwo(9),81);
    });
  });

  group('pi', () {
    test('emits [3,3.1,3.14,3.141,3.1415] in that order ', () {
      expect(calculator!.pi(), emitsInOrder([3,3.1,3.14,3.141,3.1415]));
    });
  });
}