import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/answer_streak_provider.dart';
import 'package:translator/translator.dart';

import '../providers/questions_language_provider.dart';
import '../screens/quiz_screen.dart';

class QuestionNameBox extends StatefulWidget {
  const QuestionNameBox({
    super.key,
    required this.widget,
  });

  final QuizScreen widget;

  @override
  State<QuestionNameBox> createState() => _QuestionNameBoxState();
}

class _QuestionNameBoxState extends State<QuestionNameBox> {
  String? translatrdQuestion;
  int translatrdQuestionNo = 0;
  bool isTranslating = true;

  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    });
  }

  @override
  Widget build(BuildContext context) {
    final qLanguage =
        Provider.of<QuestionsLanguageProvider>(context, listen: false);
    final streak = Provider.of<AnswerStreakProvider>(context, listen: false);
    final translator = GoogleTranslator();

    void translateQ() {
      translator
          .translate(widget.widget.questions[0].question,
              from: 'en', to: qLanguage.language)
          .then((s) {
        print(qLanguage.language);
        setState(() {
          translatrdQuestion = s.toString();
          translatrdQuestionNo++;
          isTranslating = false;
        });
      });
    }

    if (qLanguage.language != "en" && translatrdQuestionNo == 0) translateQ();

    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.brown[300]!,
                  width: 5.0,
                ),
              ),
              child: Text(
                translatrdQuestion != null
                    ? translatrdQuestion!
                    : widget.widget.questions[0].question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (!widget.widget.questions[0].isCompleted)
              Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.purpleAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 320,
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: streak.currentStrak == 1
                            ? 0.33
                            : streak.currentStrak == 2
                                ? 0.66
                                : streak.currentStrak == 3
                                    ? 1
                                    : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.green, Colors.deepPurpleAccent],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Correct ${streak.currentStrak}/3',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  streak.nextReward[0] == "Coins"
                                      ? Icons.monetization_on
                                      : Icons.favorite,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '+${streak.nextReward[1]}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (!hasInternet && qLanguage.language != 'en')
          Positioned(
            bottom: !widget.widget.questions[0].isCompleted ? 48 : 12,
            right: 3.5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "No Internet",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
