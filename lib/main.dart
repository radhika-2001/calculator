
import 'package:demo_testing/operation.dart';
import 'package:demo_testing/pi.dart';
import 'package:demo_testing/power_of_two.dart';
import 'package:demo_testing/src/calculator.dart';
import 'package:demo_testing/two_digit_operation.dart';
import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calculator = Calculator();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SafeArea(
              child: Column(
                children: [
                  PowerOfTwo(calculator: calculator),
                  Divider(),
                  Pi(calculator: calculator),
                  Divider(),
                  TwoDigitOperation(
                    calculator: calculator,
                    operation: Operation.add,
                  ),
                  Divider(),
                  TwoDigitOperation(
                    calculator: calculator,
                    operation: Operation.substract,
                  ),
                  Divider(),
                  TwoDigitOperation(
                    calculator: calculator,
                    operation: Operation.multiply,
                  ),
                  Divider(),
                  TwoDigitOperation(
                    calculator: calculator,
                    operation: Operation.divide,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}