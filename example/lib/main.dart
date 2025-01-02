
import 'package:flutter/material.dart';
import 'package:flutter_ads/banner/flutter_ads_banner.dart';
import 'package:flutter_ads/native/flutter_ads_native.dart';
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


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FlutterAdsBanner(),
            FlutterAdsNative(),
          ],
        )
      ),
    );
  }
}
