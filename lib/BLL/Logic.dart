abstract class Command {
  void apply(List<num> stack);
}

class Addition implements Command {
  @override
  void apply(List<num> stack) {
    var result = stack.removeLast() + stack.removeLast();
    stack.add(double.parse(result.toStringAsFixed(8)));
  }
}

class Subtraction implements Command {
  @override
  void apply(List<num> stack) {
    var subtrahend = stack.removeLast();
    var minuend = stack.removeLast();
    stack.add(double.parse((minuend - subtrahend).toStringAsFixed(8)));
  }
}

class Multiplication implements Command {
  @override
  void apply(List<num> stack) {
    var result = stack.removeLast() * stack.removeLast();
    stack.add(double.parse(result.toStringAsFixed(8)));
  }
}

class Division implements Command {
  @override
  void apply(List<num> stack) {
    var divisor = stack.removeLast();
    if (divisor == 0) throw Exception("Division by zero error");
    var dividend = stack.removeLast();
    stack.add(double.parse((dividend / divisor).toStringAsFixed(8)));
  }
}

class Calculator {
  List<num> stack;

  Calculator({required this.stack});

  void push(num value) {
    if (value.isInfinite || value == 0) throw Exception("Cannot add 0 to stack");
    stack.add(value);
  }

  void execute(Command command) {
    if (stack.length < 2) throw Exception("Not enough operands on the stack to perform operation");
    command.apply(stack);
  }

  void clear() {
    stack.clear();
  }
}
