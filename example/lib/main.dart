import 'package:flutter/material.dart';
import 'package:flutter_ads/banner/flutter_ads_banner.dart';
import 'package:flutter_ads/interstitial/flutter_ads_Interstitial.dart';
import 'package:flutter_ads/native/flutter_ads_native.dart';
import 'package:flutter_ads/rewarded/flutter_ads_rewarded.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
    FlutterAdsRewarded.show(onUserEarnedReward: (view,item){
      //TODO
    }, onError: (e){
      //TODO
    }, onClose: (){
      //TODO
    });
  }

  showInterstitialAd() {
    FlutterAdsInterstitial.show(onError: (e){
      //TODO
    }, onAdClosed: (){
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
              const FlutterAdsBanner(),
              const SizedBox(height: 24),
              const FlutterAdsNative(),
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
