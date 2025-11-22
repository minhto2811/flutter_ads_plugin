import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/flutter_ads_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterAdsInterstitial()
      ..init()
      ..load();
    FlutterAdsRewarded()
      ..init()
      ..load();
    FlutterAdsAppOpen.init(
        isShowWhenReady: true, shouldShowAdOnAppResume: true);
    super.initState();
  }

  @override
  void dispose() {
    FlutterAdsInterstitial().release();
    FlutterAdsRewarded().release();
    super.dispose();
  }

  showRewardedAd() {
    FlutterAdsRewarded().show(onUserEarnedReward: (view, item) {});
  }

  showInterstitialAd() {
    FlutterAdsInterstitial().show();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(
            children: [
              const SizedBox(height: 24),
              const FlutterAdsBanner(
                iosId: '',
                androidId: '',
              ),
              const SizedBox(height: 24),
              const FlutterAdsNative(),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: showRewardedAd,
                  child: const Text('Show Rewarded Ad')),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: showInterstitialAd,
                  child: const Text('Show Interstitial Ad')),
            ],
          )),
    );
  }
}
