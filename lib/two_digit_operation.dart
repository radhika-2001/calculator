import 'package:demo_testing/src/calculator.dart';
import 'package:demo_testing/operation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwoDigitOperation extends StatefulWidget {
  const TwoDigitOperation({
    required this.operation,
    required this.calculator,
  });

  final Operation operation;
  final Calculator calculator;

  @override
  State<TwoDigitOperation> createState() => _TwoDigitOperationState();
}

class _TwoDigitOperationState extends State<TwoDigitOperation> {
  final _topTextController = TextEditingController();
  final _bottomTextController = TextEditingController();

  String? _operationResult;
  String? _resultAfterAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _topTextController.addListener(_getResult);
    _bottomTextController.addListener(_getResult);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          key: Key('textField_top_${widget.operation.description}'),
          controller: _topTextController,
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                widget.operation.description,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
                child: TextFormField(
                  key: Key('textField_bottom_${widget.operation.description}'),
                  controller: _bottomTextController,
                  keyboardType: TextInputType.number,
                )
            )
          ],
        ),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.linear,
          color: _operationResult == null? Colors.transparent: Colors.lightGreen,
          onEnd: (){
            setState(() {
              _resultAfterAnimation = _operationResult;
            });
          },
          child: Text(
            'is ${_resultAfterAnimation ?? '???'}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }

  void _getResult(){
    if(_topTextController.text.isNotEmpty && _bottomTextController.text.isNotEmpty){
      try{
        final result = _calculate(
          double.tryParse(_topTextController.text)?? 0.0,
          double.tryParse(_bottomTextController.text)?? 0.0,
        );
        setState(() {
          _operationResult = result.toString();
        });
      } catch (_){
        setState(() {
          _operationResult = null;
        });
      }
    }
  }

  double _calculate(double top, double bottom){
    double result;
    switch (widget.operation){
      case Operation.add:
        result = widget.calculator.add(top, bottom)?? 0.0;
        break;
      case Operation.substract:
        result = widget.calculator.substract(top, bottom)??0.0;
        break;
      case Operation.multiply:
        result = widget.calculator.multiply(top, bottom)??0.0;
        break;
      case Operation.divide:
        result = widget.calculator.divide(top, bottom)??0.0;
        break;
    }
    return result;
  }
}
