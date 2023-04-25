import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:provider/provider.dart';
import 'package:riddle/screens/home_screen.dart';

import '../providers/daily_login_provider.dart';

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Welcome!',
      subTitle: 'Test your knowledge about India with challenging questions',
      imageUrl: 'assets/images/onboarding1.png',
    ),
    Introduction(
      title: 'Interesting Facts',
      subTitle: 'Discover fascinating information about India as you play',
      imageUrl: 'assets/images/onboarding2.png',
    ),
    Introduction(
      title: 'Challenge Yourself',
      subTitle: 'Put your India knowledge to the test and see how well you do',
      imageUrl: 'assets/images/onboarding3.png',
    ),
    Introduction(
      title: 'Become a Quiz Master',
      subTitle: 'Answer all the questions correctly to become a champion',
      imageUrl: 'assets/images/onboarding4.png',
    ),
  ];

  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyLogin = Provider.of<DailyLoginProvider>(context);
    return IntroScreenOnboarding(
      backgroudColor: Colors.white,
      introductionList: list,
      onTapSkipButton: () {
        dailyLogin.setFirstLaunchFalse();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
