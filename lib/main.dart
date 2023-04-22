import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/answer_streak_provider.dart';
import 'package:riddle/providers/coin_provider.dart';
import 'package:riddle/providers/daily_login_provider.dart';
import 'package:riddle/providers/heart_provider.dart';
import 'package:riddle/providers/questions_language_provider.dart';
import 'package:riddle/providers/questions_provider.dart';
import 'package:riddle/providers/utils_provider.dart';
import 'package:riddle/screens/home_screen.dart';
import 'package:riddle/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoinProvider()),
        ChangeNotifierProvider(create: (_) => HeartProvider()),
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
        ChangeNotifierProvider(create: (_) => DailyLoginProvider()),
        ChangeNotifierProvider(create: (_) => UtilsProvider()),
        ChangeNotifierProvider(create: (_) => QuestionsLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AnswerStreakProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dailyLogin = Provider.of<DailyLoginProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzes About India',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Righteous', // <-- specify default font
      ),
      home: dailyLogin.firstLaunch ? TestScreen() : const HomeScreen(),
    );
  }
}
