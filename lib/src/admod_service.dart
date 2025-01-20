import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'constants.dart';

class AdModService {
  static final AdModService _instance = AdModService._internal();

  factory AdModService() => _instance;

  AdModService._internal();

  Future<BannerAd?> getBannerAd(
      {required BuildContext context, String? iosId, String? androidId}) async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate()) ??
        AdSize.banner;
    final adCompleter = Completer<Ad?>();
    BannerAd(
      adUnitId:
          AdModConstant().getBannerAdMobId(iosId: iosId, androidId: androidId),
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

  Future<InterstitialAd?> getInterstitialAd(
      {String? iosId, String? androidId}) async {
    final adCompleter = Completer<InterstitialAd>();
    InterstitialAd.load(
        adUnitId: AdModConstant().getInterstitialAdMobId(
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

  Future<RewardedAd?> getRewardedAd({
    String? iosId,
    String? androidId,
  }) async {
    final adCompleter = Completer<RewardedAd>();
    RewardedAd.load(
        adUnitId: AdModConstant().getRewardedAdMobId(
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

  Future<NativeAd?> getNativeAd({
    String? iosId,
    String? androidId,
    String? factoryId,
    NativeTemplateStyle? templateStyle,
    TemplateType? templateType,
  }) async {
    final adCompleter = Completer<Ad?>();
    NativeAd(
            adUnitId: AdModConstant().getNativeAdMobId(
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
                    templateType: templateType ?? TemplateType.small,
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
