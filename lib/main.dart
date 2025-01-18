import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _firstNumber = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _operator = "";
        _firstNumber = 0;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_currentInput.isNotEmpty) {
          _firstNumber = double.parse(_currentInput);
          _operator = value;
          _currentInput = "";
        }
      } else if (value == "=") {
        if (_operator.isNotEmpty && _currentInput.isNotEmpty) {
          double secondNumber = double.parse(_currentInput);
          switch (_operator) {
            case "+":
              _output = (_firstNumber + secondNumber).toString();
              break;
            case "-":
              _output = (_firstNumber - secondNumber).toString();
              break;
            case "*":
              _output = (_firstNumber * secondNumber).toString();
              break;
            case "/":
              _output = (_firstNumber / secondNumber).toString();
              break;
          }
          _operator = "";
          _currentInput = "";
        }
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _buttonPressed(value),
        child: Text(
          value,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: ["7", "8", "9", "/"].map(_buildButton).toList(),
              ),
              Row(
                children: ["4", "5", "6", "*"].map(_buildButton).toList(),
              ),
              Row(
                children: ["1", "2", "3", "-"].map(_buildButton).toList(),
              ),
              Row(
                children: ["C", "0", "=", "+"].map(_buildButton).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
