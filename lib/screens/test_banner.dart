import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TestAds extends StatefulWidget {
  const TestAds({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TestAdsState createState() => _TestAdsState();
}

class _TestAdsState extends State<TestAds> {
  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917' // replace with your actual Ad Unit ID for Android
      : 'ca-app-pub-3940256099942544/5224354917'; // replace with your actual Ad Unit ID for iOS

  @override
  void initState() {
    super.initState();
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
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Example'),
      ),
      body: Center(
        child: _isRewardedAdLoaded
            ? GestureDetector(
                onTap: () {
                  _rewardedAd.show(
                    onUserEarnedReward: (ad, reward) {},
                  );
                },
                child: const Text("See Ads"),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
