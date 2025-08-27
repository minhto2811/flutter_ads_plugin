import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A utility class to handle App Open Ads in Flutter using Google Mobile Ads.
/// Supports loading, caching, and displaying ads when app is resumed.
class FlutterAdsAppOpen {
  /// Starts listening to app state changes to detect when app is resumed.
  /// Only active if `shouldShowAdOnAppResume` is true in `init()`.
  static void _listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  /// Handles app state changes. If app is brought to foreground, show ad.
  static void _onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      showAdIfAvailable();
    }
  }

  static String? _iosId; // Ad unit ID for iOS
  static String? _androidId; // Ad unit ID for Android
  static Duration _maxCacheDuration =
      const Duration(hours: 4); // Ad cache time limit
  static DateTime _appOpenLoadTime =
      DateTime.now(); // Time when ad was last loaded
  static bool _isDisposed = false;

  /// Initializes the App Open Ad module.
  /// [iosId] and [androidId] are required ad unit IDs.
  /// [androidId] 'ca-app-pub-3940256099942544/9257395921'
  /// [iosId] 'ca-app-pub-3940256099942544/5575463023'
  /// [isShowWhenReady]: If true, will show ad immediately once it's loaded.
  /// [maxCacheDuration]: Controls how long a loaded ad is considered fresh.
  /// [shouldShowAdOnAppResume]: If true, will auto-show ad on app resume.
  static FutureOr<void> init({
    String? iosId,
    String? androidId,
    bool isShowWhenReady = false,
    Duration maxCacheDuration = const Duration(hours: 4),
    bool shouldShowAdOnAppResume = false,
  }) async {
    _iosId = iosId;
    _androidId = androidId;
    _maxCacheDuration = maxCacheDuration;

    // Load ad initially
    await _loadAd();
    if (isShowWhenReady) showAdIfAvailable();

    // If enabled, listen to app lifecycle changes to show ad on resume
    if (shouldShowAdOnAppResume) _listenToAppStateChanges();
  }

  static void dispose() {
    _isDisposed = true;
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }

  static AppOpenAd? _appOpenAd; // Currently cached App Open Ad
  static bool _isShowingAd = false; // Whether an ad is currently being shown

  /// Checks if an ad is loaded and available to show.
  static bool get _isAdAvailable => _appOpenAd != null;

  /// Loads a new App Open Ad and updates the load timestamp.
  static Future<void> _loadAd() async {
    _appOpenAd = await AdModService().getAppOpenAd(
      iosId: _iosId,
      androidId: _androidId,
    );
    _appOpenLoadTime = DateTime.now();
  }

  /// Shows an App Open Ad if it's available and valid.
  /// Will also reload the ad if it's expired based on [_maxCacheDuration].
  static FutureOr<void> showAdIfAvailable() async {
    if (_isDisposed) return;
    if (!_isAdAvailable) {
      await _loadAd();
    }

    // Still not available after attempting to load
    if (!_isAdAvailable) return;

    // Prevent showing multiple ads at the same time
    if (_isShowingAd) return;

    // Check if cached ad is expired
    final isExpired =
        DateTime.now().subtract(_maxCacheDuration).isAfter(_appOpenLoadTime);
    if (isExpired) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      await _loadAd(); // Try loading a fresh ad
    }

    // Setup ad lifecycle callbacks
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;

        // Reload new ad for next time
        AdModService()
            .getAppOpenAd(iosId: _iosId, androidId: _androidId)
            .then((ad) => _appOpenAd = ad)
            .ignore();
      },
    );

    // Show the ad
    _appOpenAd?.show();
  }
}
