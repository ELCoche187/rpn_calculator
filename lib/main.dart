import 'package:flutter/material.dart';
import 'package:rpn_calculator/BLL/Logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}


class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String currentNumber = '';
  Calculator calculator = Calculator(stack: []);

  void onButtonPressed(String buttonText) {
    if (buttonText == 'C') {
      clearDisplay();
    } else if (buttonText == '=') {
      calculateResult();
    } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
      if (currentNumber.isNotEmpty) {
        enterPressed();
      }
      if (calculator.stack.length >= 2) {
        setOperation(buttonText);
      }
    } else if (buttonText == '.' || buttonText == ',') {
      appendNumber(buttonText);
    } else if (buttonText == 'Enter') {
      if (currentNumber.isNotEmpty) {
        enterPressed();
      }
    } else {
      appendNumber(buttonText);
    }
  }







  void clearDisplay() {
    setState(() {
      displayText = '0';
      currentNumber = '';
      calculator.clear();
    });
  }

  void calculateResult() {
    try {
      switch (calculator.stack.length) {
        case 0:
          break;
        case 1:
          displayText = calculator.stack[0].toString();
          break;
        default:
          displayText = calculator.stack.last.toString();
          break;
      }
      setState(() {
        calculator.clear();
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        displayText = "Error";
        calculator.clear();
      });
    }
  }

  void setOperation(String newOperation) {
    try {
      switch (newOperation) {
        case '+':
          calculator.execute(Addition());
          break;
        case '-':
          calculator.execute(Subtraction());
          break;
        case 'x':
          calculator.execute(Multiplication());
          break;
        case '/':
          calculator.execute(Division());
          break;
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        displayText = "Error";
        calculator.clear();
      });
    }
  }

  void enterPressed() {
    try {
      double number = double.parse(currentNumber);
      calculator.push(number);
      currentNumber = '';
    } catch (e) {
      print("Error: $e");
      setState(() {
        displayText = "Error";
        calculator.clear();
      });
    }
  }

  void appendNumber(String number) {
    setState(() {
      if (number == '.' || number == ',') {
        if (!currentNumber.contains('.') && !currentNumber.contains(',')) {
          currentNumber += '.';
        }
      } else {
        currentNumber += number;
      }
      displayText = currentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nico and Mika Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Display(text: displayText),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: calculator.stack.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(calculator.stack[index].toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        calculator.stack.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: '7',
                onPressed: () => onButtonPressed('7'),
              ),
              CalculatorButton(
                text: '8',
                onPressed: () => onButtonPressed('8'),
              ),
              CalculatorButton(
                text: '9',
                onPressed: () => onButtonPressed('9'),
              ),
              CalculatorButton(
                text: '/',
                onPressed: () => onButtonPressed('/'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: '4',
                onPressed: () => onButtonPressed('4'),
              ),
              CalculatorButton(
                text: '5',
                onPressed: () => onButtonPressed('5'),
              ),
              CalculatorButton(
                text: '6',
                onPressed: () => onButtonPressed('6'),
              ),
              CalculatorButton(
                text: 'x',
                onPressed: () => onButtonPressed('x'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: '1',
                onPressed: () => onButtonPressed('1'),
              ),
              CalculatorButton(
                text: '2',
                onPressed: () => onButtonPressed('2'),
              ),
              CalculatorButton(
                text: '3',
                onPressed: () => onButtonPressed('3'),
              ),
              CalculatorButton(
                text: '-',
                onPressed: () => onButtonPressed('-'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: '0',
                onPressed: () => onButtonPressed('0'),
              ),
              CalculatorButton(
                text: 'C',
                onPressed: () => onButtonPressed('C'),
              ),
              CalculatorButton(
                text: '=',
                onPressed: () => onButtonPressed('='),
              ),
              CalculatorButton(
                text: '+',
                onPressed: () => onButtonPressed('+'),
              ),
            ],
          ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalculatorButton(
            text: ',',
            onPressed: () => onButtonPressed(','),
          ),
          CalculatorButton(
            text: 'Enter',
            onPressed: () => onButtonPressed('Enter'),
          ),
        ],
      ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

class Display extends StatelessWidget {
  final String text;

  const Display({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(fontSize: 32.0),
      ),
    );
  }
}
