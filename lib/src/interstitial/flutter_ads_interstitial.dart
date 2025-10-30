import 'dart:async';
import 'package:flutter_ads_plugin/src/admod_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A singleton service for managing Interstitial Ads.
/// Supports auto-preload, safe disposal, and retry on failure.
class FlutterAdsInterstitial {

  static FlutterAdsInterstitial? _instance;
  FlutterAdsInterstitial._internal();

  factory FlutterAdsInterstitial() {
    return _instance ??= FlutterAdsInterstitial._internal();
  }

  // --- Private state ---
  InterstitialAd? _ad;
  String? _iosId;
  String? _androidId;
  bool _isLoading = false;

  // --- Initialization ---
  Future<void> init({String? iosId, String? androidId}) async {
    _iosId = iosId;
    _androidId = androidId;
    await _load();
  }

  // --- Internal loader ---
  Future<void> _load() async {
    if (_isLoading) return;
    _isLoading = true;

    // Dispose old ad if any
    _ad?.dispose();
    _ad = null;

    try {
      _ad = await AdModService().getInterstitialAd(
        iosId: _iosId,
        androidId: _androidId,
      );
    } catch (e) {
      _ad = null;
    } finally {
      _isLoading = false;
    }
  }

  // --- Release all resources ---
  void release() {
    _ad?.dispose();
    _ad = null;
  }

  // --- Show ad safely ---
  Future<bool> show() async {
    final completer = Completer<bool>();

    // If ad not ready, reload
    if (_ad == null) await _load();

    // Still not ready after loading
    if (_ad == null) {
      completer.completeError('Ad failed to load or is null.');
      return completer.future;
    }

    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        completer.complete(true);
        _load(); // Preload next ad
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _ad = null;
        completer.completeError('Ad failed to show: $error');
        _load(); // Retry preload
      },
    );

    try {
      _ad!.show();
    } catch (e) {
      _ad = null;
      completer.completeError('Ad show error: $e');
      _load();
    }

    return completer.future;
  }

  // --- Check if ad is ready ---
  bool get isReady => _ad != null;
}
