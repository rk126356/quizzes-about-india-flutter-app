import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/daily_login_provider.dart';
import '../models/questions_model.dart';
import '../providers/heart_provider.dart';
import '../screens/quiz_screen.dart';
import 'heart_unavailable_model_widget.dart';
import 'hint_answer_model_widget.dart';
import 'dart:io' show Platform;

class LevelGridView extends StatefulWidget {
  final List<List<Question>> levels;
  const LevelGridView({super.key, required this.levels});

  @override
  // ignore: library_private_types_in_public_api
  _LevelGridViewState createState() => _LevelGridViewState();
}

class _LevelGridViewState extends State<LevelGridView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ScrollController _scrollController;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // replace with your actual Ad Unit ID for Android
      : 'ca-app-pub-3940256099942544/1033173712'; // replace with your actual Ad Unit ID for iOS

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _scrollController = ScrollController();
    loadAd();
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isInterstitialAdLoaded = false;
          _interstitialAd!.dispose();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _interstitialAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetIndex = widget.levels.indexWhere((level) =>
        level.every((question) => question.isUnlocked) &&
        !level.every((question) => question.isCompleted));
    // scroll to the target box if it exists
    if (targetIndex >= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          targetIndex * MediaQuery.of(context).size.height / 3000 * targetIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          3000 * 3000,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }

    return GridView.count(
      controller: _scrollController, //
      crossAxisCount: 4,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: List.generate(
        widget.levels.length,
        (index) {
          final level = index + 1; // get the level of the first question
          final isUnlocked =
              widget.levels[index].every((question) => question.isUnlocked);
          final isCompleted =
              widget.levels[index].every((question) => question.isCompleted);
          return ScaleTransition(
            scale: _animation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  final heartProvider =
                      Provider.of<HeartProvider>(context, listen: false);
                  final ads =
                      Provider.of<DailyLoginProvider>(context, listen: false);

                  if (heartProvider.hearts <= 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const HeartUnavailableScreen();
                      },
                    );
                  } else {
                    if (!isUnlocked) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return HintAnswerScreen(
                            onNext: () {
                              Navigator.pop(context);
                            },
                            explanation:
                                'This question is locked, please complete the previous question first!',
                            title: 'Question Locked!',
                            btnTitle: 'Got it!',
                          );
                        },
                      );
                    } else {
                      if (_isInterstitialAdLoaded && ads.shouldShowAds) {
                        _interstitialAd!.show();
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                              questions: widget.levels[index],
                              itemNo: level,
                              level: widget.levels),
                        ),
                      );
                    }
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        level.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isUnlocked && !isCompleted)
                        const Icon(Icons.play_arrow, color: Colors.orange),
                      if (!isUnlocked && !isCompleted)
                        const Icon(Icons.lock, color: Colors.black),
                      if (isCompleted && isUnlocked)
                        const Icon(Icons.check, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
