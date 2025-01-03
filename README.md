# flutter_ads_plugin – Simple Google Ads for Flutter

## 🚀 Quickly and Easily Integrate Google Ads with Flutter!

`flutter_ads_plugin` is a Flutter plugin that enables seamless deployment of Google Ads in your app with minimal effort. No complex configurations required.

---  

## ✨ Key Features:

- **🚀 Quick Integration** – Deploy ads in just a few minutes.
- **🎯 Optimized Display** – Ads automatically adjust to the best position and type.
- **🛠️ Easily Customizable** – Supports multiple ad formats:
    - Banner Ads
    - Interstitial Ads
    - Rewarded Ads

---  

## ❓ Why Choose `flutter_ads_plugin`?

- **⏳ Time-Saving** – Skips manual setup steps.
- **🧩 Simplified** – Clean, easy-to-understand code, perfect for beginners.

---  

## 📽️ Demo

[Watch Demo](https://github.com/user-attachments/assets/11cc31ab-b149-4b0c-b0b3-71c90de8d139)

---  

## ⚙️ Setup

For detailed setup instructions, refer to the official guides:
- [AdMob Quick Start](https://developers.google.com/admob/flutter/quick-start)
- [Ad Manager Quick Start](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start)

---  

## 🧑‍💻 Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ads_plugin/flutter_ads_plugin.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void showRewardedAd() {
    FlutterAdsRewarded.show(
      onUserEarnedReward: (view, item) {
        // TODO: Handle reward
      },
      onError: (e) {
        // TODO: Handle error
      },
      onClose: () {
        // TODO: Handle ad close
      },
    );
  }

  void showInterstitialAd() {
    FlutterAdsInterstitial.show(
      onError: (e) {
        // TODO: Handle error
      },
      onAdClosed: () {
        // TODO: Handle ad close
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'),
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
              child: const Text('Show Rewarded Ad'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: showInterstitialAd,
              child: const Text('Show Interstitial Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
```  

---  

## 🤝 Contribute

We welcome community contributions. Feel free to submit pull requests or report issues.

---  

## 📄 License

MIT License – Free to use and modify as needed.

---  

**Made with ❤️ by mxgk**  
