import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  String preOpr = '';

  // Button Widget
  Widget calcButton(
      String btnTxt, Color btnColor, Color txtColor, double fontSize) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            calculation(btnTxt);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ), backgroundColor: btnColor,
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            btnTxt,
            style: TextStyle(
              fontSize: fontSize,
              color: txtColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 1,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  calcButton('AC', Colors.grey, Colors.black, 24.0),
                  calcButton('+/-', Colors.grey, Colors.black, 24.0),
                  calcButton('%', Colors.grey, Colors.black, 24.0),
                  calcButton('/', Colors.amber, Colors.white, 24.0),
                ],
              ),
              Row(
                children: <Widget>[
                  calcButton('7', Colors.grey, Colors.white, 24.0),
                  calcButton('8', Colors.grey, Colors.white, 24.0),
                  calcButton('9', Colors.grey, Colors.white, 24.0),
                  calcButton('x', Colors.amber, Colors.white, 24.0),
                ],
              ),
              Row(
                children: <Widget>[
                  calcButton('4', Colors.grey, Colors.white, 24.0),
                  calcButton('5', Colors.grey, Colors.white, 24.0),
                  calcButton('6', Colors.grey, Colors.white, 24.0),
                  calcButton('-', Colors.amber, Colors.white, 24.0),
                ],
              ),
              Row(
                children: <Widget>[
                  calcButton('1', Colors.grey, Colors.white, 24.0),
                  calcButton('2', Colors.grey, Colors.white, 24.0),
                  calcButton('3', Colors.grey, Colors.white, 24.0),
                  calcButton('+', Colors.amber, Colors.white, 24.0),
                ],
              ),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      calculation('0');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), backgroundColor: Colors.grey[850],
                      padding: const EdgeInsets.fromLTRB(34, 20, 34, 20),
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  calcButton('.', Colors.grey, Colors.white, 24.0),
                  calcButton('=', Colors.amber, Colors.white, 24.0),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Calculator logic...
  void calculation(btnText) {
    if (btnText == 'AC') {
      setState(() {
        text = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      });
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add().toString();
      } else if (preOpr == '-') {
        finalResult = sub().toString();
      } else if (preOpr == 'x') {
        finalResult = mul().toString();
      } else if (preOpr == '/') {
        finalResult = div().toString();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add().toString();
      } else if (opr == '-') {
        finalResult = sub().toString();
      } else if (opr == 'x') {
        finalResult = mul().toString();
      } else if (opr == '/') {
        finalResult = div().toString();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  double add() {
    return numOne + numTwo;
  }

  double sub() {
    return numOne - numTwo;
  }

  double mul() {
    return numOne * numTwo;
  }

  double div() {
    return numOne / numTwo;
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result.toString();
  }
}
