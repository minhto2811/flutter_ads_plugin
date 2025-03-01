import 'dart:async';

import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlutterAdsInterstitial {
  static InterstitialAd? _ad;

  static Future<void> load({
    String? iosId,
    String? androidId,
  }) async {
    _ad = await AdModService().getInterstitialAd(
      iosId: iosId,
      androidId: androidId,
    );
  }

  static void release() => _ad?.dispose();

  static Future<bool> show() async {
    final completer = Completer<bool>();
    if (_ad == null) await load();
    if (_ad == null) completer.completeError('Ad is null');
    _ad?.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      completer.complete(true);
      load();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      completer.completeError('Ad failed to show: $error');
      load();
    });
    _ad?.show();
    return completer.future;
  }
}
