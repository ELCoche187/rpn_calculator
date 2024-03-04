import 'package:rpn_calculator/BLL/Logic.dart';

final Map<String, Command> commands = {
  '+': Addition(),
  '-': Subtraction(),
  'x': Multiplication(),
  '÷': Division(),
};

final List<String> operators = ['+', '-', 'x', '÷'];
final List<String> utilityOperations = ['Enter', '+/-', 'AC', '←', 'Pop', 'Undo'];
