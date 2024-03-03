import 'package:rpn_calculator/BLL/Logic.dart';

final Map<String, Command> commands = {
  '+': Addition(),
  '-': Subtraction(),
  'x': Multiplication(),
  '÷': Division(),
};
final List<String> operators = [
  '+',
  '-',
  'x',
  '÷'
];
final List<String> utils = [
  'Enter',
  '←',
  'Pop',
  'AC',
  'Undo',
];
final List<String> buttons = [
  'AC',
  'Pop',
  'Undo',
  '←',
  '7',
  '8',
  '9',
  '÷',
  '4',
  '5',
  '6',
  'x',
  '1',
  '2',
  '3',
  '-',
  '0',
  '.',
  'Enter',
  '+',
];

