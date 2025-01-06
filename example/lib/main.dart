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
  showRewardedAd() {
    FlutterAdsRewarded.show(
        androidId: '',
        iosId: '',
        onUserEarnedReward: (view, item) {
          //TODO
        },
        onError: (e) {
          //TODO
        },
        onClose: () {
          //TODO
        });
  }

  showInterstitialAd() {
    FlutterAdsInterstitial.show(
        androidId: '',
        iosId: '',
        onError: (e) {
          //TODO
        },
        onClose: () {
          //TODO
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 24),
              const FlutterAdsBanner(
                iosId: '',
                androidId: '',
              ),
              const SizedBox(height: 24),
              const FlutterAdsNative(
                androidId: '',
                iosId: '',
                templateStyle: null,
                factoryId: null,
                constraints: null,
              ),
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
