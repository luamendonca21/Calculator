import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.blue and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SimpleCalculator(),
    );
  }
}

// class stful

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  /// method for button pressed behavior depending on which type of the button

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationSize = 38.0;
  double resultSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equationSize = 38.0;
        resultSize = 48.0;
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equationSize = 48.0;
        resultSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationSize = 38.0;
        resultSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          String resultAux = '${exp.evaluate(EvaluationType.REAL, cm)}';
          double numero = double.parse(resultAux);
          result = numero.toStringAsFixed(2);
        } catch (e) {
          result = "Error";
        }
      } else {
        equationSize = 48.0;
        resultSize = 38.0;
        // to remove the 0
        if (equation == "0") {
          result = buttonText;
          equation = buttonText;
        } else {
          result = buttonText;
          equation = equation + buttonText;
        }
      }
    });
    //behavior
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        child: TextButton(
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () => buttonPressed(buttonText),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20))),
              backgroundColor: MaterialStateProperty.all(buttonColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(16)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Simple Calculator"))),
      body: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(equation,
                  style: TextStyle(
                      fontSize: equationSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white))),
          Container(
              alignment: Alignment.centerRight,
              color: Colors.blue,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(result,
                  style: TextStyle(
                      fontSize: resultSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .50,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.pink),
                      buildButton("⌫", 1, Colors.black),
                      buildButton("÷", 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton("9", 1, Colors.black),
                      buildButton("8", 1, Colors.black),
                      buildButton("7", 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black),
                      buildButton("5", 1, Colors.black),
                      buildButton("6", 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black),
                      buildButton("2", 1, Colors.black),
                      buildButton("3", 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.pink),
                      buildButton("0", 1, Colors.black),
                      buildButton("00", 1, Colors.black),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height * .50,
                color: Colors.white,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("x", 1, Colors.pink),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.pink),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.pink),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.blue),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
