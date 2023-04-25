import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class TestStore extends StatefulWidget {
  const TestStore({Key? key}) : super(key: key);

  @override
  _TestStoreState createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
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

  bool _purchasePending = true;

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
            showSnackBar('Purchase Success');
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Store"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: _loading
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: _products.map((product) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(product.title),
                            subtitle: Text(product.description),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                final PurchaseParam purchaseParam =
                                    PurchaseParam(productDetails: product);
                                _inAppPurchase.buyConsumable(
                                    purchaseParam:
                                        purchaseParam); //buyNonConsumable to buy non-consumable products
                              },
                              child: Text(product.price),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
