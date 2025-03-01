import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admod_service.dart';

class FlutterAdsRewarded {
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

  static void release() => _ad?.dispose();

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
