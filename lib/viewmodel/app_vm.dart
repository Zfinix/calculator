import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  String _kOperator = '';
  String get kOperator => _kOperator;
  set kOperator(String val) {
    _kOperator = val;
    notifyListeners();
  }

  num _kSecondary = 0;
  num get kSecondary => _kSecondary;
  set kSecondary(num val) {
    _kSecondary = val;
    notifyListeners();
  }

  num _kPrimary = 0;
  num get kPrimary => _kPrimary;
  set kPrimary(num val) {
    kResult = _kPrimary = val;
    notifyListeners();
  }

  bool _kJustChanged = false;
  bool get kJustChanged => _kJustChanged;
  set kJustChanged(bool val) {
    _kJustChanged = val;
    notifyListeners();
  }

  bool _kDecimal = false;
  bool get kDecimal => _kDecimal;
  set kDecimal(bool val) {
    _kDecimal = val;
    notifyListeners();
  }

  TextEditingController result = TextEditingController(text: '0');
  num get kResult => num.parse(result.text);
  set kResult(val) {
    result.text =
        '${val.toString().length >= 7 ? val.toStringAsExponential(4) : val}';
    notifyListeners();
  }

  addDigit(newDigit) {
    if (kJustChanged) {
      kSecondary = kPrimary;
      kPrimary = kDecimal ? (newDigit / 10) : newDigit;
      kJustChanged = false;
    } else if (!kDecimal) {
      kPrimary = 10 * kPrimary + newDigit;
    } else if (kDecimal) {
      kPrimary = kPrimary.toString().indexOf('.') == -1
          ? double.parse('$kPrimary.$newDigit')
          : double.parse('$kPrimary$newDigit');
    }
  }

  changeOperator([newOperator]) {
    if (kJustChanged) {
      print('$kSecondary $kOperator $kPrimary = ?');
    }
    kJustChanged = !kJustChanged;
    kOperator = newOperator;
  }

  equal() {
    var result;
    var _secondary = kSecondary;
    switch (kOperator) {
      case '+':
        result = kSecondary + kPrimary;
        kSecondary = 0;
        break;
      case '-':
        result = kSecondary - kPrimary;
        kSecondary = 0;
        break;
      case '/':
        result = kSecondary / kPrimary;
        kSecondary = 0;
        break;
      case '*':
        result = kSecondary * kPrimary;
        kSecondary = 0;
        break;
      case '=':
        break;
      default:
    }

    print('$_secondary $kOperator $kPrimary = $result');
    kPrimary = result;

    kResult = kPrimary;
  }

  void ac() {
    kPrimary = 0;
    kSecondary = 0;
    kResult = 0;
    kOperator = '';
    kDecimal = false;
    kJustChanged = false;
  }
}
