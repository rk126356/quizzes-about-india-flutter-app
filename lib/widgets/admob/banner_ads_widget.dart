import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../providers/daily_login_provider.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  final AdSize _adSize = AdSize.banner;
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111' // replace with your actual Ad Unit ID for Android
      : 'ca-app-pub-3940256099942544/2934735716'; // replace with your actual Ad Unit ID for iOS

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      size: _adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print(error);
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ads = Provider.of<DailyLoginProvider>(context, listen: false);
    return SizedBox(
      height: _isBannerAdReady ? _adSize.height.toDouble() : 0,
      child: Center(
          child: ads.shouldShowAds
              ? _isBannerAdReady && !kIsWeb
                  ? AdWidget(ad: _bannerAd)
                  : const CircularProgressIndicator(
                      color: Colors.green,
                      backgroundColor: Colors.black,
                    )
              : const Text("Thanks for your support, all ads removed.")),
    );
  }
}
