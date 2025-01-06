# flutter_ads_plugin – Simple Google Ads for Flutter

![Leonardo_Phoenix_10_A_modern_sleek_mobile_application_screensh_2](https://github.com/user-attachments/assets/b3d6968e-c2a0-4b60-aef8-ae706809baa7)

## 🚀 Quickly and Easily Integrate Google Ads with Flutter!

`flutter_ads_plugin` is a Flutter plugin that enables seamless deployment of Google Ads in your app
with minimal effort. No complex configurations required.

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

## 📦 Installation

Add the plugin to your `pubspec.yaml` file:

```yaml
fire_auth_quick: <latest-version>
```  

Then run:

```bash
flutter pub get
```

---

## ⚙️ Configuration

For detailed setup instructions, refer to the official guides:

- [AdMob Quick Start](https://developers.google.com/admob/flutter/quick-start)
- [Ad Manager Quick Start](https://developers.google.com/ad-manager/mobile-ads-sdk/flutter/quick-start)

---  

## 🧑‍💻 Example

```dart
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

```  

--- 

## 📝 API Reference

| Function               | Description                                                             |
|------------------------|-------------------------------------------------------------------------|
| **onUserEarnedReward** | Callback triggered when the user earns a reward from a rewarded ad.     |                         |
| **onError**            | Callback triggered when an error occurs during ad loading or rendering. |                         |
| **onClose**            | Callback triggered when the ad is closed by the user.                   |

| Setter            | Description                                      |
|-------------------|--------------------------------------------------|
| **androidId**     | Identifier for **Android** configurations.       |
| **iosId**         | Identifier for **iOS** configurations.           |
| **factoryId**     | Unique ID for the ad **factory** instance.       |
| **templateStyle** | Defines the **visual style** of the ad template. |
| **constraints**   | Layout **constraints** for rendering the ad.     |

---  

## 🎥 [YouTube Video Guide](https://youtu.be/TEYG8qtimOY?si=sqm2jT0xGG4Qzfdg)

For a detailed guide on how to integrate and use the Ad Plugin, check out the video tutorial.

---

## 🤝 Contribute

We welcome community contributions. Feel free to submit pull requests or report issues.

---  

## 📄 License

MIT License – Free to use and modify as needed.

---  

**Made with ❤️ by mxgk**  
