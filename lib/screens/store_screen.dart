import 'dart:async';
import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:riddle/providers/heart_provider.dart';
import '../providers/coin_provider.dart';
import '../providers/daily_login_provider.dart';
import '../providers/purchase_value_provider.dart';
import '../providers/utils_provider.dart';
import '../widgets/appbar_actions_widget.dart';
import '../widgets/hint_answer_model_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late RewardedAd _rewardedAd;
  bool _isRewardedAdLoaded = false;
  bool hasInternet = false;

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
    '50_hearts_india_quiz',
    '150_hearts_india_quiz',
    '300_hearts_india_quiz',
  ];

  String? _queryProductError = "";
  bool _isAvailable = false;
  List<String> _notFoundIds = <String>[];
  bool _loading = true;
  bool _purchasePending = false;
  List currentValue = ["null", 0];

  @override
  void initState() {
    super.initState();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object e) {
      debugPrint("error :${e.toString()}");
    });

    initStoreInfo();

    checkInternetConnection();
    loadAd();
  }

  Future<void> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    });
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
        _loading = false;
      });
      return;
    }

    setState(() {
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _isAvailable = isAvailable;
      _loading = false;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((purchaseDetails) async {
      final value = Provider.of<PurchaseValueProvider>(context, listen: false);
      final hearts = Provider.of<HeartProvider>(context, listen: false);
      final coins = Provider.of<CoinProvider>(context, listen: false);
      final adsWatched =
          Provider.of<DailyLoginProvider>(context, listen: false);
      if (purchaseDetails.status == PurchaseStatus.pending) {
        value.setPurchasePending(true);
        setState(() {
          _purchasePending = true;
        });
      } else {
        value.setPurchasePending(false);
        setState(() {
          _purchasePending = false;
        });
        if (purchaseDetails.status == PurchaseStatus.error) {
          showSnackBar('Purchase Error');
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool validPurchase = await _verifyPurchase(purchaseDetails);
          if (validPurchase) {
            if (value.itemName == "Coins") {
              coins.addCoin(value.currentValue);
            }
            if (value.itemName == "Hearts") {
              hearts.addHearts(value.currentValue);
            }
            adsWatched.changeShouldShowAds(false);
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return HintAnswerScreen(
                  onNext: () {
                    Navigator.pop(context);
                  },
                  explanation: 'You have successfully completed the purchase.',
                  title: value.itemName == "Hearts"
                      ? 'WoW ❤+${value.currentValue}'
                      : 'WoW 💰+${value.currentValue}',
                  btnTitle: 'Nice!',
                );
              },
            );
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
        duration: const Duration(milliseconds: 1500),
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
    final value = Provider.of<PurchaseValueProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        actions: const [AppBarActions()],
      ),
      bottomSheet: value.purchasePending ? const BottomSheet() : null,
      body: SingleChildScrollView(
          child: hasInternet
              ? Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          ],
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
                      if (adsWatched.shouldShowAds)
                        const Text(
                          'ADS will be removed with any purchase',
                          style: TextStyle(
                            fontSize: 15,
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
                                value.setCurrentValue("Coins", 100);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[0]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              priceText: _products[6].price,
                              icon: Icons.monetization_on,
                              title: "500 coins",
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Coins", 500);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[6]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              priceText: _products[2].price,
                              icon: Icons.monetization_on,
                              title: "1500 coins",
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Coins", 1000);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[2]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              priceText: _products[4].price,
                              icon: Icons.monetization_on,
                              title: "3000 coins",
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Coins", 3000);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[4]);
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
                      if (adsWatched.shouldShowAds)
                        const Text(
                          'ADS will be removed with any purchase',
                          style: TextStyle(
                            fontSize: 15,
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
                              icon: Icons.favorite,
                              title: "10 Hearts",
                              priceText: _products[1].price,
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Hearts", 10);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[1]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              icon: Icons.favorite,
                              title: "50 Hearts",
                              priceText: _products[7].price,
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Hearts", 50);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[7]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              icon: Icons.favorite,
                              title: "150 Hearts",
                              priceText: _products[3].price,
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Hearts", 150);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[3]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                            _BuyItem(
                              icon: Icons.favorite,
                              title: "300 Hearts",
                              priceText: _products[5].price,
                              btnText: "Buy",
                              onClick: () async {
                                value.setCurrentValue("Hearts", 300);
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: _products[5]);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Center(
                      child: Text("Internet connection is required!",
                          style: TextStyle(color: Colors.red))),
                )),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Processing Your Purchase...',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey[400],
            thickness: 2,
            indent: 50,
            endIndent: 50,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(
              'Please do not close the app or go back while your purchase is being processed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 16,
              ),
            ),
          ),
        ],
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
