import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyLoginProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  bool _isNewDay = false;
  bool get isNewDay => _isNewDay;

  int _adsWatched = 0;
  int get adsWatched => _adsWatched;

  Duration _timeLeft = Duration.zero;
  Duration get timeLeft => _timeLeft;

  bool _firstLaunch = true;
  get firstLaunch => _firstLaunch;

  DailyLoginProvider() {
    _initSharedPreferences();
  }

  void increaseAdsWatched() {
    _adsWatched++;
    _saveAdsWatched();
    notifyListeners();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _checkNewDay();
    _startTimer();
    _checkAdsWatched();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final firstLaunch = _prefs?.getBool('isFirstLaunch');
    if (firstLaunch != null) {
      _firstLaunch = firstLaunch;
    }
  }

  Future<void> _saveIsFirstLaunch() async {
    await _prefs?.setBool('isFirstLaunch', _firstLaunch);
  }

  void setFirstLaunchFalse() {
    _firstLaunch = false;
    _saveIsFirstLaunch();
    notifyListeners();
  }

  Future<void> login() async {
    await _prefs?.setInt('lastLogin', DateTime.now().millisecondsSinceEpoch);
    _isNewDay = false;
    _adsWatched = 0;
    _startTimer();
    notifyListeners();
  }

  Future<void> _checkNewDay() async {
    final lastLogin = _prefs?.getInt('lastLogin');
    if (lastLogin == null) {
      _isNewDay = true;
      return;
    }
    final lastLoginDate = DateTime.fromMillisecondsSinceEpoch(lastLogin);
    final now = DateTime.now();
    _isNewDay = now.year > lastLoginDate.year ||
        now.month > lastLoginDate.month ||
        now.day > lastLoginDate.day;
  }

  Future<void> _checkAdsWatched() async {
    final adsWatchedPrefix = _prefs?.getInt('adsWatched');
    if (adsWatchedPrefix != null) {
      _adsWatched = adsWatchedPrefix;
    }
  }

  Future<void> _saveAdsWatched() async {
    await _prefs?.setInt('adsWatched', _adsWatched);
  }

  void _startTimer() {
    _timeLeft = const Duration(hours: 18) - _getTimeSinceLastLogin();
    if (_timeLeft.isNegative) {
      _timeLeft = Duration.zero;
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        _startTimer();
      });
    }
    notifyListeners();
  }

  Duration _getTimeSinceLastLogin() {
    final lastLogin = _prefs?.getInt('lastLogin');
    if (lastLogin == null) {
      return Duration.zero;
    }
    final lastLoginDate = DateTime.fromMillisecondsSinceEpoch(lastLogin);
    final now = DateTime.now();
    return now.difference(lastLoginDate);
  }
}
