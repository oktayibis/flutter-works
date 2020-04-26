import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  double _bmi;

  CalculatorBrain({this.weight, this.height});

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);

    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overheigt';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underheight';
    }
  }

  getInterpretion() {
    if (_bmi > 24.0) {
      return 'You have higher than average weight. You should take care of your weight and change your lifestyle...';
    } else if (_bmi > 18.5) {
      return 'You have normal body weight. Perfect! Try to keep it!';
    } else {
      return 'You have lower thane average weight. You should eat a bi t more. But healthy stuff!';
    }
  }
}
