import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String screenText = "";

  bool isOperator(String key) {
    return (key == "+" || key == "-" || key == "*" || key == "/");
  }

  double calc(String operator, double op1, double op2) {
    switch (operator) {
      case "+":
        return op1 + op2;
      case "-":
        return op1 - op2;
      case "*":
        return op1 * op2;
      case "/":
        return op1 / op2;
      default:
        return 0.0;
    }
  }

  void handleScreen(String key) {
    if (key == "=" && screenText.isEmpty) return;
    if (isOperator(key) && screenText.isEmpty) return;

    String newValue = "";

    if (key == "<-") {
      newValue = "";
    } else if (key == "=") {
      String op1 = "";
      String op2 = "";

      String operator = "";

      for (int i = 0; i < screenText.length; i++) {
        if (isOperator(screenText[i])) {
          operator = screenText[i];
          op1 = screenText.substring(0, i);
          op2 = screenText.substring(i + 1, screenText.length);
          break;
        }
      }

      newValue =
          calc(operator, double.parse(op1), double.parse(op2)).toString();
    } else {
      newValue = screenText + key;
    }

    setState(() {
      screenText = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Calculadora"),
      // ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: 400,
          height: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30 * 5,
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(screenText),
              ),
          
              SizedBox(height: 10),
          
              Keyboard(handleScreen),
            ],
          ),
        ),
      ),
    );
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard(this.onTap, {super.key});

  final Function(String text) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Button("7", onTap),
                Button("8", onTap),
                Button("9", onTap),
                Button("/", onTap),
              ],
            ),
            Row(
              children: [
                Button("4", onTap),
                Button("5", onTap),
                Button("6", onTap),
                Button("*", onTap),
              ],
            ),
            Row(
              children: [
                Button("1", onTap),
                Button("2", onTap),
                Button("3", onTap),
                Button("+", onTap),
              ],
            ),
            Row(
              children: [
                Button("<-", onTap),
                Button("", onTap),
                Button("0", onTap),
                Button("-", onTap),
              ],
            ),
          ],
        ),

        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Button("=", onTap),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button(this.text, this.onClick, {super.key});

  final String text;
  final Function(String text)? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onClick!(text)},
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        width: 30,
        height: 30,
        child: Center(child: Text(text)),
      ),
    );
  }
}
