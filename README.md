# flutter_ads_plugin – Simple Google Ads for Flutter

## Quickly and easily integrate Google Ads with plugin!

flutter_ads_plugin is a Flutter plugin that allows you to deploy Google Ads in your application with just a few lines of code. No complex configuration needed.

## Key Features:

🚀 Quick Integration – Deploy ads in just a few minutes.

🎯 Optimized Display – Automatically adjusts ad position and type to fit.

🛠️ Easily Customizable – Supports various ad formats (Banner, Interstitial, Rewarded Ads).

## Why Choose flutter_ads_plugin?

Time-saving: Eliminates manual setup steps.

Simplified: Clean, easy-to-understand code, suitable for beginners.

## Demo

https://github.com/user-attachments/assets/11cc31ab-b149-4b0c-b0b3-71c90de8d139

## Setup

For instructions on how to use the plugin, please refer to the developer guides for [AdMob](https://developers.google.com/admob/flutter/quick-start) and [Ad Manager](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start).

## Example

```

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

```

