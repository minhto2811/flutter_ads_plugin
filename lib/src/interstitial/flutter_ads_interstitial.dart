import 'dart:async';

import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlutterAdsInterstitial {
  static void init({String? iosId, String? androidId}) {
    _iosId = iosId;
    _androidId = androidId;
    _load();
  }

  static InterstitialAd? _ad;
  static String? _iosId;
  static String? _androidId;

  static Future<void> _load() async {
    _ad = await AdModService().getInterstitialAd(
      iosId: _iosId,
      androidId: _androidId,
    );
  }

  static void release() => _ad?.dispose();

  static Future<bool> show() async {
    final completer = Completer<bool>();
    if (_ad == null) await _load();
    if (_ad == null) completer.completeError('Ad is null');
    _ad?.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      completer.complete(true);
      _load();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      completer.completeError('Ad failed to show: $error');
      _load();
    });
    _ad?.show();
    return completer.future;
  }
}
