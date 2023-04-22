import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerStreakProvider with ChangeNotifier {
  int _currentStrak = 0;
  get currentStrak => _currentStrak;

  AnswerStreakProvider() {
    _loadFromPrefs();
  }

  void increaseCurrentStrak() {
    if (_currentStrak < 3) _currentStrak++;
    _saveToPrefs();
    notifyListeners();
  }

  void decreaseCurrentStrak() {
    if (_currentStrak > 0) _currentStrak--;
    _saveToPrefs();
    notifyListeners();
  }

  void resetCurrentStrak() {
    _currentStrak = 0;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final currentStrak = prefs.getInt("currentStreak");
    if (currentStrak != null) {
      _currentStrak = currentStrak;
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStreak', _currentStrak);
  }
}
