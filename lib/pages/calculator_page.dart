import 'package:flutter/material.dart';
import 'package:Calculator/controllers/calculator_controller.dart';
import 'package:share/share.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _controller = CalculatorController();
  final _textOperation = CalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildText(text: _textOperation.show),
          _buildDisplay(text: _controller.result),
          Divider(color: Colors.white),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Calculator',
        style: TextStyle(
            fontFamily: 'Calculator', color: Colors.white, fontSize: 40.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.cyan,
      actions: [
        IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              Share.share(
                  'Check out this and other projects done by me in: https://github.com/Fhb-Hub');
            })
      ],
    );
  }

  Widget _buildText({String text}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: Text(
          text ?? '',
          textAlign: TextAlign.end,
          style: TextStyle(
              fontFamily: 'Calculator', color: Colors.cyan, fontSize: 45),
        ),
      ),
    );
  }

  Widget _buildDisplay({String text}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.bottomRight,
        child: Text(
          text ?? '0',
          textAlign: TextAlign.end,
          style: TextStyle(
              fontFamily: 'Calculator', color: Colors.black, fontSize: 60),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.cyan,
      height: height * 0.65 > 500.0 ? 500 : height * 0.65,
      child: Column(
        children: [
          _buildKeyboardLine1(),
          _buildKeyboardLine2(),
          _buildKeyboardLine3(),
          _buildKeyboardLine4(),
          _buildKeyboardLine5(),
        ],
      ),
    );
  }

  Widget _buildKeyboardLine1() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: 'AC', color: Colors.cyan),
          _buildButton(label: 'DEL', color: Colors.cyan),
          _buildButton(label: '%', color: Colors.cyan),
          _buildButton(label: '/', color: Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildKeyboardLine2() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '7'),
          _buildButton(label: '8'),
          _buildButton(label: '9'),
          _buildButton(label: 'x', color: Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildKeyboardLine3() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '4'),
          _buildButton(label: '5'),
          _buildButton(label: '6'),
          _buildButton(label: '-', color: Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildKeyboardLine4() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '1'),
          _buildButton(label: '2'),
          _buildButton(label: '3'),
          _buildButton(label: '+', color: Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildKeyboardLine5() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '0', flex: 2),
          _buildButton(label: ','),
          _buildButton(label: '=', color: Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildButton(
      {String label, int flex = 1, Color color = Colors.white}) {
    return Expanded(
      flex: flex,
      child: RaisedButton(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: color,
            ),
          ),
          color: Colors.black,
          onPressed: () {
            _calculatorLogic(label);
            _setTextOperation(label);
          }),
    );
  }

  _setTextOperation(String label) {
    setState(() {
      if (label == '=') {
        _textOperation.show = _controller.result;
      } else {
        _textOperation.applyText(label);
      }
    });
  }

  _calculatorLogic(String label) {
    setState(() {
      _controller.applyCommand(label);
    });
  }
}
