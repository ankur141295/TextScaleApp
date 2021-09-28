import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int counter1 = 0;
  int counter2 = 0;

  void updateCounter1(int value) {
    counter1 = value;
    notifyListeners();
  }

  void updateCounter2(int value) {
    counter2 = value;
    notifyListeners();
  }
}
