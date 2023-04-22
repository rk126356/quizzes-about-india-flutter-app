import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../providers/questions_language_provider.dart';

class HintAnswerScreen extends StatefulWidget {
  final VoidCallback onNext;
  final String explanation;
  final String title;
  final String btnTitle;

  const HintAnswerScreen({
    super.key,
    required this.onNext,
    required this.explanation,
    required this.title,
    required this.btnTitle,
  });

  @override
  State<HintAnswerScreen> createState() => _HintAnswerScreenState();
}

class _HintAnswerScreenState extends State<HintAnswerScreen> {
  String? ans;
  int translatrdQuestionNo = 0;
  @override
  Widget build(BuildContext context) {
    final qLanguage =
        Provider.of<QuestionsLanguageProvider>(context, listen: false);
    final translator = GoogleTranslator();
    void translateQ() async {
      translator
          .translate(widget.explanation, from: 'en', to: qLanguage.language)
          .then((s) {
        print("Translated ans = $s");
        setState(() {
          ans = s.toString();
        });
      });
    }

    if (qLanguage.language != "en" && translatrdQuestionNo == 0) {
      translateQ();
      translatrdQuestionNo++;
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(16),
                border: const Border(
                  top: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                  right: BorderSide(
                    width: 2,
                    color: Colors.blue,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ans != null ? ans! : widget.explanation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.btnTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
