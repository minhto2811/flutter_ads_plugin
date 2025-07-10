import 'dart:io';

import 'package:flutter/foundation.dart';

class AdModConstant {
  static final _instance = AdModConstant._internal();
  factory AdModConstant() => _instance;

  AdModConstant._internal();

  String getAppOpenAdMobId({String? iosId, String? androidId}) => _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/9257395921',
        kDebugIosId: 'ca-app-pub-3940256099942544/5575463023',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  String getRewardedAdMobId({String? iosId, String? androidId}) => _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/5224354917',
        kDebugIosId: 'ca-app-pub-3940256099942544/1712485313',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  String getInterstitialAdMobId({String? iosId, String? androidId}) =>
      _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/1033173712',
        kDebugIosId: 'ca-app-pub-3940256099942544/4411468910',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  String getBannerAdMobId({String? iosId, String? androidId}) => _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/6300978111',
        kDebugIosId: 'ca-app-pub-3940256099942544/2934735716',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  String getNativeAdMobId({String? iosId, String? androidId}) => _initAdModId(
        kDebugAndroidId: 'ca-app-pub-3940256099942544/2247696110',
        kDebugIosId: 'ca-app-pub-3940256099942544/3986624511',
        kReleaseAndroidId: androidId ?? '',
        kReleaseIosId: iosId ?? '',
      );

  String _initAdModId({
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
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return kDebugAndroidId;
      } else if (Platform.isIOS) {
        return kDebugIosId;
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }
}
