import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnswerStreakProvider with ChangeNotifier {
  int _currentStrak = 0;
  get currentStrak => _currentStrak;

  List<String> _nextReward = ["Coins", "10"];
  get nextReward => _nextReward;

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
    Random random = Random();
    int rndm = random.nextInt(101);
    print("Random num is $rndm");

    if (rndm < 35) {
      _nextReward = ["Coins", "10"];
    } else if (rndm > 35 && rndm < 65) {
      _nextReward = ["Heart", "1"];
    } else if (rndm > 65 && rndm < 85) {
      _nextReward = ["Coins", "20"];
    } else {
      _nextReward = ["Heart", "2"];
    }
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final currentStrak = prefs.getInt("currentStreak");
    if (currentStrak != null) {
      _currentStrak = currentStrak;
    }
    final nextReward = prefs.getStringList("nextReward");
    if (nextReward != null) {
      _nextReward = nextReward;
    }
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentStreak', _currentStrak);
    await prefs.setStringList('nextReward', _nextReward);
  }
}
