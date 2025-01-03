

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admod_service.dart';


class FlutterAdsRewarded {
  static void show(
      {String? iosId,
      String? androidId,
      required OnUserEarnedRewardCallback onUserEarnedReward,
      required void Function(String) onError,
      required void Function() onClose}) async {
    try {
      final ad =
          await AdModService().getRewardedAd(iosId: iosId, androidId: androidId);
      if (ad == null) throw Exception('Ad is null');
      ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdFailedToShowFullScreenContent: (ad, error) {
            onError.call(error.toString());
            ad.dispose();
          },
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            onClose.call();
          });
      ad.show(onUserEarnedReward: onUserEarnedReward);
    } catch (e) {
      onError.call(e.toString());
    }
  }
}
