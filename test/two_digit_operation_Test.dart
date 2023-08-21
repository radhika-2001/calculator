import 'package:demo_testing/operation.dart';
import 'package:demo_testing/src/calculator.dart';
import 'package:demo_testing/two_digit_operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCalculator extends Mock implements Calculator {}

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = MockCalculator();
  });

  group('TwoDigitOperation', () {
    group('Operation.add', () {
      testWidgets('paints the value returned by the calculator',
              (tester) async {
            when(calculator.add(3, 1)).thenReturn(4);
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: TwoDigitOperation(
                    operation: Operation.add,
                    calculator: calculator,
                  ),
                ),
              ),
            );
            await tester.enterText(
              find.byKey(const Key('textField_top_plus')),
              '3',
            );
            await tester.enterText(
              find.byKey(const Key('textField_bottom_plus')),
              '1',
            );
            await tester.pumpAndSettle();
            expect(find.text('is 4.0'), findsOneWidget);
          });
    });

    group('Operation.divide', () {
      testWidgets('paints the value returned by the calculator',
              (tester) async {
            when(calculator.divide(3, 0)).thenThrow(Exception('oops'));
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: TwoDigitOperation(
                    operation: Operation.divide,
                    calculator: calculator,
                  ),
                ),
              ),
            );
            await tester.enterText(
              find.byKey(const Key('textField_top_divided by')),
              '3',
            );
            await tester.enterText(
              find.byKey(const Key('textField_bottom_divided by')),
              '0',
            );
            await tester.pumpAndSettle();
            expect(find.text('is ???'), findsOneWidget);
          });
    });
  });
}