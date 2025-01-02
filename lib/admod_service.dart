import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdModService {
  static Future<BannerAd?> getBannerAd(
      {required BuildContext context, String? iosId, String? androidId}) async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate()) ??
        AdSize.banner;
    final adCompleter = Completer<Ad?>();
    BannerAd(
      adUnitId:
          AdModConstant.getBannerAdMobId(iosId: iosId, androidId: androidId),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: adCompleter.complete,
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          adCompleter.completeError(error);
        },
      ),
    ).load();
    final bannerAd = await adCompleter.future;
    return bannerAd as BannerAd?;
  }

  static Future<InterstitialAd?> getInterstitialAd(
      {String? iosId, String? androidId}) async {
    final adCompleter = Completer<InterstitialAd>();
    InterstitialAd.load(
        adUnitId: AdModConstant.getInterstitialAdMobId(
          androidId: androidId,
          iosId: iosId,
        ),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: adCompleter.complete,
          onAdFailedToLoad: adCompleter.completeError,
        ));
    return await adCompleter.future;
  }

  static Future<RewardedAd?> getRewardedAd({
    String? iosId,
    String? androidId,
  }) async {
    final adCompleter = Completer<RewardedAd>();
    RewardedAd.load(
        adUnitId: AdModConstant.getRewardedAdMobId(
          androidId: androidId,
          iosId: iosId,
        ),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: adCompleter.complete,
          onAdFailedToLoad: adCompleter.completeError,
        ));
    return await adCompleter.future;
  }

  static Future<NativeAd?> getNativeAd({
    String? iosId,
    String? androidId,
    String? factoryId,
    NativeTemplateStyle? templateStyle,
  }) async {
    final adCompleter = Completer<Ad?>();
    NativeAd(
            adUnitId: AdModConstant.getNativeAdMobId(
              androidId: androidId,
              iosId: iosId,
            ),
            factoryId: factoryId ?? '',
            listener: NativeAdListener(
                onAdLoaded: adCompleter.complete,
                onAdClosed: (ad) {
                  ad.dispose();
                },
                onAdFailedToLoad: (ad, error) {
                  ad.dispose();
                  adCompleter.completeError(error);
                }),
            request: const AdRequest(),
            nativeTemplateStyle: templateStyle ??
                NativeTemplateStyle(
                    // Required: Choose a template.
                    templateType: TemplateType.medium,
                    // Optional: Customize the ad's style.
                    mainBackgroundColor: Colors.purple,
                    cornerRadius: 10.0,
                    callToActionTextStyle: NativeTemplateTextStyle(
                        textColor: Colors.cyan,
                        backgroundColor: Colors.red,
                        style: NativeTemplateFontStyle.monospace,
                        size: 16.0),
                    primaryTextStyle: NativeTemplateTextStyle(
                        textColor: Colors.red,
                        backgroundColor: Colors.cyan,
                        style: NativeTemplateFontStyle.italic,
                        size: 16.0),
                    secondaryTextStyle: NativeTemplateTextStyle(
                        textColor: Colors.green,
                        backgroundColor: Colors.black,
                        style: NativeTemplateFontStyle.bold,
                        size: 16.0),
                    tertiaryTextStyle: NativeTemplateTextStyle(
                        textColor: Colors.brown,
                        backgroundColor: Colors.amber,
                        style: NativeTemplateFontStyle.normal,
                        size: 16.0)))
        .load();
    final nativeAd = await adCompleter.future;
    return nativeAd as NativeAd?;
  }
}

class AdModConstant {
  static String getRewardedAdMobId({String? iosId, String? androidId}) =>
      _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/5224354917',
        kDebugIosId: 'ca-app-pub-3940256099942544/1712485313',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  static String getInterstitialAdMobId({String? iosId, String? androidId}) =>
      _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/1033173712',
        kDebugIosId: 'ca-app-pub-3940256099942544/4411468910',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  static String getBannerAdMobId({String? iosId, String? androidId}) =>
      _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/6300978111',
        kDebugIosId: 'ca-app-pub-3940256099942544/2934735716',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  static String getNativeAdMobId({String? iosId, String? androidId}) =>
      _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/2247696110',
        kDebugIosId: 'ca-app-pub-3940256099942544/3986624511',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  static String _initAdModId({
    required String kDebugIosId,
    required String kDebugAndroidId,
    required String kReleaseIosId,
    required String kReleaseAndroidId,
  }) {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return kReleaseAndroidId;
      } else if (Platform.isIOS) {
        return kReleaseIosId;
      } else {
        throw UnsupportedError("Unsupport platform");
      }
    } else {
      if (Platform.isAndroid) {
        return kDebugAndroidId;
      } else if (Platform.isIOS) {
        return kDebugIosId;
      } else {
        throw UnsupportedError("Unsupport platform");
      }
    }
  }
}
