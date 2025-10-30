import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admod_service.dart';
class FlutterAdsRewarded {
  FlutterAdsRewarded._internal();
  static FlutterAdsRewarded? _instance;

  factory FlutterAdsRewarded() {
    return _instance ??= FlutterAdsRewarded._internal();
  }

  String? _iosId;
  String? _androidId;
  RewardedAd? _ad;
  bool _loading = false;

  Future<void> init({String? iosId, String? androidId}) async {
    _iosId = iosId;
    _androidId = androidId;
    await _load();
  }

  Future<void> _load() async {
    if (_loading) return;
    _loading = true;

    try {
      _ad = await AdModService().getRewardedAd(
        androidId: _androidId,
        iosId: _iosId,
      );
    } catch (e) {
      _ad = null;
    } finally {
      _loading = false;
    }
  }

  void release() => _ad?.dispose();

  Future<bool> show({required OnUserEarnedRewardCallback onUserEarnedReward}) async {
    final completer = Completer<bool>();

    if (_ad == null && !_loading) {
      await _load();
    }

    if (_ad == null) {
      completer.completeError('Ad is not available');
      return completer.future;
    }

    _ad?.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, error) async {
        completer.completeError('Ad failed to show: $error');
        await ad.dispose();
        await _load();
      },
      onAdDismissedFullScreenContent: (ad) async {
        completer.complete(true);
        await ad.dispose();
        await _load();
      },
    );

    _ad?.show(onUserEarnedReward: onUserEarnedReward);
    return completer.future;
  }
}
