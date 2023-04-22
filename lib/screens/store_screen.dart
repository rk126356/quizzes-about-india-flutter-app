import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/heart_provider.dart';
import '../providers/coin_provider.dart';
import '../providers/daily_login_provider.dart';
import '../providers/utils_provider.dart';
import '../widgets/appbar_actions_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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
          print(err);
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coinsprovider = Provider.of<CoinProvider>(context, listen: false);
    final heartProvider = Provider.of<HeartProvider>(context, listen: false);
    final adsWatched = Provider.of<DailyLoginProvider>(context, listen: false);
    final musicPlayer = Provider.of<UtilsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        actions: const [AppBarActions()],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple,
                Colors.purple,
              ],
            ),
          ),
          child: Column(
            children: [
              if (_isRewardedAdLoaded && adsWatched.adsWatched < 100)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 26),
                    const Text(
                      'FREE',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _BuyItem(
                            value: 5,
                            price: 1,
                            icon: Icons.monetization_on,
                            title: "5 coins",
                            btnText: "Watch Ad",
                            onClick: () {
                              musicPlayer.musicPlayingFalse();
                              _rewardedAd.show(
                                onUserEarnedReward: (ad, reward) {
                                  coinsprovider.addCoin(5);
                                  adsWatched.increaseAdsWatched();
                                  setState(() {
                                    _isRewardedAdLoaded = false;
                                  });

                                  musicPlayer.musicPlayingTrue();

                                  loadAd();
                                },
                              );
                            },
                          ),
                          _BuyItem(
                            value: 1,
                            price: 1,
                            icon: Icons.favorite,
                            title: "1 heart",
                            btnText: "Watch Ad",
                            onClick: () {
                              musicPlayer.musicPlayingFalse();
                              _rewardedAd.show(
                                onUserEarnedReward: (ad, reward) {
                                  heartProvider.addHeart(1);
                                  adsWatched.increaseAdsWatched();
                                  setState(() {
                                    _isRewardedAdLoaded = false;
                                  });
                                  musicPlayer.musicPlayingTrue();
                                  loadAd();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const BuyCoins(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyCoins extends StatelessWidget {
  const BuyCoins({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void handleBuyCoins() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Coming Soon!"),
            content: Text("This feature is coming soon."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void handleBuyHearts() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Coming Soon!"),
            content: Text("This feature is coming soon."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: _BuyItem(
            value: 1,
            price: 2,
            icon: Icons.highlight_remove,
            title: 'Remove Ads',
            priceText: '2',
            btnText: 'Buy Now',
            onClick: handleBuyCoins,
          ),
        ),
        const SizedBox(height: 26),
        const Text(
          'Buy Coins',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _BuyItem(
                value: 100,
                price: 1,
                icon: Icons.monetization_on,
                title: "100 coins",
                priceText: "1",
                onClick: handleBuyCoins,
              ),
              _BuyItem(
                value: 500,
                price: 4,
                icon: Icons.monetization_on,
                title: "500 coins",
                priceText: "4",
                onClick: handleBuyCoins,
              ),
              _BuyItem(
                value: 1500,
                price: 10,
                icon: Icons.monetization_on,
                title: "1500 coins",
                priceText: "10",
                onClick: handleBuyCoins,
              ),
              _BuyItem(
                value: 3000,
                price: 15,
                icon: Icons.monetization_on,
                title: "3000 coins",
                priceText: "15",
                onClick: handleBuyCoins,
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Text(
          'Buy Hearts',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _BuyItem(
                value: 10,
                price: 1,
                icon: Icons.favorite,
                title: "10 hearts",
                priceText: "1",
                onClick: handleBuyHearts,
              ),
              _BuyItem(
                value: 50,
                price: 4,
                icon: Icons.favorite,
                title: "50 hearts",
                priceText: "4",
                onClick: handleBuyHearts,
              ),
              _BuyItem(
                value: 150,
                price: 10,
                icon: Icons.favorite,
                title: "150 hearts",
                priceText: "10",
                onClick: handleBuyHearts,
              ),
              _BuyItem(
                value: 300,
                price: 15,
                icon: Icons.favorite,
                title: "300 hearts",
                priceText: "15",
                onClick: handleBuyHearts,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuyItem extends StatelessWidget {
  final int value;
  final int price;
  final String? priceText;
  final IconData icon;
  final String title;
  final String? btnText;
  final VoidCallback onClick;

  const _BuyItem({
    Key? key,
    required this.value,
    required this.price,
    required this.icon,
    this.priceText,
    required this.title,
    required this.onClick,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.deepPurple,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    (priceText != null ? '\$$priceText' : "FREE"),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: Text(btnText != null ? btnText! : "Buy"),
            ),
          ],
        ),
      ),
    );
  }
}
