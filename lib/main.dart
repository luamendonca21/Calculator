// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

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
        // changing the primarySwatch below to Colors.green and then invoke
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
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
      } else if (buttonText == "=") {
        // code
      } else {
        // to remove the 0
        if (equation == "0") {
          equation = buttonText;
        } else {
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
              color: Colors.black,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(equation,
                  style: TextStyle(
                      fontSize: equationSize,
                      fontWeight: FontWeight.w300,
                      color: Colors.white))),
          Container(
              alignment: Alignment.centerRight,
              color: Colors.green,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(result,
                  style: TextStyle(
                      fontSize: resultSize,
                      fontWeight: FontWeight.w400,
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
                height: MediaQuery.of(context).size.height * .55,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.red),
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
                      buildButton(".", 1, Colors.red),
                      buildButton("0", 1, Colors.black),
                      buildButton("00", 1, Colors.black),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height * .55,
                color: Colors.white,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("x", 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.red),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.green),
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
