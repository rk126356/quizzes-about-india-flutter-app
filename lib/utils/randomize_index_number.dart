import 'dart:math';

List<int> randomOrder(int num1, int num2, int num3, int num4) {
  List<int> numbers = [num1, num2, num3, num4];
  List<int> randomized = [];

  while (numbers.isNotEmpty) {
    int index = Random().nextInt(numbers.length);
    randomized.add(numbers[index]);
    numbers.removeAt(index);
  }

  return randomized;
}
