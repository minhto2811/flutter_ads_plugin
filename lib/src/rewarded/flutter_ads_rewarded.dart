import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admod_service.dart';

///Reward ad
class FlutterAdsRewarded {

  ///Preload ad:
  ///[Product] The parameters [iosId] or [androidId] are required in the production
  ///environment, depending on the target platform.
  ///[Debug] In the debug environment, you can choose to provide or omit the
  ///parameters, as they are already set with test IDs
  ///[Staging] In the staging environment, you need to manually set test IDs for each
  ///target platform. I have provided the IDs below; simply copy and set the appropriate one.
  ///[androidId] 'ca-app-pub-3940256099942544/5224354917'
  /// [iosId] 'ca-app-pub-3940256099942544/1712485313'
  static void init({
    String? iosId,
    String? androidId,
  }) {
    _iosId = iosId;
    _androidId = androidId;
    _load();
  }

  static String? _iosId;
  static String? _androidId;
  static RewardedAd? _ad;

  static Future<void> _load() async {
    _ad = await AdModService().getRewardedAd(
      androidId: _androidId,
      iosId: _iosId,
    );
  }

  ///Release Ad
  static void release() => _ad?.dispose();


  ///Show Ad
  static Future<bool> show(
      {required OnUserEarnedRewardCallback onUserEarnedReward}) async {
    final completer = Completer<bool>();
    if (_ad == null) await _load();
    if (_ad == null) completer.completeError('Ad is null');
    _ad?.fullScreenContentCallback = FullScreenContentCallback(
        onAdFailedToShowFullScreenContent: (ad, error) async {
      completer.completeError('Ad failed to show: $error');

      await ad.dispose();
      _load();
    }, onAdDismissedFullScreenContent: (ad) async {
      completer.complete(true);
      await ad.dispose();
      _load();
    });
    _ad?.show(onUserEarnedReward: onUserEarnedReward);
    return completer.future;
  }
}
