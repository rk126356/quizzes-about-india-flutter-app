import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartProvider with ChangeNotifier {
  int _hearts = 0;
  static const String _heartsKey = 'hearts';
  bool _shouldTimerStop = false;

  HeartProvider() {
    _loadData();
  }

  int get hearts => _hearts;
  bool get shouldTimerStop => _shouldTimerStop;

  void changeTimerStop(bool value) {
    _shouldTimerStop = value;
  }

  void addHeart(int value) {
    _hearts += value;
    _saveData();
    notifyListeners();
  }

  void subtractHearts() {
    if (_hearts > 0) {
      _hearts--;
      _saveData();
      notifyListeners();
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedHearts = prefs.getInt(_heartsKey);
    if (storedHearts != null) {
      _hearts = storedHearts;
      notifyListeners();
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_heartsKey, _hearts);
  }

  void addHearts(int value) {
    _hearts += value;
    _saveData();
    notifyListeners();
  }
}
