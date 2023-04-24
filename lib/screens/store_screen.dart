import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/heart_provider.dart';
import '../providers/coin_provider.dart';
import '../providers/daily_login_provider.dart';
import '../providers/questions_language_provider.dart';
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

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = <ProductDetails>[];

  final _productIdList = [
    '100_coins_india_quiz',
    '500_coins_india_quiz',
    '1500_coins_india_quiz',
    '3000_coins_india_quiz',
    '10_hearts_india_quiz',
    '150_hearts_india_quiz',
    '150_hearts_india_quiz',
    '300_hearts_india_quiz',
  ];

  String? _queryProductError = "";
  bool _isAvailable = false;
  List<String> _notFoundIds = <String>[];
  bool _loading = true;
  bool _purchasePending = true;
  List currentValue = ["null", 0];

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object e) {
      debugPrint("error :${e.toString()}");
    });
    loadAd();
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _notFoundIds = <String>[];
        _loading = false;
      });
      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_productIdList.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _notFoundIds = productDetailResponse.notFoundIDs;
        print('_notFoundIds :: ${_notFoundIds.toList()}');
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _notFoundIds = productDetailResponse.notFoundIDs;
        print("Products details empty");
        print('_notFoundIds : ${_notFoundIds.toList()}');
        print('productDetailResponse error :: ${productDetailResponse.error}');
        _loading = false;
      });
      return;
    }

    setState(() {
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _isAvailable = isAvailable;
      print('_notFoundIds : ${_notFoundIds.toList()}');
      _loading = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() {
          _purchasePending = true;
        });
      } else {
        setState(() {
          _purchasePending = false;
        });
        if (purchaseDetails.status == PurchaseStatus.error) {
          showSnackBar('Purchase Error');
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool validPurchase = await _verifyPurchase(purchaseDetails);
          if (validPurchase) {
            // ignore: use_build_context_synchronously
            final hearts = Provider.of<HeartProvider>(context, listen: false);
            // ignore: use_build_context_synchronously
            final coins = Provider.of<CoinProvider>(context, listen: false);

            if (currentValue[0] == "Coins") coins.addCoin(currentValue[1]);
            if (currentValue[0] == "Hearts") hearts.addHearts(currentValue[1]);

            await _inAppPurchase.completePurchase(purchaseDetails);
          } else {
            showSnackBar('Invalid Purchase');
            await _inAppPurchase.completePurchase(purchaseDetails);
          }
        }
      }
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
// TODO: Implement server-side validation of the purchase.
    return true;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
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
              if (_isRewardedAdLoaded && adsWatched.adsWatched < 5)
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
                            icon: Icons.monetization_on,
                            title: "5 coins",
                            btnText: "Watch Ad",
                            onClick: () {
                              if (musicPlayer.isMusicTurnedOn) {
                                musicPlayer.musicPlayingFalse();
                              }
                              _rewardedAd.show(
                                onUserEarnedReward: (ad, reward) {
                                  coinsprovider.addCoin(5);
                                  adsWatched.increaseAdsWatched();
                                  setState(() {
                                    _isRewardedAdLoaded = false;
                                  });

                                  if (musicPlayer.isMusicTurnedOn) {
                                    musicPlayer.musicPlayingTrue();
                                  }
                                  loadAd();
                                },
                              );
                            },
                          ),
                          _BuyItem(
                            icon: Icons.favorite,
                            title: "1 heart",
                            btnText: "Watch Ad",
                            onClick: () {
                              if (musicPlayer.isMusicTurnedOn) {
                                musicPlayer.musicPlayingFalse();
                              }
                              _rewardedAd.show(
                                onUserEarnedReward: (ad, reward) {
                                  heartProvider.addHeart(1);
                                  adsWatched.increaseAdsWatched();
                                  setState(() {
                                    _isRewardedAdLoaded = false;
                                  });
                                  if (musicPlayer.isMusicTurnedOn) {
                                    musicPlayer.musicPlayingTrue();
                                  }
                                  loadAd();
                                },
                              );
                            },
                          ),
                        ],
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
                            priceText: _products[0].price,
                            icon: Icons.monetization_on,
                            title: "100 coins",
                            btnText: "Buy",
                            onClick: () async {
                              currentValue = ["Coins", 100];
                              final PurchaseParam purchaseParam =
                                  PurchaseParam(productDetails: _products[0]);
                              _inAppPurchase.buyConsumable(
                                  purchaseParam:
                                      purchaseParam); //buyNonConsumable to buy non-consumable products
                            },
                          ),
                          _BuyItem(
                            priceText: _products[3].price,
                            icon: Icons.monetization_on,
                            title: "500 coins",
                            btnText: "Buy",
                            onClick: () async {
                              currentValue = ["Coins", 500];
                              final PurchaseParam purchaseParam =
                                  PurchaseParam(productDetails: _products[3]);
                              _inAppPurchase.buyConsumable(
                                  purchaseParam:
                                      purchaseParam); //buyNonConsumable to buy non-consumable products
                            },
                          ),
                          _BuyItem(
                            priceText: _products[1].price,
                            icon: Icons.monetization_on,
                            title: "1000 coins",
                            btnText: "Buy",
                            onClick: () async {
                              currentValue = ["Coins", 1000];

                              final PurchaseParam purchaseParam =
                                  PurchaseParam(productDetails: _products[1]);
                              _inAppPurchase.buyConsumable(
                                  purchaseParam:
                                      purchaseParam); //buyNonConsumable to buy non-consumable products
                            },
                          ),
                          _BuyItem(
                            priceText: _products[2].price,
                            icon: Icons.monetization_on,
                            title: "3000 coins",
                            btnText: "Buy",
                            onClick: () async {
                              currentValue = ["Coins", 3000];

                              final PurchaseParam purchaseParam =
                                  PurchaseParam(productDetails: _products[2]);
                              _inAppPurchase.buyConsumable(
                                  purchaseParam:
                                      purchaseParam); //buyNonConsumable to buy non-consumable products
                            },
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
                            icon: Icons.monetization_on,
                            title: "5 coins",
                            btnText: "Watch Ad",
                            onClick: () {
                              if (musicPlayer.isMusicTurnedOn) {
                                musicPlayer.musicPlayingFalse();
                              }
                              _rewardedAd.show(
                                onUserEarnedReward: (ad, reward) {
                                  coinsprovider.addCoin(5);
                                  adsWatched.increaseAdsWatched();
                                  setState(() {
                                    _isRewardedAdLoaded = false;
                                  });

                                  if (musicPlayer.isMusicTurnedOn) {
                                    musicPlayer.musicPlayingTrue();
                                  }
                                  loadAd();
                                },
                              );
                            },
                          ),
                          _BuyItem(
                            icon: Icons.favorite,
                            title: "1 heart",
                            btnText: "Watch Ad",
                            onClick: () {},
                          ),
                          _BuyItem(
                            icon: Icons.favorite,
                            title: "1 heart",
                            btnText: "Watch Ad",
                            onClick: () {},
                          ),
                          _BuyItem(
                            icon: Icons.favorite,
                            title: "1 heart",
                            btnText: "Watch Ad",
                            onClick: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuyItem extends StatelessWidget {
  final String? priceText;
  final IconData icon;
  final String title;
  final String? btnText;
  final VoidCallback onClick;

  const _BuyItem({
    Key? key,
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
                    (priceText != null ? '$priceText' : "FREE"),
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
