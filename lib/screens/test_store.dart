import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const Set<String> _kProductIds = {
  'coins_100_india_quiz',
  'coins_500_india_quiz',
  'coins_1500_india_quiz',
  'coins_3000_india_quiz',
};

class TestStore extends StatefulWidget {
  const TestStore({Key? key}) : super(key: key);

  @override
  _TestStoreState createState() => _TestStoreState();
}

class _TestStoreState extends State<TestStore> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
      print("error");
    });
    _initialize();
  }

  Future<void> _initialize() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      // The store cannot be reached or accessed, handle the error.
      print("error");
      return;
    }
    final ProductDetailsResponse productDetailsResponse =
        await InAppPurchase.instance.queryProductDetails(_kProductIds);
    if (productDetailsResponse.error != null) {
      // Handle the error.
      print("error");
      return;
    }
    final List<ProductDetails> products = productDetailsResponse.productDetails;
    for (var product in products) {
      // You can save the product details here
      print('Product ID: ${product.id}');
      print('Product title: ${product.title}');
      print('Product description: ${product.description}');
      print('Product price: ${product.price}');
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show pending dialog
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // handle error here.
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // handle success here.
          // _consumeProduct(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  // Future<void> _consumeProduct(PurchaseDetails purchase) async {
  //   if (purchase.status == PurchaseStatus.purchased) {
  //     await InAppPurchase.instance.consumePurchase(purchase);
  //   }
  // }

  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
