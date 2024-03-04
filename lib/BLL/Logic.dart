abstract class Command {
  void apply(List<num> stack);
}

class Addition implements Command {
  @override
  void apply(List<num> stack) {
    var result = stack.removeLast() + stack.removeLast();
    stack.add(result);
  }
}

class Subtraction implements Command {
  @override
  void apply(List<num> stack) {
    var subtrahend = stack.removeLast();
    var minuend = stack.removeLast();
    stack.add(minuend - subtrahend);
  }
}

class Multiplication implements Command {
  @override
  void apply(List<num> stack) {
    var result = stack.removeLast() * stack.removeLast();
    stack.add(result);
  }
}

class Division implements Command {
  @override
  void apply(List<num> stack) {
    var divisor = stack.removeLast();
    if (divisor == 0) throw Exception("Division by zero error");
    var dividend = stack.removeLast();
    stack.add(dividend / divisor);
  }
}

class Calculator {
  List<num> stack;

  Calculator({required this.stack});

  void push(num value) {
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
