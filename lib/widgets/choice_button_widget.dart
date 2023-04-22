import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import '../providers/questions_language_provider.dart';

class ChoiceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final int index;

  const ChoiceButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.index,
  }) : super(key: key);

  @override
  State<ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  int translatrdQuestionNo = 0;
  String? choice;

  @override
  Widget build(BuildContext context) {
    final qLanguage =
        Provider.of<QuestionsLanguageProvider>(context, listen: false);
    final translator = GoogleTranslator();
    void translateQ() {
      translator
          .translate(widget.text, from: 'en', to: qLanguage.language)
          .then((s) {
        setState(() {
          choice = s.toString();
          translatrdQuestionNo++;
        });
      });
    }

    if (qLanguage.language != "en" && translatrdQuestionNo == 0) translateQ();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4.0,
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.index.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Text(
                  choice != null ? choice! : widget.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
