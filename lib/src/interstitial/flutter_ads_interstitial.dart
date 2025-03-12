import 'dart:async';

import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

///Interstitial ad
class FlutterAdsInterstitial {

  ///Preload ad:
  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/1033173712'
  /// [iosId] 'ca-app-pub-3940256099942544/4411468910'
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

  ///Release ad
  static void release() => _ad?.dispose();


  ///Display ad
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
