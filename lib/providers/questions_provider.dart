import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/questions_model.dart';
import '../utils/compare_questions_utils.dart';

List<Question> providerGlobalQuestionsList = questionsList;

class QuestionsProvider extends ChangeNotifier {
  List<Question> _questionsList = [];

  QuestionsProvider() {
    _questionsList = [
      // your list of questions
    ];

    // load questionsList from local storage on initialization
    _loadQuestionsList();
  }

  List<Question> get questionsList => _questionsList;

  void markQuestionCompleted(int index) {
    _questionsList[index].markCompleted();
    _saveQuestionsList(); // save questionsList to local storage
    notifyListeners();
  }

  void markQuestionUnlocked(int index) {
    _questionsList[index].markUnlocked();
    _saveQuestionsList(); // save questionsList to local storage
    notifyListeners();
  }

  void markQuestionIncomplete(int index) {
    _questionsList[index].markIncomplete();
    _saveQuestionsList(); // save questionsList to local storage
    notifyListeners();
  }

  // save questionsList to local storage
  void _saveQuestionsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> encodedQuestions =
        _questionsList.map((q) => jsonEncode(q.toJson())).toList();
    await prefs.setStringList('questionsList', encodedQuestions);
  }

  // load questionsList from local storage
  void _loadQuestionsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedQuestions = prefs.getStringList('questionsList');
    if (encodedQuestions != null) {
      _questionsList = encodedQuestions
          .map((q) => Question.fromJson(json.decode(q)))
          .toList();
      print("I run");
      notifyListeners();
    } else {
      _questionsList = providerGlobalQuestionsList;
      print("I run else");
      notifyListeners();
    }
    compareQuestions();
  }

  void compareQuestions() {
    if (_questionsList.length != providerGlobalQuestionsList.length) {
      for (var i = _questionsList.length;
          i < providerGlobalQuestionsList.length;
          i++) {
        _questionsList.add(providerGlobalQuestionsList[i]);
      }
    } else {
      for (var i = 0; i < providerGlobalQuestionsList.length; i++) {
        if (_questionsList[i].question !=
            providerGlobalQuestionsList[i].question) {
          if (_questionsList[i].isUnlocked) {
            _questionsList[i] = providerGlobalQuestionsList[i];
            _questionsList[i].isUnlocked = true;
            _questionsList[i].isCompleted = false;
          } else {
            _questionsList[i] = providerGlobalQuestionsList[i];
          }
        }
      }
    }
    printDuplicateQuestions(providerGlobalQuestionsList);
    notifyListeners();
  }
}
