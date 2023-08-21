import 'package:demo_testing/power_of_two.dart';
import 'package:demo_testing/src/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCalculator extends Mock implements Calculator {}

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = MockCalculator();
  });

  group('PowerOfTwo', () {
    testWidgets('renders the result provided by the calculator',
            (tester) async {
          when(calculator.powerOfTwo(5.0))
              .thenAnswer((realInvocation) => Future.value(25.0));
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: PowerOfTwo(
                  calculator: calculator,
                ),
              ),
            ),
          );
          await tester.enterText(find.byKey(Key('textField_powerOfTwo')), '5');
          await tester.pumpAndSettle();
          expect(find.text('is 25.0'), findsOneWidget);
        });
  });
}