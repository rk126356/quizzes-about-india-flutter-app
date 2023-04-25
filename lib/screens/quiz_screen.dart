import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riddle/models/questions_model.dart';
import 'package:riddle/providers/utils_provider.dart';
import 'package:riddle/screens/play_screen.dart';
import 'package:riddle/screens/store_screen.dart';
import '../providers/answer_streak_provider.dart';
import '../providers/daily_login_provider.dart';
import '../providers/heart_provider.dart';
import '../providers/questions_provider.dart';
import '../widgets/appbar_actions_widget.dart';
import '../widgets/choice_button_widget.dart';
import '../widgets/correct_answer_model_widget.dart';
import '../widgets/countdown_timer_widget.dart';
import '../widgets/heading_text_widget.dart';
import '../widgets/heart_unavailable_model_widget.dart';
import '../widgets/hint_answer_model_widget.dart';
import '../widgets/positioned_buttons_widget.dart';
import 'package:provider/provider.dart';
import '../providers/coin_provider.dart';
import '../widgets/question_name_box.dart';
import '../widgets/wrong_answer_model.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final int itemNo;
  final List<List<Question>> level;

  const QuizScreen(
      {Key? key,
      required this.questions,
      required this.itemNo,
      required this.level})
      : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  void handleCompletedSkipPressed() {
    if (questionsList.length != widget.itemNo) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizScreen(
                  itemNo: widget.itemNo + 1,
                  questions: widget.level[widget.itemNo],
                  level: widget.level,
                )),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PlayScreen(),
        ),
      );
    }
  }

  void handleCompletedViewPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HintAnswerScreen(
          btnTitle: "Thanks!",
          explanation: widget.questions[0].answer,
          title: "Answer",
          onNext: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void handleSkipButtonPress() {
    timer!.cancel();
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final coinProvider = Provider.of<CoinProvider>(context, listen: false);
    final questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);
    final sound = Provider.of<UtilsProvider>(context, listen: false);

    if (widget.questions[0].isSkipped) {
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/skip1.mp3'));
      }
      if (questionsList.length != widget.itemNo) {
        questionsProvider.markQuestionUnlocked(widget.itemNo);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizScreen(
                    itemNo: widget.itemNo + 1,
                    questions: widget.level[widget.itemNo],
                    level: widget.level,
                  )),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PlayScreen(),
          ),
        );
      }
      return;
    }

    if (heartProvider.hearts <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const HeartUnavailableScreen();
        },
      );
      return;
    }

    if (coinProvider.coins >= 10) {
      coinProvider.subtractCoins(10);
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/skip1.mp3'));
      }
      if (questionsList.length != widget.itemNo) {
        questionsProvider.markQuestionUnlocked(widget.itemNo);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizScreen(
                    itemNo: widget.itemNo + 1,
                    questions: widget.level[widget.itemNo],
                    level: widget.level,
                  )),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PlayScreen(),
          ),
        );
      }
      widget.questions[0].isSkipped = true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Okay!",
            explanation: 'You don\'t have enough coins.',
            title: "Low Coins!",
            doubleButtonTitle: "Get More Coins >",
            onNext: () {
              Navigator.pop(context);
            },
            onNextDoubleButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StoreScreen(),
                ),
              );
            },
          );
        },
      );
    }
  }

  void handleHintButtonPress() {
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final coinProvider = Provider.of<CoinProvider>(context, listen: false);
    final sound = Provider.of<UtilsProvider>(context, listen: false);

    if (widget.questions[0].isHintShowed) {
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/hint1.mp3'));
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Thanks!",
            explanation: widget.questions[0].hint,
            title: "Hint",
            onNext: () {
              Navigator.pop(context);
            },
          );
        },
      );
      return;
    }

    if (heartProvider.hearts <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const HeartUnavailableScreen();
        },
      );
      return;
    }

    if (coinProvider.coins >= 20) {
      coinProvider.subtractCoins(20);
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/hint1.mp3'));
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Thanks!",
            explanation: widget.questions[0].hint,
            title: "Hint",
            onNext: () {
              Navigator.pop(context);
            },
          );
        },
      );
      widget.questions[0].isHintShowed = true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Okay!",
            explanation: 'You don\'t have enough coins.',
            title: "Low Coins!",
            doubleButtonTitle: "Get More Coins >",
            onNext: () {
              Navigator.pop(context);
            },
            onNextDoubleButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StoreScreen(),
                ),
              );
            },
          );
        },
      );
    }
  }

  void handleViewButtonPress() {
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final coinProvider = Provider.of<CoinProvider>(context, listen: false);
    final sound = Provider.of<UtilsProvider>(context, listen: false);

    if (widget.questions[0].isAnswerShowed) {
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/ans1.mp3'));
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Thanks!",
            explanation: widget.questions[0].answer,
            title: "Answer",
            onNext: () {
              Navigator.pop(context);
            },
          );
        },
      );
      return;
    }

    if (heartProvider.hearts <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const HeartUnavailableScreen();
        },
      );
      return;
    }

    if (coinProvider.coins >= 30) {
      coinProvider.subtractCoins(30);

      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/ans1.mp3'));
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Thanks!",
            explanation: widget.questions[0].answer,
            title: "Answer",
            onNext: () {
              Navigator.pop(context);
            },
          );
        },
      );
      widget.questions[0].isAnswerShowed = true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return HintAnswerScreen(
            btnTitle: "Okay!",
            explanation: 'You don\'t have enough coins.',
            title: "Low Coins!",
            doubleButtonTitle: "Get More Coins >",
            onNext: () {
              Navigator.pop(context);
            },
            onNextDoubleButton: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const StoreScreen(),
                ),
              );
            },
          );
        },
      );
    }
  }

  void handleChoiceButtonPressed(String choice) {
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final sound = Provider.of<UtilsProvider>(context, listen: false);
    final streak = Provider.of<AnswerStreakProvider>(context, listen: false);
    if (heartProvider.hearts <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const HeartUnavailableScreen();
        },
      );
      return;
    }

    if (choice == widget.questions[0].answer) {
      timer!.cancel();
      if (!widget.questions[0].isCompleted) streak.increaseCurrentStrak();

      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/success1.mp3'));
      }

      final questionsProvider =
          Provider.of<QuestionsProvider>(context, listen: false);
      if (questionsList.length != widget.itemNo) {
        questionsProvider.markQuestionCompleted(widget.itemNo - 1);
        questionsProvider.markQuestionUnlocked(widget.itemNo);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CorrectAnswerScreen(
              explanation: widget.questions[0].explanation,
              onNext: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizScreen(
                            itemNo: widget.itemNo + 1,
                            questions: widget.level[widget.itemNo],
                            level: widget.level,
                          )),
                );
              },
            );
          },
        );
      } else {
        questionsProvider.markQuestionCompleted(widget.itemNo - 1);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CorrectAnswerScreen(
              explanation: widget.questions[0].explanation,
              onNext: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlayScreen(),
                  ),
                );
              },
            );
          },
        );
      }
    } else {
      if (!widget.questions[0].isCompleted) streak.decreaseCurrentStrak();
      heartProvider.subtractHearts();
      if (sound.isSounsPlaying) {
        final player = AudioPlayer();
        player.play(AssetSource('audio/fail1.mp3'));
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return WrongAnswerScreen(
            explanation: "The answer is wrong, please try again.",
            title: "Opps! ❤ - 1",
            onNext: () {
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917' // replace with your actual Ad Unit ID for Android
      : 'ca-app-pub-3940256099942544/5224354917'; // replace with your actual Ad Unit ID for iOS

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  void dispose() {
    _rewardedAd.dispose();
    timer!.cancel();
    super.dispose();
  }

  void loadAd() {
    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdLoaded = false;
              });
            },
          );
          setState(() {
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print(err);
          }
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  void doubleRewards(bool isCoin, int value) {
    final coin = Provider.of<CoinProvider>(context, listen: false);
    final heart = Provider.of<HeartProvider>(context, listen: false);
    final musicPlayer = Provider.of<UtilsProvider>(context, listen: false);
    final adsWatched = Provider.of<DailyLoginProvider>(context, listen: false);

    if (musicPlayer.isMusicTurnedOn) {
      musicPlayer.quizMusicPlayingFalse();
    }
    _rewardedAd.show(
      onUserEarnedReward: (ad, reward) {
        if (isCoin) {
          coin.addCoin(value);
        } else {
          heart.addHearts(value);
        }
        adsWatched.increaseAdsWatched();
        setState(() {
          _isRewardedAdLoaded = false;
        });

        if (musicPlayer.isMusicTurnedOn) {
          musicPlayer.quizMusicPlayingTrue();
        }
        loadAd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final music = Provider.of<UtilsProvider>(context, listen: false);
    final streak = Provider.of<AnswerStreakProvider>(context, listen: false);
    final coin = Provider.of<CoinProvider>(context, listen: false);
    final heart = Provider.of<HeartProvider>(context, listen: false);
    final adsWatched = Provider.of<DailyLoginProvider>(context, listen: false);

    Future<void> delayedFunction() async {
      await Future.delayed(const Duration(seconds: 1));
      if (streak.currentStrak == 3) {
        String currentReward = "";
        bool isCoinIcon = false;
        if (streak.nextReward[0] == "Coins") {
          coin.addCoin(int.parse(streak.nextReward[1]));
          currentReward = streak.nextReward[1];
          isCoinIcon = true;
        } else {
          heart.addHearts(int.parse(streak.nextReward[1]));
          currentReward = streak.nextReward[1];
          isCoinIcon = false;
        }
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return HintAnswerScreen(
                explanation: "You have completed the 3 strak challenge",
                title: isCoinIcon
                    ? "WoW! 💰 + $currentReward"
                    : "WoW! ❤ + $currentReward",
                onNext: () {
                  Navigator.pop(context);
                },
                btnTitle: isCoinIcon
                    ? "Claim 💰 +$currentReward"
                    : "Claim ❤ +$currentReward",
                doubleButtonTitle:
                    _isRewardedAdLoaded && adsWatched.adsWatched < 5
                        ? isCoinIcon
                            ? "Claim 💰 +${int.parse(currentReward) * 2} [AD]"
                            : "Claim ❤ +${int.parse(currentReward) * 2} [AD]"
                        : null,
                onNextDoubleButton: () {
                  doubleRewards(isCoinIcon, int.parse(currentReward));
                  Navigator.pop(context);
                });
          },
        );
        streak.resetCurrentStrak();
      }
    }

    delayedFunction();

    if (music.isMusicTurnedOn) {
      music.quizMusicPlayingTrue();
    }

    return WillPopScope(
      onWillPop: () async {
        if (music.isMusicTurnedOn) {
          music.stopQuizMusic();
          music.quizMusicPlayingFalse();
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PlayScreen()),
          (route) => false,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const PlayScreen()),
                (route) => false,
              );
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: const [
            AppBarActions(),
          ],
          title: const Text('Quiz'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFFFC3B1), Color(0xFFDEADAF)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      HeadingText(currentQuestionIndex: widget.itemNo - 1),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      QuestionNameBox(widget: widget),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                        child: CountdownTimer(
                          duration: 120,
                          onFinished: () {
                            if (music.isSounsPlaying) {
                              final player = AudioPlayer();
                              player.play(AssetSource('audio/fail1.mp3'));
                            }
                            final heartProvider = Provider.of<HeartProvider>(
                                context,
                                listen: false);
                            heartProvider.subtractHearts();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WrongAnswerScreen(
                                  explanation:
                                      "The timer has finished, please try again.",
                                  title: "Opps! ❤ - 1",
                                  onNext: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuizScreen(
                                                itemNo: widget.itemNo,
                                                questions: widget
                                                    .level[widget.itemNo - 1],
                                                level: widget.level,
                                              )),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.questions[0].choices.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ChoiceButton(
                                  index: index + 1,
                                  text: widget.questions[0].choices[index],
                                  onPressed: () {
                                    handleChoiceButtonPressed(
                                        widget.questions[0].choices[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PositionedButtons(
              onSkipPressed: handleSkipButtonPress,
              onHintPressed: handleHintButtonPress,
              onViewPressed: handleViewButtonPress,
              onCompletedSkipPressed: handleCompletedSkipPressed,
              onCompletedViewPressed: handleCompletedViewPressed,
              isCompleted: widget.questions[0].isCompleted,
              isAnswerShowed: widget.questions[0].isAnswerShowed,
              isHintShowed: widget.questions[0].isHintShowed,
              isSkipped: widget.questions[0].isSkipped,
            )
          ],
        ),
      ),
    );
  }
}
