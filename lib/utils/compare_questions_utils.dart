import '../models/questions_model.dart';

List<Question> removeDuplicateQuestions(List<Question> questionsList) {
  List<String> uniqueQuestions = [];
  List<Question> result = [];
  for (Question question in questionsList) {
    if (!uniqueQuestions.contains(question.question)) {
      uniqueQuestions.add(question.question);
      result.add(question);
    }
  }
  return result;
}

void printDuplicateQuestions(List<Question> questionsList) {
  List<String> uniqueQuestions = [];
  for (Question question in questionsList) {
    if (uniqueQuestions.contains(question.question)) {
      print("Duplicate question found: ${question.question}");
    } else {
      uniqueQuestions.add(question.question);
    }
  }
}
