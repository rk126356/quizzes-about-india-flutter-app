import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsLanguageProvider with ChangeNotifier {
  String _language = "en";
  String _languageName = "English";

  QuestionsLanguageProvider() {
    _loadFromPrefs();
  }

  get language => _language;
  get languageName => _languageName;

  void changeLanguage(String language) {
    _language = language;
    _saveToPrefs();
    notifyListeners();
  }

  void changeLanguageName(String language) {
    _languageName = language;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString("language");
    if (language != null) {
      _language = language;
      notifyListeners();
    }
    final languageName = prefs.getString("languageName");
    if (languageName != null) {
      _languageName = languageName;
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _language);
    await prefs.setString('languageName', _languageName);
  }
}
