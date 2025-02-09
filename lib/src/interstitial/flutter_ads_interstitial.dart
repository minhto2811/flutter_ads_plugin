import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class FlutterAdsInterstitial {
  static Future<void> show(
      {String? iosId,
      String? androidId,
      required void Function(String) onError,
      required void Function() onClose}) async {
    try {
      final ad = await AdModService().getInterstitialAd(
        iosId: iosId,
        androidId: androidId,
      );
      if (ad == null) throw Exception('Ad is null');
      ad.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        onClose.call();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        onError.call(error.message);
      });
      ad.show();
    } catch (e) {
      onError.call(e.toString());
    }
  }
}
