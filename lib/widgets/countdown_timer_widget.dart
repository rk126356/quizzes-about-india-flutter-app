import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/utils_provider.dart';

import '../providers/coin_provider.dart';
import '../providers/daily_login_provider.dart';
import '../providers/heart_provider.dart';

Timer? timer;

class CountdownTimer extends StatefulWidget {
  final int duration;
  final VoidCallback onFinished;

  const CountdownTimer(
      {Key? key, required this.duration, required this.onFinished})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _timeRemaining = 0;
  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3442981380712673/1082598831' // replace with your actual Ad Unit ID for Android
      : 'ca-app-pub-3442981380712673/1082598831'; // replace with your actual Ad Unit ID for iOS

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.duration;
    _startTimer();
    loadAd();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          timer.cancel();
          widget.onFinished();
        }
      });
    });
  }

  void pauseTimer() {
    timer!.cancel();
  }

  void resumeTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          timer.cancel();
          widget.onFinished();
        }
      });
    });
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

  @override
  Widget build(BuildContext context) {
    final adsWatched = Provider.of<DailyLoginProvider>(context, listen: false);
    final coinsprovider = Provider.of<CoinProvider>(context, listen: false);
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final musicPlayer = Provider.of<UtilsProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: _isRewardedAdLoaded && adsWatched.adsWatched < 5
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (_isRewardedAdLoaded && adsWatched.adsWatched < 5)
          GestureDetector(
            onTap: () {
              pauseTimer();
              if (musicPlayer.isMusicTurnedOn) musicPlayer.musicPlayingFalse();
              _rewardedAd.show(
                onUserEarnedReward: (ad, reward) {
                  coinsprovider.addCoin(5);
                  adsWatched.increaseAdsWatched();
                  setState(() {
                    _isRewardedAdLoaded = false;
                  });
                  resumeTimer();
                  if (musicPlayer.isMusicTurnedOn) {
                    musicPlayer.musicPlayingTrue();
                    musicPlayer.quizMusicPlayingTrue();
                  }
                  loadAd();
                },
              );
            },
            child: Container(
              width: 125,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.orange,
                  width: 5.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.monetization_on,
                    size: 25,
                    color: Colors.green,
                  ),
                  Text(
                    '+5 AD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Container(
          width: 105,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.red[300]!,
              width: 5.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.timer,
                size: 25,
                color: Colors.red,
              ),
              Text(
                '$_timeRemaining',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        if (_isRewardedAdLoaded && adsWatched.adsWatched < 5)
          GestureDetector(
            onTap: () {
              pauseTimer();
              if (musicPlayer.isMusicTurnedOn) musicPlayer.musicPlayingFalse();
              _rewardedAd.show(
                onUserEarnedReward: (ad, reward) {
                  heartProvider.addHeart(1);
                  adsWatched.increaseAdsWatched();
                  setState(() {
                    _isRewardedAdLoaded = false;
                  });
                  resumeTimer();
                  if (musicPlayer.isMusicTurnedOn) {
                    musicPlayer.musicPlayingTrue();
                    musicPlayer.quizMusicPlayingTrue();
                  }
                  loadAd();
                },
              );
            },
            child: Container(
              width: 125,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.orange,
                  width: 5.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.favorite,
                    size: 25,
                    color: Colors.green,
                  ),
                  Text(
                    '+1 AD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    _rewardedAd.dispose();
    super.dispose();
  }
}
