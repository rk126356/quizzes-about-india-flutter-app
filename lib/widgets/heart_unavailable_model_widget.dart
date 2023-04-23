import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riddle/screens/store_screen.dart';
import 'package:translator/translator.dart';

import '../providers/daily_login_provider.dart';
import '../providers/questions_language_provider.dart';

class HeartUnavailableScreen extends StatefulWidget {
  const HeartUnavailableScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HeartUnavailableScreen> createState() => _HeartUnavailableScreenState();
}

class _HeartUnavailableScreenState extends State<HeartUnavailableScreen> {
  String des = 'Sorry, no hearts left. You will get 5 hearts after:';
  String title = 'Hearts Unavailable';
  int translatrdQuestionNo = 0;

  @override
  Widget build(BuildContext context) {
    final qLanguage =
        Provider.of<QuestionsLanguageProvider>(context, listen: false);
    final dailyLogin = Provider.of<DailyLoginProvider>(context);
    final translator = GoogleTranslator();

    void translateQ() {
      translator.translate(des, from: 'en', to: qLanguage.language).then((s) {
        setState(() {
          des = s.toString();
        });
      });
      translator.translate(title, from: 'en', to: qLanguage.language).then((s) {
        setState(() {
          title = s.toString();
        });
      });
    }

    if (translatrdQuestionNo == 0) {
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
                    color: Colors.red,
                  ),
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  left: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  right: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$des ${dailyLogin.timeLeft.inHours.remainder(24).toString().padLeft(2, '0')}:${(dailyLogin.timeLeft.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(dailyLogin.timeLeft.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: 100,
                    child: Text(
                      'OK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StoreScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const SizedBox(
                    width: 135,
                    child: Text(
                      'Get Hearts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
